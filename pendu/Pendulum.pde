class Pendulum { 
  PVector o ; 
  float l , r , a , aV , aA ; 
  boolean hold ;
  color c ; 
  Pendulum( float x , float y , float len) { 
    o = new PVector( x , y ) ;
    l = len ; 
    r = 20 ;
    a = PI/2 ; 
    refresh() ; 
  }
  void refresh() { 
    aV = 0 ; 
    aA = 0 ;
    c = color(255) ; 
    hold = false ; 
  }
  void all() {
    update() ;
    show() ; 
    check() ; 
  } 
  void check() { 
    if( hold ) { 
      c = color(10) ; 
    }
  }
  void update() { 
    if( hold ) return ; 
    aA = -0.5*sin(a)/l ; 
    a += aV ; 
    aV += aA ; 
    aV *= 0.99 ; 
  }
  void show() { 
    stroke(255) ; 
    line( o.x , o.y , o.x + l*sin(a) , o.y + l*cos(a) ) ;
    noStroke() ; 
    fill(c) ; 
    ellipse( o.x + l*sin(a) , o.y + l*cos(a) , 2*r , 2*r ) ;  
  }
}
