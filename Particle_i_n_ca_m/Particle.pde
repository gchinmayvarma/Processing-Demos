class Particle { 
  float x, y, r, a, theta ;
  color c ; 
  Particle() { 
    Set() ;
    r = random(3, 5) ;
    c = color( random(200, 255), 0, random(200, 255) ) ;
    a = random(100) ;
  }
  void Set() { 
    x = random(width) ; 
    y = random(height) ;
  }
  void Display() { 
    noStroke() ; 
    fill(c, a ) ;
    ellipse(x, y, 2*r, 2*r ) ;
  }
} 
