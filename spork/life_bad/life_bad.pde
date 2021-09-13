void setup() { 
  size(1000 , 200 ) ;
}

void draw() { 
  float x = float(mouseX) ; 
  float r = 0 , g = 0 , b = 0 ; 
  r = x > width/2 ? map( x , width/2 , width , 0 , 200 ) : 0 ; 
  g = x < width/2 ? map( x , 0 , width/2 , 200 , 0 ) : 0 ; 
  b = 5000/(20 + abs( r - g ))  ; 
  background( r, g ,b ) ; 
  println(r) ; 
}
