// patternLine.pde
// Taken from a Processing old Forum website
// patternLine() is used only when drawing clipped dots/lines

// based on Bresenham's algorithm from wikipedia
// http://en.wikipedia.org/wiki/Bresenham's_line_algorithm

void patternLine(int xStart, int yStart, int xEnd, int yEnd, int linePattern, int lineScale) {
  int temp, yStep, x, y;
  int pattern = linePattern;
  int carry;
  int count = lineScale;
  
  boolean steep = (abs(yEnd - yStart) > abs(xEnd - xStart));
  if (steep == true) {
    temp = xStart;
    xStart = yStart;
    yStart = temp;
    temp = xEnd;
    xEnd = yEnd;
    yEnd = temp;
  }    
  if (xStart > xEnd) {
    temp = xStart;
    xStart = xEnd;
    xEnd = temp;
    temp = yStart;
    yStart = yEnd;
    yEnd = temp;
  }
  int deltaX = xEnd - xStart;
  int deltaY = abs(yEnd - yStart);
  int error = - (deltaX + 1) / 2;
  
  y = yStart;
  if (yStart < yEnd) {
    yStep = 1;
  } else {
    yStep = -1;
  }
  for (x = xStart; x <= xEnd; x++) {
    if ((pattern & 1) == 1) {
  if (steep == true) {
    pg.point(y, x);
  } else {
    pg.point(x, y);
  }
  carry = 0x8000;
    } else {
  carry = 0;
    }  
    count--;
    if (count <= 0) {
  pattern = (pattern >> 1) + carry;
  count = lineScale;
    }
    
    error += deltaY;
    if (error >= 0) {
  y += yStep;
  error -= deltaX;
    }
  }
}
