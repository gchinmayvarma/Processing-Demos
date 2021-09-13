Particle p ; 
void setup() { 
  fullScreen() ; 
  p = new Particle( width/2, height/2, color(200, 0, 200, 200), 50, 0) ; 
  noStroke() ;
  background(50) ;
} 

void draw() { 
  fill(50) ; 
  rect(0, 0, width, height) ; 
  p.update() ; 
  p.display() ;
}

void mousePressed() { 
  if ( p.free ) { 
    p.bind( 200, p.vel.heading(), 0.051 ) ; 
    p.piv.set( width/2, height/2 ) ;
  } else p.free = true ;
} 
