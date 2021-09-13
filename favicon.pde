void setup() { 
  size(48,48) ; 
}

void draw() { 
  //fill(10, 10, 14, 10) ; 
  //rect( 0, 0, width, height) ;
  background(30,30,50) ; 
  
  float s, h ; 
  //pushMatrix() ; 
  s = 12 ; 
  h = 0.866*s ;
  pushMatrix() ; 
  translate( width/2, height/2 ) ;
  fill(255, 0, 69 ) ;
  triangle( 0, -h, -s, h, s, h ) ;
  popMatrix()  ;

}

void keyPressed() { 
  save(System.getProperty("user.home") + "\\Desktop\\favicon\\" + str(random(100)) +".png") ;
}
