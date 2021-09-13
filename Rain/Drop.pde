class Drop { 
  float x, y, z, len, dy ; 
  Drop() { fresh() ; } 
  void fresh() { 
    x = random(width) ; 
    y = random( -500, 50) ; 
    z = random(0, 20) ; 
    len = random(10, 20 ) ; 
    dy = map ( z, 0, 20, 4, 10 ) ;
  }
  void fall() { 
    y += dy ;
    float grav = map( z, 0, 20, 0, g ) ;
    dy += grav ; 
    if ( y > height) { 
      fresh() ;
    }
  } 
  void show() { 
    strokeWeight( map( z, 0, 20, 1, 4 ) ) ; 
    stroke(138, 43, 226 ) ;
    line(x, y, x, y + len ) ;
  }
}
