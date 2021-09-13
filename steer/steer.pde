PVector mouse = new PVector() ; 
Ster s ; 
void setup() {
  size(640 , 360) ; 
  s = new Ster() ; 
  noStroke() ;
}

void draw() {
  //background(50) ;
  fill(50, 120) ;
  rect(0 , 0 , width , height ) ; 
  mouse.set( mouseX , mouseY ) ; 
  s.seek( mouse ) ; 
  s.updot() ; 
  s.show() ; 
}
