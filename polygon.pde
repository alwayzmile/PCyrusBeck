// polygon.pde
// functions related to operations with polygon

boolean isInsidePolygon( int xa, int ya, Point[] p, int ne ) {
  int iNext, iNext2;
  int FQ;  // F(Q)=(Q-P).N
  Vector normal = null,  // normal and QminP for calculation "F(Q)=(Q-P).N"
         QminP = null;
  
  for ( int i = 0; i < ne; i++ ) {
    iNext = (i+1) % ne;
    iNext2 = (iNext + 1) % ne;
    
    normal = getNormalVector( p[i], p[iNext] );
    if ( isUseRightNormal(p, ne) ) normal = normal.rightNormal();
    else normal = normal.leftNormal();
    
    QminP = new Vector( xa-p[i].x, ya-p[i].y );
    FQ = dotProduct( QminP, normal );
    //print( "np = " + np + ", FQ=" + FQ + "\n" );
    
    if ( FQ < 0 ) return false;
  }
  
  return true;
}

boolean isConvexPolygon( Point[] p, int ne ) {
  int dx1, dy1, dx2, dy2, zcrossproduct;
  boolean isPositive = false;
  int iNext, iNext2;
  
  for ( int i = 0; i < ne; i++ ) {
    // Need to check the direction of the line drawing
    iNext = (i+1) % ne;
    iNext2 = (iNext + 1) % ne;
    
    dx1 = p[iNext].x - p[i].x;
    dy1 = p[iNext].y - p[i].y;
    dx2 = p[iNext2].x - p[iNext].x;
    dy2 = p[iNext2].y - p[iNext].y;
    
    zcrossproduct = dx1*dy2 - dy1*dx2;
    
    if ( i == 0 ) isPositive = (zcrossproduct > 0);
    else {
      if ( isPositive != (zcrossproduct > 0) ) return false;
    }
  }
  
  return true;
}

boolean isUseRightNormal( Point[] p, int ne ) {
  Vector normal = getNormalVector( p[0], p[1] );
  normal = normal.rightNormal();
  
  //F(Q) = (Q-P).N
  int FQ = dotProduct( new Vector( p[2].x-p[1].x, p[2].y-p[1].y ), normal );
  
  return FQ >= 0;
}
