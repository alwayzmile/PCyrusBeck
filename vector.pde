// vector.pde
// vector data structure and some functions related to it

class Vector
{
  public int x, y;
  
  public Vector ( int xx, int yy ) {
    x = xx;
    y = yy;
  }
  
  public void displayVector() {
    print( "(" + x + "," + y + ")" );
  }

  Vector rightNormal() {
    return new Vector( -y, x );
  }
  
  Vector leftNormal() {
    return new Vector( y, -x );
  }
}

Vector getNormalVector ( Point a, Point b ) {
  return new Vector( b.x-a.x, b.y-a.y );
}

int dotProduct( Vector A, Vector B ) {
  return ( A.x*B.x + A.y*B.y );
}
