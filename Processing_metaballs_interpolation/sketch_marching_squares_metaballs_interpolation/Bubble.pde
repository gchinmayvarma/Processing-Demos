
class Bubble {
  float x, y;
  float vx, vy;
  float r;

  Bubble() {
    r = random(40, 60);
    x = random(r, width-r);
    y = random(r, height-r);
    vx = random(-2, 2);
    vy = random(-2, 2);
  }

  void show() {
    noFill();
    stroke(255);
    fill(255, 50);
    strokeWeight(1);
    circle(x, y, r*2);
  }

  void update() {
    x += vx;
    y += vy;
    if (x > width  - r || x < r) vx *= -1 ; 
    if (y > height - r || y < r) vy *= -1 ;
  }
}
