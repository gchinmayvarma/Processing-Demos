void setup() { 
  size( 400, 400 ) ;
}

void draw() {
  background(50) ; 
  String str = str( hour() ) + " : " + str( minute() ) ; 
  fill(250) ; 
  textSize(1 + 50*mouseX/width) ; 
  textAlign(CENTER,CENTER) ;
  text( str, width/2, height/2 ) ;
}
