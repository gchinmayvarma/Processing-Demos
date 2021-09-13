void setup() { 
  size( 200, 140 ) ;
}
void draw() { 
  background(0) ; 
  noStroke() ; 
  fill( 155, 0, 255, 50 ) ; 
  circle(width/2, height/2, 100) ; 
  fill(255) ; 
  float theta, r = 50 ; 
  for ( int i = 0; i < 60; i++ ) { 
    theta = i*TWO_PI/60 ;
    circle(width/2 + r*cos(theta), height/2 + r*sin(theta), 2) ;
  }
  fill(255, 0, 155 ) ; 
  r = 75 ; 
  for ( int i = 0; i < 60; i++ ) { 
    theta = i*TWO_PI/60 ;
    if ( ( i > 55 || i < 5 ) || ( i < 35 && i > 25 ) ) 
      circle(width/2 + r*cos(theta), height/2 + r*sin(theta), 2) ;
  }
  stroke(255, 0, 155 ) ;  
  circle( width/2, height/2, 10 ) ; 
  theta = 30*TWO_PI/360 ;
  r = 10 ; 
  float s = 40 ; 
  line( width/2 - s, height/2, width/2 - s + r*cos(theta), height/2 - r*sin(theta) ) ; 
  line( width/2 - s, height/2, width/2 - s + r*cos(theta), height/2 + r*sin(theta) ) ; 

  line( width/2 + s, height/2, width/2 + s - r*cos(theta), height/2 - r*sin(theta) ) ; 
  line( width/2 + s, height/2, width/2 + s - r*cos(theta), height/2 + r*sin(theta) ) ;
}
void mousePressed() {
  save("c:\\Users\\Chinmay\\Desktop\\Thumbnail.png");
}
