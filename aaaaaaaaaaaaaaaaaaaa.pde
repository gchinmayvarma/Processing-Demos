int totalFrames = 120 ; 
int counter = 0 ;
boolean record = false ; 
void setup() { 
  size(400,400) ; 
}

void draw() { 
  float t = float(counter) / totalFrames ; 
  render(t) ; 
  if(record) { 
    saveFrame("output/gif"+nf(counter,3)+".png"); 
    if(counter == totalFrames - 1) exit() ; 
  }
  counter++ ;
  counter %= totalFrames;
}

void render(float t){
  fill(10, 10, 14, 10) ; 
  rect( 0, 0, width, height) ;
  float s, h ; 
  //pushMatrix() ; 
  s = 100 ; 
  h = 0.866*s ;
  
  //translate( width/2, height/2 ) ;
  //fill(255, 0, 69, 12 ) ;
  //triangle( 0, -h, -s, h, s, h ) ;
  //popMatrix()  ;
  
  for ( int i = 0; i < 500; i++ ) {
    pushMatrix() ;
    translate( random(width), random(height) ) ;
    rotate( random(TWO_PI) ) ; 
    s = random(10); 

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
