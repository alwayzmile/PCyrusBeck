// statusBar.pde
// Status bar area from (0, 480)-(800, 500)

void statusBar() {
  fill( #D1D1D1 );
  noStroke();
  rect( 0, 483, 800, 17 );
  
  strokeWeight( 2 );
  stroke( #B2B4B4 );
  line( 0, 481, 800, 481 );  // Separator between canvas and status bar
  
  // Show mouseX and mouseY position in canvas area
  fill( 20 );
  stroke( 1 );
  if ( mouseY > 70 && mouseY <= 480 )
    text( "(x,y): " + mouseX + "," + (mouseY-71), 5, 494 );
  
  if ( isDoneSaving )
    text( "Done saving dots/lines", 100, 494 );  
  else {
    fill( 50 );
    if ( mouseY > 70 && mouseY <= 480 && tool == "line" )
      text( "One left-click to draw a dot. Left-click drag and drop to draw a line.", 100, 494 );
    else if ( mouseY > 70 && mouseY <= 480 && tool == "eraser" )
      text( "Left-click on a dot/line to erase a certain dot/line.", 100, 494 );
    else if ( mouseY > 70 && mouseY <= 480 && tool == "select" ) {
      if ( lines.isEmpty() ) text( "No dots or lines to be clipped", 100, 494 );
      else text( "Left-click drag and drop to draw a rectangular clipping window.", 100, 494 );
    } if ( mouseY > 70 && mouseY <= 480 && tool == "selectPolygon" ) {
      if ( lines.isEmpty() ) 
        text( "No dots or lines to be clipped.", 100, 494 );
      else if ( tmpNp < 3 )
        text( "A single click to draw a vertex on polygon. Click drag and drop to draw from a vertex to the next vertex.", 100, 494 );
      else
        text( "Double left-click on the last vertex position to finish drawing clipping window.", 100, 494 );
    }
    
    // "CLEAR CANVAS" tool in the ribbon hovered
    if ( mouseX >= 363 && mouseX <= 412 && mouseY <= 70 ) {
      text( "Clear canvas", 5, 494 );
    
    // "DOT/LINE DRAWING" tool in the ribbon hovered
    } else if ( mouseX >= 422 && mouseX <= 442 && mouseY >= 10 && mouseY <= 30 ) {
      text( "Dot/Line drawing tool", 5, 494 );
      
    // "DOT/LINE ERASER" tool in the ribbon hovered
    } else if ( mouseX >= 447 && mouseX <= 467 && mouseY >= 10 && mouseY <= 30 ) {
      text( "Dot/Line eraser tool", 5, 494 );
      
    // "RECTANGULAR SELECTION" tool in the ribbon hovered
    } else if ( mouseX >= 422 && mouseX <= 442 && mouseY >= 34 && mouseY <= 54 ) {
      text( "Rectangular (clipping window) selection", 5, 494 );
    
    // "POLYGON SELECTION" tool in the ribbon hovered
    } else if ( mouseX >= 447 && mouseX <= 467 && mouseY >= 34 && mouseY <= 54 ) {
      text( "Polygon (clipping window) selection", 5, 494 );
    }
  }
}
