ArrayList<lining> l ;
void setup() {
  size(500, 500) ;
  l = new ArrayList<lining>() ;
}
void draw() {
  background(120) ; 
  for ( lining ll : l ) {
    ll.display() ;
  }
}
class lining {
  float x, y, px, py, w ; 
  color c ; 
  lining(float px_, float py_) { 
    c = color(20, 50, 255) ; 
    x = y = 0 ;
    w = 5 ; 
    px = px_ ; 
    py = py_ ;
  }
  void display() {
    stroke(c) ;
    strokeWeight(w) ; 
    line(x, y, px, py) ;
  }
  void setxy( float x_, float y_ ) {
    x = x_ ; 
    y = y_ ;
  }
}
void mousePressed() {
  l.add( new lining(mouseX, mouseY) ) ; 
  l.get(l.size()-1).setxy(mouseX, mouseY) ;
}
void mouseDragged() {
  l.get(l.size()-1).setxy(mouseX, mouseY) ;
}
