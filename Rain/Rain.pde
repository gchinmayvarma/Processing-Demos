float g = 1; 
Drop[] drops = new Drop[1000] ;

void setup() { 
  fullScreen() ; // size(640, 360) ;
  for (int i = 0; i < drops.length; i++ ) drops[i] = new Drop() ;
  strokeWeight(2) ; 
} 

void draw() { 
  //g = map( mouseX ,0 , width , 0 , 3 ) ; 
  background(230, 230, 250) ; 

  for ( Drop d : drops ) {
    d.fall() ; 
    d.show() ; 
  }
}
