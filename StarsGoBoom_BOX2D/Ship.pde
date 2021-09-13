class Ship {
  PImage[] img;
  Vec2 pos = new Vec2(), bulletVelocity = new Vec2();
  BodyDef bodyDef = new BodyDef();
  Body body;
  boolean isKinematic;
  ArrayList<Pipe> barrels = new ArrayList<Pipe>(), thrusters = new ArrayList<Pipe>();
  ArrayList<Particle> thrusterParticles = new ArrayList<Particle>();
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  PVector xAxis = new PVector(1, 0), velocity = new PVector(), tempVec = new PVector();
  float thrusterFuel = 25, rand, fireRate, bulletSpeed, health, size, mass;
  Stopwatch clock;
  int lvl, maxLvl = 2;
  int thrusterColorR = 255, thrusterColorG = 255, thrusterColorB = 255, thrusterColorA = 255;
  int thrusterColorRUpper = 255, thrusterColorRLower = 200;
  int thrusterColorGUpper = 100, thrusterColorGLower = 50;
  int thrusterColorBUpper = 100, thrusterColorBLower = 50;
  int[] autumnList = {225, 200, 125, 50, 100, 50}, redAndPurpleList = {250, 100, 50, 0, 200, 50}, 
    testList = {175, 100, 100, 50, 225, 150}, blueAndPurpleList = {255, 200, 100, 50, 100, 50};
  int[] currentList;

  Ship(float x, float y, Vec2[] shapeCoords, PImage[] image, boolean isKinematic_, Stopwatch cloc, 
    float fireRate_, float bulletSpeed_, float health_, int lvl_, float size_, float mass_) {
    img = image;
    health = health_;
    mass = mass_;
    lvl = lvl_;
    isKinematic = isKinematic_;
    fireRate = fireRate_;
    bulletSpeed = bulletSpeed_;
    clock = cloc;
    size = size_;
    clock.start();

    currentList = redAndPurpleList;

    thrusterColorRUpper = currentList[0];
    thrusterColorRLower = currentList[1];
    thrusterColorGUpper = currentList[2];
    thrusterColorGLower = currentList[3];
    thrusterColorBUpper = currentList[4];
    thrusterColorBLower = currentList[5];

    bodyDef.position.set(mainBox2D.coordPixelsToWorld(x, y));
    if (isKinematic) {
      bodyDef.type = BodyType.KINEMATIC;
    } else {
      bodyDef.type = BodyType.DYNAMIC;
      bodyDef.gravityScale = 0;
    }

    body = mainBox2D.createBody(bodyDef);

    PolygonShape shape = new PolygonShape();
    shape.set(shapeCoords, shapeCoords.length);

    FixtureDef fixture = new FixtureDef();
    fixture.shape = shape;
    fixture.density = 0.1;
    fixture.friction = 1;
    fixture.restitution = 0.2;

    body.createFixture(fixture);

    body.setUserData(this);
  }

  void display() {
    pos = mainBox2D.getBodyPixelCoord(body);
    imageMode(CENTER);
    if (lvl > maxLvl) {
      lvl = maxLvl;
    }
    image(img[lvl], pos.x, pos.y);
    for (Particle particle : thrusterParticles) {
      particle.display();
      particle.update();
    }
    for (Bullet bullet : bullets) {
      bullet.display();
      bullet.update();
    }
  }

  void update() {
    body.setLinearVelocity(new Vec2(0, 0));
    velocity.set(0, 0);

    for (int i = bullets.size() - 1; i >= 0; i--) {
      Bullet bullet = bullets.get(i);
      if (bullet.pos.x < 0 || bullet.pos.x > width || bullet.pos.y < 0 || bullet.pos.y > height) {
        mainBox2D.destroyBody(bullet.body);
        bullets.remove(bullet);
      }
    }
    for (int i = thrusterParticles.size() - 1; i >= 0; i--) {
      Particle particle = thrusterParticles.get(i);
      if (particle.radius <= 0 || particle.pos.x < 0 || particle.pos.x > width || particle.pos.y < 0 || particle.pos.y > height) {
        mainBox2D.destroyBody(particle.body);
        thrusterParticles.remove(particle);
      }
    }
  }

  void thrust() {
    int dr = round(noise(frameCount)*random(-1, 1)*10) * 5;
    int dg = round(noise(frameCount)*random(-1, 1)*10) * 5;
    int db = round(noise(frameCount)*random(-1, 1)*10) * 5;

    thrusterColorR += dr;
    thrusterColorG += dg;
    thrusterColorB += db;
    if (thrusterColorR > thrusterColorRUpper) {
      thrusterColorR = thrusterColorRUpper;
    }
    if (thrusterColorR < thrusterColorRLower) {
      thrusterColorR = thrusterColorRLower;
    }
    if (thrusterColorG > thrusterColorGUpper) {
      thrusterColorG = thrusterColorGUpper;
    }
    if (thrusterColorG < thrusterColorGLower) {
      thrusterColorG = thrusterColorGLower;
    }
    if (thrusterColorB > thrusterColorBUpper) {
      thrusterColorB = thrusterColorBUpper;
    }
    if (thrusterColorB < thrusterColorBLower) {
      thrusterColorB = thrusterColorBLower;
    }

    thrusterColorA = (int) random(0, 255);

    if (velocity.mag() > 0) {
      for (Pipe thruster : thrusters) {
        float theta = PVector.angleBetween(thruster.direction, tempVec.set(-velocity.x, -velocity.y));
        if (theta <= PI/2) {
          rand = abs((float) random.nextGaussian())/2;
          //for (int i = 0; i < thrusterFuel; i++){


          thrusterParticles.add(new Particle(pos.x - width/2 - img[lvl].width/2 + thruster.pos.x, pos.y - height/2 - img[lvl].width/2 + thruster.pos.y, 
            tempVec.set(thruster.direction.x * cos(theta) * thrusterFuel * rand, thruster.direction.y * cos(theta) * thrusterFuel * rand), 
            8, -0.5, color(thrusterColorR, thrusterColorG, thrusterColorA)));
          //}
        }
      }
    }
  }

  void shoot() {
    if (clock.millis() >= fireRate) {
      for (Pipe barrel : barrels) {
        bullets.add(new Bullet(pos.x - width/2 - img[lvl].width/2 + barrel.pos.x, 
          pos.y - height/2 - img[lvl].width/2 + barrel.pos.y, 5, color(255, 0, 0), true, 
          tempVec.set(barrel.direction.x, barrel.direction.y).setMag(bulletSpeed), 5 ));
      }
      clock.restart();
    }
    for (int i = bullets.size()-1; i >= 0; i--) {
      Bullet bullet = bullets.get(i);
      if (bullet.hitCount <= 0) {
        mainBox2D.destroyBody(bullet.body);
        bullets.remove(bullet);
      }
    }
  }

  void applyForce(Vec2 force) {
    body.applyForce(mainBox2D.vectorWorldToPixels(force), body.getWorldCenter());
  }

  void setVelocity(Vec2 vel) {
    //if (pos.x > 0 + size/2 && pos.x < width - size/2 && pos.y > 0 + size/2 && pos.y < height - size/2) {
    body.setLinearVelocity(mainBox2D.vectorWorldToPixels(vel));
    velocity.set(vel.x, vel.y);
    //}
  }
}
