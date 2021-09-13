
float speed = 10 ;
Star[] stars = new Star[400] ; 

void setup() { 
  fullScreen() ; // size( 300, 300 ) ; 
  for ( int i = 0; i < stars.length; i++ ) { 
    stars[i] = new Star() ;
  }
  stroke(255) ; 
  
}

void draw() { 
  background(3) ; 
  //speed = map( mouseX , 0 , width , 0 , 20 ) ; 
  translate( mouseX , mouseY ) ; 
  for ( int i = 0; i < stars.length; i++ ) { 
    stars[i].update() ; 
    stars[i].show() ;
  }
}
void mousePressed() { 
  speed++ ; 
} 
