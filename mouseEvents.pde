// mouseEvents.pde
// functions that are called when user do a specific action by using mouse

void mousePressed() {
  // As start point in drawing object
  x01 = mouseX;
  y01 = mouseY - 71;
  
  // Hide the status info "done saving" from status bar
  if ( isDoneSaving ) isDoneSaving = false;
}

void mouseReleased() {
  if ( y01 >= 0  && y01 <= 410 && mouseButton == LEFT ) { // When will we draw on canvas?
    ribbonOn = true;
    
    x02 = mouseX;
    y02 = mouseY - 71;
    //pg.strokeWeight( lineSize );
    pg.stroke( selectedColor );
    
    if ( tool == "line" ) {      
      // Save the created line
      lines.insertFirst( x01, y01, x02, y02 );
    } else if ( tool == "select" ) {
      pg.noFill();
      pg.stroke( 0 );
      if ( abs(x01-x02) > 0 && abs(y01-y02) > 0 ) {
        if ( x02 >= x01 && y01 <= y02 ) {
          polygon[0] = new Point(x01, y01);
          polygon[1] = new Point(x02, y01);
          polygon[2] = new Point(x02, y02);
          polygon[3] = new Point(x01, y02);
        } else if ( x02 < x01 && y01 <= y02 ) {
          polygon[0] = new Point(x02, y01);
          polygon[1] = new Point(x01, y01);
          polygon[2] = new Point(x01, y02);
          polygon[3] = new Point(x02, y02);
        } else if ( x02 >= x01 && y01 > y02 ) {
          polygon[0] = new Point(x01, y02);
          polygon[1] = new Point(x02, y02);
          polygon[2] = new Point(x02, y01);
          polygon[3] = new Point(x01, y01);
        } else if ( x02 < x01 && y01 > y02 ) {
          polygon[0] = new Point(x01, y01);
          polygon[1] = new Point(x02, y01);
          polygon[2] = new Point(x02, y02);
          polygon[3] = new Point(x01, y02);
        }
        pg.stroke( selectedColor );
        //polygon[0].displayPoint();
        //polygon[1].displayPoint();
        //polygon[2].displayPoint();
        //polygon[3].displayPoint();
        np = 4;
        //print( "\n" );
        //print( isInsidePolygon( 100, 200, polygon, np ) + " " + np + "\n" );
        
        Line l     = lines.first,
             lTemp = null;
        while( l != null ) {
          lTemp = CyrusBeckClipping( l, polygon, np );
          if ( lTemp != null ) {
            clippedLines.insertFirst( lTemp );
            //print( "Clip OK\n" );
          }
            
          l = l.next;
        }
        restoreDrawing( true );
      } else restoreDrawing( false );
    } else if ( tool == "selectPolygon" ) {
      if ( drawnByDragged ) {
        tmpPoint = new Point( x02, y02 );
        tmpPolygon[tmpNp] = tmpPoint;
        tmpNp++;
        
        drawnByDragged = false;
      }
      
      if ( mouseEvent.getClickCount() == 2 ) {
        if ( tmpNp > 2 ) {
          if ( isConvexPolygon( tmpPolygon, tmpNp ) ) { 
            np = tmpNp;
            for ( int i = 0; i < np; i++ ) {
              polygon[i] = tmpPolygon[i];
            }
            
            Line l     = lines.first,
                 lTemp = null;
            while( l != null ) {
              lTemp = CyrusBeckClipping( l, polygon, np );
              if ( lTemp != null ) {
                clippedLines.insertFirst( lTemp );
                //print( "Clip OK\n" );
              }
                
              l = l.next;
            }
            //print( "np=" + np + "\n" );
            polygonFinished = true;
            restoreDrawing( true );
            
            tmpNp = 0;
            tmpPolygon = new Point[50];
          } else {
            JOptionPane.showMessageDialog(null, "Polygon is not convex!", "ERROR!", JOptionPane.ERROR_MESSAGE);
            tmpNp = 0;
            tmpPolygon = new Point[50];
            restoreDrawing( false );
            polygonFinished = true;
          }
        } else {
          JOptionPane.showMessageDialog(null, "A polygon consist of at least 3 vertices!", "ERROR!", JOptionPane.ERROR_MESSAGE);
          tmpNp = 0;
          tmpPolygon = new Point[50];
          restoreDrawing( false );
        }
      }
    }
  }
}

void mouseDragged() {
  if ( y01 >= 0  && y01 <= 410 && mouseButton == LEFT  ) {  // When will we draw on canvas?
    ribbonOn = false;
    
    x02 = mouseX;
    y02 = mouseY - 71;
      
    if ( tool == "line" ) {
      int dXdY;
      restoreDrawing( false );
      pg.stroke( selectedColor );
      
      pg.line( x01, y01, x02, y02 );
    } else if ( tool == "select" ) {
      restoreDrawing( false );
      pg.noFill();
      pg.stroke( 0 );
      if ( x02 >= x01 && y01 <= y02 )
        pg.rect( x01, y01, abs(x01-x02), abs(y01-y02) );
      else if ( x02 < x01 && y01 <= y02 )
        pg.rect( x02, y01, abs(x01-x02), abs(y01-y02) );
      else if ( x02 >= x01 && y01 > y02 )
        pg.rect( x01, y02, abs(x01-x02), abs(y01-y02) );
      else if ( x02 < x01 && y01 > y02 )
        pg.rect( x02, y02, abs(x01-x02), abs(y01-y02) );
      pg.stroke( selectedColor );
    } else if ( tool == "selectPolygon" ) {
      restoreDrawing( false );
      drawnByDragged = true;
      if ( tmpNp >= 1 ) {
        pg.stroke( 0 );
        pg.line( tmpPolygon[tmpNp-1].x, tmpPolygon[tmpNp-1].y, x02, y02 );
      } else {
        polygonFinished = false;
        tmpPoint = new Point( x01, y01 );
        tmpPolygon[0] = tmpPoint;
        tmpNp++;
      }
    }
  }
}

void mouseClicked() {  
  if ( mouseButton == LEFT ) showRibbonClicked();
  if ( mouseY > 70 && mouseY <= 480 && mouseButton == LEFT ) {
    if ( tool == "line" )
      restoreDrawing( false );
    else if ( tool == "eraser" ) {      
      Line aLine = lines.findLinePassesPoint( mouseX, (mouseY - 71) );
      if ( aLine != null )
          lines.delete( aLine );
      restoreDrawing( false );
    } else if ( tool == "selectPolygon" && mouseEvent.getClickCount() != 2 ) {
      if ( polygonFinished && np == 0 ) {
        polygonFinished = false;
        restoreDrawing( false );
      }
      
      tmpPoint = new Point( mouseX, (mouseY - 71) );
      
      tmpPolygon[tmpNp] = tmpPoint;
      tmpNp++;
      
      //print( "tmpNp=" + tmpNp + "\n" );
      
      pg.stroke( 0 );
      for ( int i = 1; i < tmpNp; i++ ) {
        pg.line( tmpPolygon[i-1].x, tmpPolygon[i-1].y, tmpPolygon[i].x, tmpPolygon[i].y );
      }
    }
  }
}
