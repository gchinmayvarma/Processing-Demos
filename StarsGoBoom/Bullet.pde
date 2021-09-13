class Bullet {
  PVector pos, vel ;
  float r ; 
  color c ;

  Bullet(float x, float y, float dx, float dy, float radius) {
    pos = new PVector(x, y) ;
    vel = new PVector(dx, dy) ;
    r = radius ;
  }

  void move() {
    pos.add(vel);
  }

  void display() {
    fill(255, 0, 0);
    //stroke(colour);
    circle(pos.x, pos.y, r);
  }

  boolean outOfScreen() {
    return (pos.x < 0 || pos.x > width || pos.y < 0 || pos.y > height) ;
  }
}
