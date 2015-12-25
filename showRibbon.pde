// showRibbon.pde
// procedures related to the ribbon interface

void showRibbon() {  
  noStroke(); // No stroke for ribbon
  fill( 230, 237, 237 );
  rect( 0, 0, 800, 70 );  // Ribbon
  stroke( 150 );
  strokeWeight( 1 );
  line( 0, 70, 800, 70 );  // Bottom-line of ribbon
  
  ////////////////////////////////////////////////////////////////////////////
  // SAVE & OPEN
  ////////////////////////////////////////////////////////////////////////////
  // save button hovered
  if ( mouseX >= 4 && mouseX <= 74 && mouseY >= 10 && mouseY <= 33 ) {
    fill( 240 );
    stroke( #79ADFF );
    rect( 4, 10, 70, 23 );
  } else if ( mouseX >= 4 && mouseX <= 74 && mouseY >= 34 && mouseY <= 56 ) {
    fill( 240 );
    stroke( #79ADFF );
    rect( 4, 34, 70, 23 );
  }
  
  // 'save' icon
  img = loadImage( "Save-icon.png" );
  image( img, 8, 12 );
  fill( 20 );
  text( "Save As", 30, 27 );
  
  // 'open' icon
  img = loadImage( "Open-icon.png" );
  image( img, 8, 36 );
  text( "Open", 30, 51 );
  
  //** Tool/option group divider between save&open and color
  stroke( 189, 193, 193 );
  strokeWeight( 1 );
  line( 80, 0, 80, 70 );
  
  ////////////////////////////////////////////////////////////////////////////
  // COLOR OPTION
  ////////////////////////////////////////////////////////////////////////////
  fill( selectedColor );
  stroke( 255 );
  rect( 90, 15, 40, 25 );
  fill( 20 );
  text( "Color", 98, 55 );
  
  // when mouse hovered a certain color, highlight it
  for ( int i = 0; i < 12; i++ ) {
    if ( (mouseX >= (138+i*18) && mouseX <= (154+i*18) && mouseY >= 8 && mouseY <= 24) ) {
      fill( #A7EDFF );
      stroke( #17CFFF );
    } else {
      fill( 255 );
      stroke( 200 );
    }
    rect( 138+i*18, 8, 16, 16 );
    
    if ( (mouseX >= (138+i*18) && mouseX <= (154+i*18) && mouseY >= 25 && mouseY <= 41) ) {
      fill( #A7EDFF );
      stroke( #17CFFF );
    } else {
      fill( 255 );
      stroke( 200 );
    }
    rect( 138+i*18, 25, 16, 16 );
    
    if ( (mouseX >= (138+i*18) && mouseX <= (154+i*18) && mouseY >= 42 && mouseY <= 58) ) {
      fill( #A7EDFF );
      stroke( #17CFFF );
    } else {
      fill( 255 );
      stroke( 200 );
    }
    rect( 138+i*18, 42, 16, 16 ); 
  }
  
  // display colors
  for ( int i = 0; i < 12; i++ ) {
    fill( colors[i] );
    stroke( colors[i] );
    rect( 140+i*18, 10, 12, 12 );
    
    fill( colors[i+12] );
    stroke( colors[i+12] );
    rect( 140+i*18, 27, 12, 12 );
    
    fill( colors[i+24] );
    stroke( colors[i+24] );
    rect( 140+i*18, 44, 12, 12 ); 
  }
  
  //** Tool/option group divider
  stroke( 189, 193, 193 );
  strokeWeight( 1 );
  line( 362, 0, 362, 70 );
  
  ////////////////////////////////////////////////////////////////////////////
  // CLEAR CANVAS OPTION
  //////////////////////////////////////////////////////////////////////////// 
  // Clear option hovered
  if ( mouseX >= 363 && mouseX <= 412 && mouseY <= 70 ) {
    noStroke();
    fill( 240 );
    rect( 363, 0, 50, 70 );
  }
  
  stroke( 200 );
  fill( 255 );
  rect( 372, 10, 30, 30 );
  fill( 20 );
  text( "Clear", 374, 55 );
  line( 378, 15, 396, 35 );
  line( 396, 15, 378, 35 );
  
  stroke( 189, 193, 193 );  // Tool/option group divider
  strokeWeight( 1 );
  line( 412, 0, 412, 70 );
  
  ////////////////////////////////////////////////////////////////////////////
  // TOOL BOX
  //////////////////////////////////////////////////////////////////////////// 
  // When a tool hovered, highlight it
  stroke( #79ADFF );
  fill( 240 );
  if ( tool == "line" || (mouseX >= 422 && mouseX <= 442 && mouseY >= 10 && mouseY <= 30) ) 
    rect( 422, 10, 20, 20 );
  
  if ( tool == "eraser" || (mouseX >= 447 && mouseX <= 467 && mouseY >= 10 && mouseY <= 30) )
    rect( 447, 10, 20, 20 );
    
  if ( tool == "select" || (mouseX >= 422 && mouseX <= 442 && mouseY >= 34 && mouseY <= 54) )
    rect( 422, 34, 20, 20 );
    
  if ( tool == "selectPolygon" || (mouseX >= 447 && mouseX <= 467 && mouseY >= 34 && mouseY <= 54) )
    rect( 447, 34, 20, 20 );
  
  // line tool icon
  fill( #DEEBFF );
  line( 425, 13, 439, 27 );
  
  // eraser tool icon
  img = loadImage( "Eraser-icon.png" );
  image( img, 449, 12 );
  
  // rectangular selection tool icon
  img = loadImage( "Select-icon.png" );
  image( img, 425, 37 );
  
  // polygon selection tool icon
  img = loadImage( "Select-pl-icon.png" );
  image( img, 451, 37 );
}

// event handler when elements in the ribbon clicked
void showRibbonClicked() {
  // Save button clicked
  if ( mouseX >= 4 && mouseX <= 74 && mouseY >= 10 && mouseY <= 33 ) {
    saveDotLines();
  } else if ( mouseX >= 4 && mouseX <= 74 && mouseY >= 34 && mouseY <= 56 ) {
    showOpenDialog();
  }
  
  ////////////////////////////////////////////////////////////////////////////
  // COLOR OPTION
  ////////////////////////////////////////////////////////////////////////////
  for ( int i = 0; i < 12; i++ ) {
    if ( (mouseX >= (138+i*18) && mouseX <= (154+i*18) && mouseY >= 8 && mouseY <= 24) )
      selectedColor = colors[i];
    else if ( (mouseX >= (138+i*18) && mouseX <= (154+i*18) && mouseY >= 25 && mouseY <= 41) )
      selectedColor = colors[i+12];
    else if ( (mouseX >= (138+i*18) && mouseX <= (154+i*18) && mouseY >= 42 && mouseY <= 58) )
      selectedColor = colors[i+24];
    
    lines.lColor = selectedColor;
  }
  
  ////////////////////////////////////////////////////////////////////////////
  // CLEAR CANVAS OPTION
  ////////////////////////////////////////////////////////////////////////////
  if ( mouseX >= 363 && mouseX <= 412 && mouseY <= 70 ) {
    lines.clear();
    clippedLines.clear();
    polygon = new Point[50];
    np = 0;
    tmpPolygon = new Point[50];
    tmpNp = 0;
    polygonFinished = false;
    
    pg.background( 255 );
  }
  
  ////////////////////////////////////////////////////////////////////////////
  // TOOL BOX
  //////////////////////////////////////////////////////////////////////////// 
  if ( mouseX >= 422 && mouseX <= 442 && mouseY >= 10 && mouseY <= 30 ) {
    tool = "line";
    restoreDrawing( false ); // needed to hide the clipped lines/dots
  }
  
  if ( mouseX >= 447 && mouseX <= 467 && mouseY >= 10 && mouseY <= 30 ) {
    tool = "eraser";
    restoreDrawing( false ); // needed to hide the clipped lines/dots
  }
    
  if ( mouseX >= 422 && mouseX <= 442 && mouseY >= 34 && mouseY <= 54 ) {
    if ( tool != "select" ) restoreDrawing( false ); // needed to hide the clipped lines/dots
    tool = "select";
  }
    
  if ( mouseX >= 447 && mouseX <= 467 && mouseY >= 34 && mouseY <= 54 ) {
    if ( tool != "selectPolygon" ) restoreDrawing( false ); // needed to hide the clipped lines/dots
    tool = "selectPolygon";
  }
}
