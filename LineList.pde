// LineList.pde
// point and dot/line data structures

class Point
{
  public int x, y;
  
  public Point( int xa, int ya ) {
    x = xa;
    y = ya;
  }
  
  public boolean isEqual( Point a ) {
    return ((x == a.x) && (y == a.y));
  }
  
  public void displayPoint() {
    print( "(" + x + "," + y + ")" );
  }
}

class Line
{
  // s is the Start Point
  // p is the End Point
  public Point s, p;
  public color lColor;
  public Line next;
  
  public Line( int x1, int y1, int x2, int y2 ) {
    // s.x = x1;
    // s.y = y1;
    // p.x = x2;
    // p.y = y2;
    s = new Point( x1, y1 );
    p = new Point( x2, y2 );
  }
  
  public boolean isDot() {
    return ( s.isEqual(p) );
  }
  
  public boolean isPassesPoint( int xa, int ya ) {
    if ( !isDot() ) {
      if ( s.x == xa ) return ( xa == p.x );
      if ( s.y == ya ) return ( ya == p.y );
      
      if ( abs(s.y - p.y) > abs(s.x - p.x) ) {
        int z = round(s.x + ((p.x - s.x) / (float)(p.y - s.y)) * (ya - s.y));
        return ( z == xa );
      } else {
        int z = round(s.y + ((p.y - s.y) / (float)(p.x - s.x)) * (xa - s.x));
        return ( z == ya );
      }
    } else 
      return ( (xa == s.x) && (ya == s.y) );
  }
  
  public boolean isEqual( Line a ) {
    return ( s.isEqual(a.s) && p.isEqual(a.p) );
  }
  
  
  public void displayLinePoints() {
    print( "{" );
    s.displayPoint();
    print( ", " );
    p.displayPoint();
    print( "} " );
  }
}

class LineList
{
  public Line first;
  public color lColor = color(0);
  
  public LineList() {
    first = null;
  }
  
  public boolean isEmpty() {
    return ( first == null );
  }
  
  public void insertFirst( int x1, int y1, int x2, int y2 ) {
    Line newLine = new Line( x1, y1, x2, y2 );
    newLine.lColor = lColor;
    newLine.next = first;
    first = newLine;
  }
  
  public void insertFirst( Line ll ) {
    Line newLine = new Line( ll.s.x, ll.s.y, ll.p.x, ll.p.y );
    newLine.lColor = ll.lColor;
    newLine.next = first;
    first = newLine;
  }
  
  public Line delete( Line a ) {
    Line current = first;
    Line previous = first;
    
    if ( isEmpty() ) return null;
    
    while ( !current.isEqual(a) ) {
      if ( current.next == null )
        return null;
      else {
        previous = current;
        current = current.next;
      }
    }
    
    if ( current == first ) 
      first = first.next;
    else
      previous.next = current.next;
    
    return current;
  }
  
  public Line findLinePassesPoint( int xa, int ya ) {
    Line current = first;
    
    while ( current != null ) {
      if ( current.isPassesPoint( xa, ya ) )
        return current;
      current = current.next;
    }
    
    return null;
  }
  
  public void drawLines() {
    Line current = first;   
    while ( current != null ) {
      pg.stroke( current.lColor );
      pg.line( current.s.x, current.s.y, current.p.x, current.p.y );
      
      current = current.next;
    }
  }
  
  // edited drawLines method to draw clipped dots/lines
  public void drawDashedLines() {
    Line current = first;   
    while ( current != null ) {
      pg.stroke( current.lColor );
      
      if ( current.isDot() ) {
        pg.strokeWeight( 2 );
        pg.point( current.s.x, current.s.y );
        pg.strokeWeight( 1 );
      }
      else patternLine( current.s.x, current.s.y, current.p.x, current.p.y, 0x5555, 3 );
      
      current = current.next;
    }
  }
  
  public void clear() {
    first = null;
  }
}