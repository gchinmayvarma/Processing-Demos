int z = 10 ; 
void setup() { 
  fullScreen() ; //size(300 , 300) ; 
  stroke(20) ;
  strokeWeight(5) ;
  background(200) ;
  frameRate(1000) ; 
}

void draw() { 
  fill(200,20) ; 
  rect( 0, 0, width, height ) ; 
  translate( width/2, height/2 ) ;
  for ( int i = 0; i < z; i++ ) { 
    rotate(TWO_PI/z) ; 
    line( width/2 - mouseX , height/2 - mouseY, width/2 - pmouseX, height/2 - pmouseY ) ;
  }
}
