ArrayList<point> pts = new ArrayList();
ArrayList<point> hull = new ArrayList();

boolean ok = true;

void qHull(ArrayList<point> arr, point A, point B) { 
  
  if (arr.size() == 0)
    return;

  int idx = 0;
  float dist = distPointLine(A, B, arr.get(0));
  for (int i=1; i< arr.size(); i++) {
    if (distPointLine(A, B, arr.get(i)) > dist) {
      dist = distPointLine(A, B, arr.get(i));
      idx = i;
    }
  }

  hull.add(arr.get(idx));

  ArrayList<point> R = new ArrayList();
  ArrayList<point> T = new ArrayList();

  for (int i=0; i<arr.size(); i++) {
    if (i != idx) {
      float tmp = pointSide(A, arr.get(idx), arr.get(i));
      
      if (tmp >= 0) R.add(arr.get(i));
      else {
        tmp = pointSide(arr.get(idx), B, arr.get(i));
        if (tmp >= 0)
          T.add(arr.get(i));
      }
    }
  }
  
  qHull(R, A, arr.get(idx));
  qHull(T, arr.get(idx), B);
}

// ---------------

void findHull() {
  ok = false;
  sortPoints(pts);

  hull.add(pts.get(0));
  hull.add(pts.get(pts.size()-1));

  ArrayList<point> L = new ArrayList();
  ArrayList<point> R = new ArrayList();
  ArrayList<point> O = new ArrayList();

  for (int i=1; i < pts.size()-1; i++) {
    float tmp = pointSide(pts.get(0), pts.get(pts.size()-1), pts.get(i));
    if (tmp < 0) R.add(pts.get(i));
    else if (tmp > 0) L.add(pts.get(i));
    else O.add(pts.get(i));
  }

  if (L.size() == 0 || R.size() == 0)
    for (int i=0; i < O.size(); i++)
      hull.add(O.get(i));

  qHull(L, pts.get(0), pts.get(pts.size()-1));
  qHull(R, pts.get(pts.size()-1), pts.get(0));
  
  ok = true;
}


void mousePressed() {
  if (mouseButton == LEFT) pts.add(new point(mouseX, mouseY));
  if (mouseButton == RIGHT){
    if(ok){
      while(hull.size() > 0) hull.remove(0);
      thread("findHull");
    }
  }
}

void setup() {
  size(800, 600);
}

void draw() {
  background(71);
  noStroke();

  for (point p : pts) {
    fill(255);
    ellipse(p.x, p.y, 10, 10);
  }
  
  if(hull.size() > 0 && ok){
    for (point p : hull){
       fill(255,0,0);
       
       ellipse(p.x, p.y, 10, 10);
    }
  }
}
