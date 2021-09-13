class Fire { 
  ArrayList <Spark> sparks ; 
  PVector loc ; 
  float l , dl ; 
  Fire( float x, float y ) { 
    sparks = new ArrayList <Spark>() ; 
    loc = new PVector( x, y ) ;
    l = random(3 , 7) ; 
    dl = random(0.3 , 1) ; 
  } 
  void addspark() { 
    for( int i = 0 ; i < int(l) ; i++ ) sparks.add( new Spark( loc.x , loc.y ) ) ;
  }
  void stuff() { 
    l -= dl ; 
    for ( int i = sparks.size() - 1; i >= 0; i--) {
      Spark s = sparks.get(i) ; 
      s.vel.add(up) ;
      s.update() ; 
      s.show() ;
      if ( s.t <= 0 || s.size <= 0) sparks.remove(i) ;
    }
  }
}
