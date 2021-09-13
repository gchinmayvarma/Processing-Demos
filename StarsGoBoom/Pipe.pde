class Pipe {
  PVector pos;
  PVector dir;
  ArrayList<Particle> particles = new ArrayList<Particle>();
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();

  Pipe(float x, float y, float theta) {
    pos = new PVector(x, y);
    dir = PVector.fromAngle(theta);
  }

  void activate() {
    Particle_Working(particles) ; 
    for (int i = bullets.size() - 1; i >= 0; i--) {
      Bullet bullet = bullets.get(i);
      bullet.move();
      //bullet.display();
      if (bullet.outOfScreen()) {
        bullets.remove(bullet);
      }
    }
  }
}
