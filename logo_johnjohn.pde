void setup() { 
  size(275,157) ; 
  background(10, 10, 14) ;
  frameRate(30) ;
}

void draw() { 
  fill(10, 10, 14, 12) ; 
  rect( 0, 0, width, height) ;
  float s, h ; 
  pushMatrix() ; 
  s = 50 ; 
  h = 0.866*s ;
  
  translate( width/2, height/2.2) ;
  fill(255, 0, 69, 12 ) ;
  triangle( 0, -h, -s, h, s, h ) ;
  popMatrix()  ;
  for ( int i = 0; i < 70; i++ ) {
    pushMatrix() ;
    translate( random(width), random(height) ) ;
    rotate( random(TWO_PI) ) ; 
    s = random(5); 

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
  if(frameCount > 120 ) { 
    fill(0,map(frameCount,200,260,0,255)) ; 
    rect(0,0,width,height) ; 
  }
  saveFrame(System.getProperty("user.home") + "\\Desktop\\redwa\\Movie\\tri_####.png") ;
} 
void mousePressed() { 
  save(System.getProperty("user.home") + "\\Desktop\\redwa\\" + str(random(100)) +".png") ;
}
