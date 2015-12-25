// openSaveFile.pde
// procedures related to open saved dots/lines and exporting dots/lines into a file

void saveDotLines() {
  FileDialog save = new FileDialog((java.awt.Frame) null, "Save dots/lines as...", 1); // mode 1 = SAVE, 0 = OPEN
  save.setVisible(true);
  
  if ( save.getFile() != null ) {
    PrintWriter output = createWriter( save.getDirectory() + save.getFile() );
    Line temp = lines.first;
    
    while ( temp != null ) {
      output.println( temp.s.x + "," + temp.s.y + "," + temp.p.x + "," + temp.p.y + "," + temp.lColor );
      temp = temp.next;
    }
    output.flush();
    output.close();
    
    isDoneSaving = true;
  }
}

void showOpenDialog() {
  selectInput( "Open saved dots/lines", "openSavedDotLines" );
}

void openSavedDotLines( File input ) {
  if ( input != null ) {
    try {
      String dotLines[] = loadStrings( input.getAbsolutePath() );
      lines.clear();
      
      for ( int i = 0; i < dotLines.length; i++ ) {
        String xy[] = split(dotLines[i], ",");
        
        lines.lColor = color(int(xy[4]));
        lines.insertFirst( int(xy[0]), int(xy[1]), int(xy[2]), int(xy[3]) );
      }
      restoreDrawing(false);
    } catch ( Exception e ) {
      JOptionPane.showMessageDialog(null, input.getName() + " is not a valid file", "ERROR!", JOptionPane.ERROR_MESSAGE);
    }
  }
}
