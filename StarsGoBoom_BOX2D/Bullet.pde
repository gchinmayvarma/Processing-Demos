class Bullet {
  Vec2 pos;
  color colour;
  float radius, damage, hitCount = 1;
  Body body;

  Bullet(float x, float y, float rad, color col, boolean isKinematic, PVector velocity, float dmg) {
    pos = new Vec2(x, y);
    radius = rad;
    colour = col;
    damage = dmg;

    BodyDef bodyDef = new BodyDef();
    if (isKinematic) {
      bodyDef.type = BodyType.KINEMATIC;
    } else {
      bodyDef.type = BodyType.DYNAMIC;
    }
    bodyDef.position.set(mainBox2D.vectorPixelsToWorld(pos));
    bodyDef.gravityScale = 0;

    body = mainBox2D.createBody(bodyDef);

    CircleShape shape = new CircleShape();
    shape.m_radius = mainBox2D.scalarPixelsToWorld(rad);

    body.createFixture(shape, 1);

    if (isKinematic) {
      body.setLinearVelocity(mainBox2D.vectorWorldToPixels(new Vec2(velocity.x, velocity.y)));
    } else {
      body.applyLinearImpulse(mainBox2D.vectorWorldToPixels(new Vec2(velocity.x, velocity.y)), mainBox2D.vectorPixelsToWorld(pos), false);
    }

    body.setUserData(this);
  }

  void display() {
    pos = mainBox2D.getBodyPixelCoord(body);
    fill(colour);
    stroke(colour);
    circle(pos.x, pos.y, radius);
  }

  void update() {
  }
}
