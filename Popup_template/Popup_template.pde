Button b ;
float pp = 0 ;
void setup() { 
  size(400, 700);
  b = new Button( width/2, height*5/6, 40, color(29, 89, 200) ) ;
}

void draw() {
  background(0) ;
  b.display() ; 
  if ( pp > 0 ) popupbox("< Disabling all notifications >" , new String[]{"Yes" , "No"}  , 10) ;
}
void popupbox(String title , String[] options , float x) {
  float boxwidth = width*8/10 ; 
  float xmargin = width/10 ; 
  fill(50) ; 
  rectMode(CORNERS) ;
  rect( xmargin , height*3/10, xmargin + pp, height*7/10 ) ;
  if ( pp < boxwidth ) pp += map(pp, 0, width*8/10, 15, 0.5 ) ;
  fill(20, 100, 80, 255*pp*10/(width*8)) ; 
  rect( width*9/10 - pp, height*3/10, width*9/10, height*3/10 - width/8 ) ;
  textAlign(CENTER, BOTTOM) ;
  textSize(width/10) ;  
  if ( textWidth(title) > width*8/10 ) textSize((width*1.5)/(title.length())) ; 

  fill(255*pp*10/(width*8), 255*pp*10/(width*8)) ; 
  text(title, width/2, height*3/10 ) ;
  
  for( String s : options ) { 
  }
}

void mousePressed() { 
  if ( dist( mouseX, mouseY, b.x, b.y ) < b.r ) pp = 1 ;
}
class Button { 
  float x, y, r ; 
  color c ; 
  Button(float x_, float y_, float r_, color c_) {
    x = x_ ; 
    y = y_ ; 
    r = r_ ;
    c = c_ ;
  }
  void display() { 
    fill(c) ; 
    circle( x, y, r*2 ) ;
  }
}
