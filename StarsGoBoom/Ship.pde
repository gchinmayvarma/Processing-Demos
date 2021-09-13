class Ship {
  PImage Image ;
  PVector pos, vel, acl ; 
  float maxVel, maxAcl, thrusterFuel  ;
  ArrayList<Pipe> thrusters, barrels ;
  float tempTheta, bulletSpeed, fireRate;
  boolean shooting ;
  Stopwatch clock ;

  Ship(PImage p, float x, float y, float bullSpeed, float firerate ) {
    Image = p ;
    //Image.resize( int(Image.width*scale), int(Image.height*scale) ) ; 
    //Image.resize(2*Image.width , 2*Image.height) ;
    pos = new PVector(x, y) ; 
    vel = new PVector(0, 0) ; 
    acl = new PVector(0, 0) ;
    maxVel = 10 ; 
    maxAcl = 1 ; 
    thrusterFuel = 15 ;
    clock = shipWatch ; 
    clock.start();
    fireRate = firerate;
    thrusters = new ArrayList<Pipe>() ;
    barrels = new ArrayList<Pipe>() ;
  }

  void display() {
    image(Image, pos.x, pos.y, Image.width*4*scale, Image.height*4*scale);
    for (Pipe p : thrusters ) { 
      for ( Particle pp : p.particles ) { 
        pp.display() ;
      }
    }
  }

  void move() {
    acl.limit(maxAcl);
    vel.add(acl);
    vel.limit(maxVel);
    pos.add(vel);
    for (Pipe thruster : thrusters) {
      thruster.activate();
    }
    for (Pipe barrel : barrels) {
      barrel.activate();
    }
  }

  void thrust() {
    if (vel.mag() > 0) {
      for (Pipe thruster : thrusters) {
        tempTheta = 0 ;//PVector.angleBetween(thruster.dir, PVector(-vel.x, -vel.y));
        if (tempTheta <= radians(100)) {
          thruster.particles.add(new Particle(pos.x + thruster.pos.x, pos.y + thruster.pos.y, color(0, 0, 255), 10, -1));
          for (Particle particle : thruster.particles) {
            //rand = abs((float) random.nextGaussian())*2;
            for (int i = 0; i < 10; i++ ) { 
              float rr = random(1, 2) ; 
              particle.vel.set(rr*thruster.dir.x * cos(tempTheta) * thrusterFuel, 
                rr*thruster.dir.y * cos(tempTheta) * thrusterFuel );
            }
          }
        }
      }
    }
  }

  void shoot() {
    if (clock.time() >= fireRate) {
      if (shooting) {
        //tempBarrel = barrels.get(currentBarrel);
        //tempBarrel.bullets.add(new Bullet(pos.x + tempBarrel.pos.x, pos.y + tempBarrel.pos.y, 5, 
        //                                tempBarrel.dir.x * bulletSpeed, tempBarrel.dir.y * bulletSpeed, color(255, 0, 0)));
        //currentBarrel++;
        //if (currentBarrel >= barrels.size()){
        //  currentBarrel = 0;
        //}
        for (Pipe barrel : barrels) {
          barrel.bullets.add(new Bullet(pos.x + barrel.pos.x, pos.y + barrel.pos.y, 5, 
            barrel.dir.x * bulletSpeed, barrel.dir.y * bulletSpeed));
        }
      }
      clock.restart();
    }
  }

  void edgeBlock() {
    pos.x = constrain(pos.x, 0, width - Image.width) ;
    pos.y = constrain(pos.y, 0, height - Image.height) ;
  }

  void edgeTeleport() {
    if (pos.x > width  || pos.x < 0) pos.x = width  - pos.x ;
    if (pos.y > height || pos.y < 0) pos.y = height - pos.y ;
  }
}
