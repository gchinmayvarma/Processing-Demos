class Particle {
  Vec2 pos, velocity;
  Body body;
  CircleShape shape;
  color colour;
  float radius, dRadius;

  Particle(float x, float y, PVector vel, float rad, float dRad, color col) {
    pos = new Vec2(x, y);
    velocity = new Vec2(vel.x, vel.y);
    colour = col;
    radius = rad;
    dRadius = dRad;

    BodyDef bodyDef = new BodyDef();
    bodyDef.position.set(mainBox2D.vectorPixelsToWorld(pos));
    bodyDef.type = BodyType.KINEMATIC;
    bodyDef.gravityScale = 0;

    body = mainBox2D.createBody(bodyDef);

    shape = new CircleShape();
    shape.m_radius = mainBox2D.scalarPixelsToWorld(rad);

    body.createFixture(shape, 1);
    body.setLinearVelocity(mainBox2D.vectorWorldToPixels(velocity));//, mainBox2D.vectorPixelsToWorld(pos), false);

    body.setUserData(this);
  }

  void display() {
    pos = mainBox2D.getBodyPixelCoord(body);
    fill(colour);
    stroke(colour);
    square(pos.x, pos.y, radius);
  }

  void update() {
    radius += dRadius;
    shape.m_radius += mainBox2D.scalarPixelsToWorld(dRadius);
  }
}
