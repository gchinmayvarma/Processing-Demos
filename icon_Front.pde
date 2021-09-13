void setup() { 
  size(256, 256) ; 
  background(10, 10, 14) ;
  //frameRate(2400) ;
}

void draw() { 
  fill(10, 10, 14, 10) ; 
  rect( 0, 0, width, height) ;
  float s, h ; 
  pushMatrix() ; 
  s = 60; 
  h = 0.866*s ;
  translate( width/2, height/2 ) ;
  fill(10,10,14 ,50) ;
  triangle( 0, -h, -s, h, s, h ) ;
  popMatrix()  ;
  for ( int i = 0; i < 500; i++ ) {
    pushMatrix() ;
    translate( random(width), random(height) ) ;
    rotate( random(TWO_PI) ) ; 
    s = random(3); 

    fill(random(255), random(255) ) ; 
    noStroke() ; 
    if (random(100) < 10) { 
      //s = random(30) ;   
      fill(random(255), 0, random(255), random(100)) ;
    }
    if (random(100) < 0.3 ) fill(255, 0, 69) ; 
    if (random(100) < 0.5 ) { 
      fill(10, 10, 14) ;
    }
    h = 0.866*s ;
    triangle( 0, -h, -s, h, s, h ) ; 
    popMatrix() ;
  }
} 
void keyPressed() { 
  save(System.getProperty("user.home") + "\\Desktop\\Banner Page\\" + str(random(100)) +".png") ;
}
