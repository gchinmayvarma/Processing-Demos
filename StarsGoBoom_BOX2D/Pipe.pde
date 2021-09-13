class Pipe {
  Vec2 pos;
  PVector direction;
  ArrayList<Particle> particles = new ArrayList<Particle>();
  ArrayList<Bullet>bullets = new ArrayList<Bullet>();
  Pipe(float x, float y, float theta) {
    pos = new Vec2(x, y);
    direction = PVector.fromAngle(theta) ;
  }
} 
