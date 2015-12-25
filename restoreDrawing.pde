// restoreDrawing.pde

// Clear canvas and draw needed objects
void restoreDrawing( boolean clipped ) {
  pg.background( 255 );    // Reset drawing area
  
  // Draw saved lines
  lines.drawLines();
  
  // Draw clipped lines
  if ( clipped ) {    
    pg.fill(255);
    pg.stroke(0);
    pg.beginShape();
      for ( int i = 0; i < np; i++ ) {
        pg.vertex( polygon[i].x, polygon[i].y );
      }
    pg.endShape(CLOSE);
    
    clippedLines.drawDashedLines();
    clippedLines.clear();
    
    //print( polygonFinished + "\n" );
    np = 0;
  }
  
  // Draw polygon
  if ( tool == "selectPolygon" ) {
    // Draw saved temporary polygon clipping window
    pg.stroke( 0 );
    if ( !polygonFinished ) {
      for ( int i = 1; i < tmpNp; i++ ) {
        pg.line( tmpPolygon[i-1].x, tmpPolygon[i-1].y, tmpPolygon[i].x, tmpPolygon[i].y );
      }
    }
    
    //print( polygonFinished + "\n" );
  }
}
