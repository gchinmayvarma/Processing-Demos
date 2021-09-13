import lord_of_galaxy.timing_utils.*;

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

import java.util.Random;

Box2DProcessing mainBox2D;

Ship playerShip;

float joystickPivotX, joystickPivotY, playerShipMaxVel = 80, pixelConstantX, pixelConstantY;

float[][] shipThrusterCoords = 
  {{24, 16, 3*PI/2}, {39, 16, 3*PI/2}, //up
  {1, 46, PI}, {62, 46, 0}, //left, right
  {22, 62, radians(100)}, {32, 62, PI/2}, {41, 62, radians(80)}}, //down
  shipBarrelCoords = 
  {{9, 24, radians(265)}, {17, 21, 3*PI/2}, {47, 21, 3*PI/2}, {54, 24, radians(275)}};

Random random = new Random();
Stopwatch playerShipClock = new Stopwatch(this), enemyShipClock = new Stopwatch(this);
boolean mouseDown = false;

ArrayList<Ship> enemies = new ArrayList<Ship>();
int enemyCount = 5;
float scale = 1;

void setup() {
  fullScreen();
  
  mainBox2D = new Box2DProcessing(this);
  mainBox2D.createWorld();
  mainBox2D.listenForCollisions();

  Vec2[] playerShipShapeCoords = {mainBox2D.vectorPixelsToWorld(new Vec2(32, 32)), 
    mainBox2D.vectorPixelsToWorld(new Vec2(32, -32)), 
    mainBox2D.vectorPixelsToWorld(new Vec2(-32, -32)), 
    mainBox2D.vectorPixelsToWorld(new Vec2(-32, 32))};

  PImage[] playerShipImages = {loadImage("playerShipLvl1.png"), loadImage("playerShipLvl2.png"), loadImage("playerShipLvl3.png")};
  playerShip = new Ship(width/2, height/2, playerShipShapeCoords, playerShipImages, true, playerShipClock, 
    100, 30, 100, 0, 64, 10);
  for (float[] coords : shipThrusterCoords) {
    playerShip.thrusters.add(new Pipe(coords[0], coords[1], coords[2]));
  }
  for (float[] coords : shipBarrelCoords) {
    playerShip.barrels.add(new Pipe(coords[0], coords[1], coords[2]));
  } 

  PImage[] enemy1Images = {loadImage("enemyTemp.png")};
  for (int i = 0; i < enemyCount; i++) {
    enemies.add(new Ship(random(0, width-64), random(0, height-64), playerShipShapeCoords, enemy1Images, 
      false, enemyShipClock, 500, 5, 100, 0, 64, 100));
  }
}

void draw() {
  background(0);

  mainBox2D.step();

  playerShip.display();
  playerShip.update();//set velocity after .update() and before .thrust()
  if (mouseDown) {
    joyStick();
  }
  playerShip.thrust();
  playerShip.shoot();

  for (int i = enemies.size() - 1; i >= 0; i--) {
    Ship enemy = enemies.get(i);
    enemy.display();
    enemy.update();
    enemy.thrust();

    if (enemy.health <= 0) {
      mainBox2D.destroyBody(enemy.body);
      enemies.remove(enemy);
      playerShip.lvl++;
    }
  }
}

void mousePressed() {
  joystickPivotX = mouseX;
  joystickPivotY = mouseY;
  
  mouseDown = true;
}

void mouseReleased() {
  mouseDown = false;
}

void beginContact(Contact c) {
  Fixture f1 = c.getFixtureA();
  Fixture f2 = c.getFixtureB();

  Body body1 = f1.getBody();
  Body body2 = f2.getBody();

  Object ud1 = body1.getUserData();
  Object ud2 = body2.getUserData();
  
  if(ud1.getClass() == Ship.class && ud2.getClass() == Bullet.class){
    Bullet bullet = (Bullet) ud2;
    Ship ship = (Ship) ud1;
    if(bullet.hitCount > 0){
      ship.health -= bullet.damage;
      bullet.hitCount -= 1;
    }
  }
}

void joyStick() {
  pushMatrix(); 
  translate(joystickPivotX, joystickPivotY); 

  float a = 10;

  float theta = PI - atan((mouseY - joystickPivotY)/(mouseX - joystickPivotX)); 
  if (mouseX > joystickPivotX) theta += PI;
  if (mouseX == joystickPivotX) {
    if (mouseY < joystickPivotY) theta = PI/2; 
    else theta = -PI/2;
  } 
  //float theta;
  //float hypo = dist(mouseX, mouseY, joystickPivotX, joystickPivotY);
  //if (!(hypo == 0)){theta = acos((mouseX - joystickPivotX)/hypo);}
  //else{theta = 0;}
  //if(mouseY > joystickPivotY){theta = - theta;}

  PVector start = new PVector(joystickPivotX, joystickPivotY), end = new PVector(mouseX, mouseY); 
  end.sub(start); 
  if (end.mag() > 100) { 
    end.setMag(100);
  }

  noStroke() ; 
  fill(200, end.mag()/10, end.mag()*2.55, 120); 
  ellipse(0, 0, 2*end.mag(), 2*end.mag()); 
  strokeWeight(1); 
  noFill(); 
  stroke(200);
  ellipse(0, 0, 200, 200); 
  stroke(240); 
  ellipse(0, 0, a/2, a/2); 
  fill(240) ; 
  line(0, 0, end.x, end.y); 
  triangle((end.x + a*cos(theta)), (end.y - a*sin(theta)), 
    (end.x - a*sin(theta)), (end.y - a*cos(theta)), 
    (end.x + a*sin(theta)), (end.y + a*cos(theta)));
  end.div(100 - playerShipMaxVel); 
  playerShip.setVelocity(new Vec2(end.x, end.y)); 
  popMatrix();
}
