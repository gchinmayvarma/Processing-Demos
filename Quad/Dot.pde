class Dot { 
  PVector loc ; 
  float r ; 
  boolean caught ; 
  Dot(float x ,  float y) { 
    loc = new PVector( x , y ) ;
    r = 20 ; 
    caught = false ; 
  } 
  void check() { 
    if( dist( mouseX , mouseY , loc.x , loc.y ) < r ) caught = true ; 
  }
  void move() { 
    if( caught ) { 
      loc.x = mouseX ; 
      loc.y = mouseY ; 
    }
  }
  void display() { 
    stroke(30) ; 
    fill(255 , 50 , 50 , 100) ; 
    circle( loc.x , loc.y , r ) ; 
  }
}
