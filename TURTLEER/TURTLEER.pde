Turtle[] turtles = new Turtle[9] ; 
float sep ; 
void setup() { 
  size( 400, 400 ) ; 
  background(50) ; 
  if ( width < height)  sep = width ;
  else sep = height ; 
  sep /= 10 ; 
  for ( int i = 1; i <= 9; i++ ) { 
    turtles[i - 1] = new Turtle( sep, i*sep) ;
  }
}
void draw() {
  table() ;
}
void table() { 
  for ( Turtle t : turtles ) {
    if ( t.y > height - sep ) { 
      continue ;
    }
    if ( t.x > width - sep ) { 
      t.gotoxy( height - t.y, width - t.x ) ;
      t.rt(90) ;
    } else t.fd(3) ;
  }
}
