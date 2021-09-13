Pendulum p ; 

void setup() { 
  size( 400, 400 ) ; 
  p = new Pendulum( width/2, 100, 150) ;
} 

void draw() { 
  background(50) ; 
  p.all() ;
  if (mousePressed) {
    float d =  dist( mouseX, mouseY, p.o.x + p.l*sin(p.a), p.o.y + p.l*cos(p.a) )  ; 
    if ( d < p.r ) { 
      p.hold = true ;
    }
  } else p.refresh() ;
}
