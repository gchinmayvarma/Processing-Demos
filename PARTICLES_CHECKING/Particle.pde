class Particle {
  PVector pos, vel, acl ;
  color c ;
  float r, dr, a, da ;
  boolean free ; 
  float theta, dtheta ; 
  float d ; 
  PVector piv, tow ; 
  boolean growing ; 
  float maxforce, maxvel ;
  Particle(float x, float y, color col, float radius, float dradius) {
    pos = new PVector(x, y) ;
    vel = new PVector(0, 0) ; 
    acl = new PVector(0, 0) ; 
    piv = new PVector(0, 0) ; 
    tow = new PVector(0, 0) ; 
    c = col ;
    r = radius ;
    dr = dradius ;
    a = 255 ; 
    da = 1 ; 
    free = true ;
    growing = true ;
    maxvel = 10 ; 
    maxforce = 1 ; 
  }
  void bind(float distance, float t, float dt) { 
    free = false ; 
    piv.set( pos.x, pos.y ) ; 
    theta = t ; 
    dtheta = dt ; 
    d = distance ;
  } 

  void update() { 
    if ( !free ) {
      tow.set( piv.x + d*cos(theta), piv.y + d*sin(theta) ) ; 
      seek( tow ) ;
      theta += dtheta ;
    }
    vel.add(acl) ;
    vel.limit(maxvel) ; 
    pos.add(vel) ;
    acl.mult(0) ;
    r += dr ;
    a += growing ? da : -da ; 
    if ( a <= 0 ) growing = true ; 
    if ( a >= 255 ) growing = false ;
  }
  void applyforce( PVector f ) { 
    acl.add(f) ;
  }
  void seek( PVector target ) { 
    PVector desired = PVector.sub(target, pos) ;
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

  void display() {
    fill(c, a);
    circle(pos.x, pos.y, r) ;
  }
}
