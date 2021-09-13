class Point { 
  float x, y, dx, dy, d , a; 
  color c ; 
  Point() { //float tx , float ty) { 
    x = random(width) ; // tx ; 
    y = random(height) ; // ty ; 
    set_d() ;
  }
  void set_d() { 
    a = random(20,150) ; 
    d = random(15,30)*scaling ; 
    c = color( random(100, 255), random(20), random(150, 255) ) ;
    dx = random(6, 15)*width/2250 ; 
    dy = random(8, 20)*width/2250 ;
  }
  void walls() { 
    if ( x >= width  + d || x <= -d ) x = width - x ; 
    if ( y >= height + d || y <= -d ) { 
      set_d() ; 
      y = height - y ;
    }
  }
  void update() { 
    x += dx ; 
    y -= dy ;
  }
  void display() { 
    fill(c , a) ; 
    ellipse( x, y, d, d) ;
  }
} 
