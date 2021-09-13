class Ster { 
  float maxforce, maxvel ; 
  PVector loc, vel, acl ; 
  Ster() { 
    maxforce = 0.1 ; 
    maxvel = 4 ; 
    loc = new PVector( 100, 100 ) ; 
    vel = new PVector( 0, 0 ) ; 
    acl = new PVector( 0, 0 ) ;
  }
  void updot() {
    vel.add(acl) ; 
    vel.limit(maxvel) ; 
    loc.add(vel) ; 
    acl.mult(0) ;
  }
  void applyforce( PVector f ) { 
    acl.add(f) ;
  }
  void seek( PVector target ) { 
    PVector desired = PVector.sub(target, loc) ;
    float d = desired.mag() ; 
    if ( d < 100 ) { 
      desired.setMag( map( d, 0, 100, 0, maxvel) ) ;
    } else { 
      desired.setMag(maxvel) ;
    } 
    PVector steer = PVector.sub(desired, vel) ; 
    steer.limit(maxforce) ; 
    applyforce(steer) ;
  }
  void show() {
    fill(255,0,255) ; 
    ellipse(loc.x, loc.y, 5, 5 ) ;
  }
}
