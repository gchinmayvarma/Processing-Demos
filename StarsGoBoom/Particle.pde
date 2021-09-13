class Particle {
  PVector pos, vel, acl ;
  color c ;
  float r, dr, a, da ;
  boolean free ; 
  float theta, dtheta ; 
  float d ; 
  PVector piv, tow ; 
  boolean growing ; 
  float maxForce, maxVel ;
  
  Particle(float x, float y, color col, float radius, float dradius) {
    pos = new PVector(x, y) ;
    vel = new PVector(0, 0) ; 
    acl = new PVector(0, 0) ; 
    piv = new PVector(0, 0) ; 
    tow = new PVector(0, 0) ; 
    c = col ;
    r = random(10,15)*scale ; //radius ;
    dr = -1*scale  ; //dradius ;
    a = 200 ; 
    da = 10 ; 
    free = true ;
    growing = true ;
    maxVel = 10 ; 
    maxForce = 1 ;
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
    //vel.limit(maxVel) ; 
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
      desired.setMag( map( d, 0, 100, 0, maxVel) ) ;
    } else { 
      desired.setMag(maxVel) ;
    } 
    PVector steer = PVector.sub(desired, vel) ; 
    steer.limit(maxForce) ; 
    applyforce(steer) ;
  }

  void display() {
    noStroke() ; 
    fill(c, a);
    circle(pos.x, pos.y, r) ;
  }
}


void Particle_Working( ArrayList<Particle> particles ) { 
  for (int i = particles.size() - 1; i >= 0; i--) {
    Particle particle = particles.get(i);
    //particle.display();
    particle.update();
    if (particle.r <= 0 || particle.a <= 0) {
      particles.remove(particle);
    }
  }
}
