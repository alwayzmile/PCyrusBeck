// cyrusBeck.pde
// cyrus beck clipping algorithm and some functions/procedures related to it

Line CyrusBeckClipping( Line ll, Point[] p, int ne ) {
  Line temp = null;  // Line to be returned
  Point ixPoint = null, ixPoint2 = null;  // Intersection point
  
  // Point clipping
  if ( ll.isDot() ) {
    //print( "Is dot inside: " + isInsidePolygon(ll.s.x, ll.s.y, p, ne) + "\n" );
    if ( isInsidePolygon(ll.s.x, ll.s.y, p, ne) ) {
      temp = new Line( ll.s.x, ll.s.y, ll.p.x, ll.p.y );
    } else
      return null;
  
  // Totally Accepted
  } else if ( isInsidePolygon(ll.s.x, ll.s.y, p, ne) && isInsidePolygon(ll.p.x, ll.p.y, p, ne) ) {
    temp = new Line( ll.s.x, ll.s.y, ll.p.x, ll.p.y );
    
  // Partially Accepted
  } else if ( isInsidePolygon(ll.s.x, ll.s.y, p, ne) && !isInsidePolygon(ll.p.x, ll.p.y, p, ne) ) {
    for ( int i = 0, iNext; i < ne; i++ ) {
      iNext = (i+1) % ne;
      
      if ( doLineIntersect(ll.s, ll.p, p[i], p[iNext]) ) {
        ixPoint = getIntersectionPoint( ll.s, ll.p, p[i], p[iNext] );
        
        if ( isLineSegmentIntersection(ixPoint, ll.s, ll.p, p[i], p[iNext]) ) {
          temp = new Line( ll.s.x, ll.s.y, ixPoint.x, ixPoint.y );
          break;
        }
      }
    }
  
  // Both endpoints are outside the polygon
  } else {
    boolean rightNorm = isUseRightNormal( p, ne );
    
    for ( int i = 0, iNext, iNext2; i < ne; i++ ) {
      iNext = (i+1) % ne;
      iNext2 = (iNext + 1) % ne;
      
      if ( isTriviallyRejected( ll.s, ll.p, p[i], p[iNext], rightNorm ) ) {
        //print( "TRIVIALLY REJECTED\n" );
        
        return null;
      }
    }
    
    float t, maxE = 0, minL = 1; // Maximum enter and minimum leave;
    int D, tmpX, tmpY;
    Vector normal = null;
    
    for ( int i = 0, iNext, iNext2; i < ne; i++ ) {
      iNext = (i+1) % ne;
      iNext2 = (iNext + 1) % ne;
      
      normal = getNormalVector(p[i], p[iNext]);
      if ( rightNorm ) normal = normal.rightNormal();
      else normal = normal.leftNormal();
      
      // D = (B-A) . N
      D = dotProduct( new Vector( ll.s.x-ll.p.x, ll.s.y-ll.p.y ), normal );
      // t = ((A-P) . N) / (-(B-A) . N)
      t = dotProduct( new Vector( ll.p.x-p[i].x, ll.p.y-p[i].y ), normal ) / (float)-(D);
      
      //print( "D=" + D + "\n" );
      //print( "t=" + t + "\n" );
      
      if ( D >= 0 ) maxE = max(t, maxE); // Entering
      else minL = min(minL, t);          // Leaving
    }
    
    // Rejected
    if ( maxE > minL ) {
      //print( "REJECTED " );
      //print( "maxE=" + maxE + ", minL=" + minL + "\n" );
      return null;
    
    // Trivially accepted
    } else {
      //print( "maxE=" + maxE + ", minL=" + minL + "\n" );
      
      // Line from maxE to minL (from point ixPoint to ixPoint2)
      // C = L(t) = A + t(B-A)
      // x = xA + t(xB-xA)
      // y = yA + t(xB-xA)
      tmpX = round(ll.s.x + (ll.s.x - ll.p.x) * maxE) + ll.p.x-ll.s.x;
      tmpY = round(ll.s.y + (ll.s.y - ll.p.y) * maxE) + ll.p.y-ll.s.y;
      ixPoint = new Point(tmpX, tmpY);
      tmpX = round(ll.s.x + (ll.s.x - ll.p.x) * minL) + ll.p.x-ll.s.x;
      tmpY = round(ll.s.y + (ll.s.y - ll.p.y) * minL) + ll.p.y-ll.s.y;
      ixPoint2 = new Point(tmpX, tmpY);
      
      //ixPoint.displayPoint();
      //ixPoint2.displayPoint();
      temp = new Line( ixPoint.x, ixPoint.y, ixPoint2.x, ixPoint2.y );
    }
  }
  
  if ( temp != null ) {
    temp.lColor = ll.lColor;
  }
  return temp;
}

boolean isTriviallyRejected( Point P1, Point P2, Point A1, Point A2, boolean isRightDir ) {
  int temp1, temp2;
  Vector normal = getNormalVector(A1, A2);
  
  if ( isRightDir ) normal = normal.rightNormal();
  else normal = normal.leftNormal();
  
  temp1 = dotProduct( new Vector(P1.x-A1.x, P1.y-A1.y), normal );
  temp2 = dotProduct( new Vector(P2.x-A1.x, P2.y-A1.y), normal );
  
  return temp1<0 && temp2<0;
}

/**
 * Check whether an intersection point between line A and B is
 * a point in line segment A and B
 * @X the intersection point to be checked
 * @A1 starting point of line A
 * @A2 end point of line A
 * @B1 starting point of line B
 * @B2 end point of line B
 */
boolean isLineSegmentIntersection( Point X, Point A1, Point A2, Point B1, Point B2 ) {
  return (X.x <= max(A1.x, A2.x)) && (X.x >= min(A1.x, A2.x)) &&
         (X.y <= max(A1.y, A2.y)) && (X.y >= min(A1.y, A2.y)) &&
         (X.x <= max(B1.x, B2.x)) && (X.x >= min(B1.x, B2.x)) &&
         (X.y <= max(B1.y, B2.y)) && (X.y >= min(B1.y, B2.y));
}

boolean doLineIntersect( Point A1, Point A2, Point B1, Point B2 ) {
  if ( A1 == null || A2 == null || B1 == null || B2 == null ) return false;
  
  if ( A1.x == A2.x ) {
    return !( (B1.x == B2.x) && (A1.x != B1.x) );
  } else if ( B1.x == B2.x ) {
    return true;
  } else {
    float m1 = (A1.y - A2.y) / (float)(A1.x - A2.x);
    float m2 = (B1.y - B2.y) / (float)(B1.x - B2.x);
    
    return m1 != m2;
  }
}

Point getIntersectionPoint ( Point A1, Point A2, Point B1, Point B2 ) {
  int a1, a2, b1, b2, c1, c2, x, y, det;
  a1 = A2.y - A1.y;
  b1 = A1.x - A2.x;
  c1 = a1*A1.x + b1*A1.y;
  
  a2 = B2.y - B1.y;
  b2 = B1.x - B2.x;
  c2 = a2*B1.x + b2*B1.y;
   
  det = a1*b2 - a2*b1;
  x = round((b2*c1 - b1*c2) / (float)det);
  y = round((a1*c2 - a2*c1) / (float)det);
  
  return new Point( x, y );
}
