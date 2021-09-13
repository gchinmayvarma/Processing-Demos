PShape s ; 

void setup() {
  size(500, 500);
  ss() ;
}
void draw() {  
  background(50);
  fill(200, 0, 0) ; 
  stroke(0, 200, 0); 
  shape(s, mouseX, mouseY) ;
}
void ss() { 
  s = createShape(GROUP) ;
  PShape i1, i2, i3, i4 ; 
  i1 = createShape( ELLIPSE, 150, 250, 70, 70 ) ; 
  i2 = createShape() ; 
  i2.beginShape();
  i2.vertex(475, 250);
  i2.vertex(125, 300);
  i2.vertex(50, 475);
  i2.vertex(475, 250);
  i2.vertex(125, 200);
  i2.vertex(50, 25);
  i2.endShape(CLOSE) ;
  i3 = createShape( RECT, 325, 225, 25, 50 ) ;
  i4 = createShape( RECT, 200, 200, 50, 100 ) ;
  s.addChild(i4) ; 
  s.addChild(i3) ;
  s.addChild(i2) ;
  s.addChild(i1) ;
}
