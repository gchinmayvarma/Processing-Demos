class Star { 
  float x, y, z, pz ; 
  float size = 5 ; 
  Star() { 
    fresh() ;
  } 
  void fresh() { 
    x = random( -width/2 , width/2 ) ; 
    y = random( - height/2, height/2) ; 
    z = random( width ) ;
    pz = z ;
  }
  void update() {
    z -= speed ; 
    if ( z < 1 ) {
      fresh() ;
    }
  }
  void show() { 
    float sx = map( x / z, 0, 1, 0, width) ; 
    float sy = map( y / z, 0, 1, 0, height ) ;
    float px = map( x / pz, 0, 1, 0, width ) ; 
    float py = map( y / pz, 0, 1, 0, height ) ; 
    float s = map( z, 0, width, size, 0 ) ;
    ellipse( sx, sy, s, s) ;
    line( sx, sy, px, py) ;
    pz = z ; 
  }
}
