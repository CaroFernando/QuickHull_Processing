void sortPoints(ArrayList<point> arr) {
  for (int i = 0; i < arr.size(); i++) {
    for (int j = 0; j < arr.size(); j++) {
      if (arr.get(i).x < arr.get(j).x) {
        point temp = arr.get(i);
        arr.set(i, arr.get(j));
        arr.set(j, temp);
      }
    }
  }
}

float pointSide(point a, point b, point c) {
    return ((b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x));
}

float distPointLine(point A, point B, point C) {
    float a = B.y - A.y, b = B.x - A.x;
    return abs((a*C.x - b*C.y + B.x*A.y - B.y*A.x)/sqrt(a*a + b*b));
}

float distance(point A, point B){
  return sqrt((A.x-B.x)*(A.x-B.x) + (A.y-B.y)*(A.y-B.y));
}
