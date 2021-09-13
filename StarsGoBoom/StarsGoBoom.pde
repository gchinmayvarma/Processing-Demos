import lord_of_galaxy.timing_utils.*;
import java.util.Random;

float scale = 1.5;
float pivot_x, pivot_y; 
boolean f = true, growing = true;
Random random = new Random();
PImage shipImage, enemyImage;
ArrayList<Ship> enemies= new ArrayList<Ship>();
int enemyCount = 5;
Ship ship;
//Joystick shipStick;
PVector[] stars = new PVector[54] ; 
float[][] shipThrusterCoords = {{24, 16, 3*PI/2}, {39, 16, 3*PI/2}, //up
  {1, 46, PI}, {62, 46, 0}, //left, right
  {22, 62, radians(110)}, {32, 62, PI/2}, {41, 62, radians(70)}}, //down
  shipBulletBarrelCoords = {{9, 24, radians(265)}, {17, 21, 3*PI/2}, {47, 21, 3*PI/2}, {54, 24, radians(275)}};
Stopwatch shipWatch = new Stopwatch(this);
float t = 0 ; 
PVector[] points = new PVector[15] ; 

void setup() {
  fullScreen() ;
  frameRate(60) ; 
  shipImage = createImage(64, 64, RGB) ;
  shipImage.loadPixels() ; 
  for ( int x = 0; x < shipImage.width; x++ ) { 
    for ( int y = 0; y < shipImage.height; y++ ) { 
      shipImage.pixels[x + shipImage.width*y] = color(100, 100, 255) ;
    }
  }
  shipImage.updatePixels() ; 
  ship = new Ship(shipImage, width/2 - shipImage.width/2, height/2 - shipImage.height/2 - 64/2, 10, 100);

  for (float[] i : shipThrusterCoords) {
    ship.thrusters.add(new Pipe(i[0]*scale*4, i[1]*scale*4, i[2]));
  }
  for (float[] i : shipBulletBarrelCoords) {
    ship.barrels.add(new Pipe(i[0], i[1], i[2]));
  }
  shipImage = ship.Image ; 
  shipImage.loadPixels() ; 
  for ( int i = 0; i < points.length; i++ ) { 
    points[i] = new PVector(random(1, 3)*shipImage.width/4, random(1, 3)*shipImage.height/4, random(shipImage.width) ) ;
  } 

  shipImage.updatePixels() ;

  for ( int i = 0; i < stars.length; i++ ) { 
    stars[i] = new PVector( random(width), random(height), scale*(random(10, 20)) ) ;
  }
}

void draw() {
  background(10);
  /*
  fill(10,200) ; 
  rect(0,0,width-1,height-1) ;
  */
  ship.display();
  ship.edgeBlock() ; // Teleport();
  ship.thrust();
  ship.shoot();
  ship.move();
  for ( int x = 0; x < shipImage.width; x++ ) { 
    for ( int y = 0; y < shipImage.height; y++ ) {
      float[] distances = new float[points.length] ; 
      for ( int i = 0; i < points.length; i++) { 
        distances[i] = dist(x, y, t, points[i].x, points[i].y, points[i].z) ;
      }
      float[] sorted = sort(distances) ; 
      float noise1 = map(sorted[0], 0, shipImage.width/10, 255, 150)  ; 
      shipImage.pixels[x + shipImage.width*y] = color(noise1, 0, noise1*2) ;
      if ( shipImage.pixels[x + shipImage.width*y] == color(0) )
        shipImage.pixels[x + shipImage.width*y] = color(10) ;
    }
  }
  if ( t > shipImage.width*1.2 ) { 
    for ( PVector p : points ) { 
      p.set(random(1, 3)*shipImage.width/4, random(1, 3)*shipImage.height/4, random(shipImage.width) ) ;
    }
    growing = false ;
  }
  if ( t < -shipImage.width*0.2 ) growing = true ; 
  if ( growing) t += random(scale) ;
  else t -= random(scale/2) ; 

  shipImage.updatePixels() ; 

  fill(200,0,250) ;
  for ( PVector s : stars ) { 

    circle( s.x, s.y, s.z ) ; 
    s.y += scale*40 - s.z ;
    if ( s.y > height + s.z ) { 
      s.z = scale*random(10, 20 ) ; 
      s.y = - s.z ;
      s.x = random(width) ;
    }
  }
  //image(shipImage, 0, 0, width, height) ; 
  //*


  Joystick() ;
  //*/
}











void mousePressed() { 
  pivot_x = mouseX ; 
  pivot_y = mouseY ;
} 

void Joystick() { 
  if ( mousePressed ) { 
    float aa = 1.8 ;
    pushMatrix() ; 
    translate( pivot_x, pivot_y ) ; 
    float theta = PI - atan( (mouseY - pivot_y)/(mouseX - pivot_x) ) ; 
    if ( mouseX > pivot_x ) theta += PI ;
    if ( mouseX == pivot_x ) {
      if ( mouseY < pivot_y ) theta = PI/2 ; 
      else theta = -PI/2 ;
    }
    PVector start = new PVector( pivot_x, pivot_y ), end = new PVector( mouseX, mouseY ) ; 
    end.sub(start) ; 
    if ( end.mag() > 100*scale*aa ) { 
      end.setMag(100*scale*aa) ;
    }
    noStroke() ; 
    fill(200/scale, end.mag()/(5*scale), end.mag()*2.55*2/scale, 240/scale ) ; 
    ellipse( 0, 0, 2*end.mag(), 2*end.mag() ) ; 
    strokeWeight(1) ; 
    noFill() ; 
    stroke(200) ;
    ellipse( 0, 0, aa*200*scale, aa*200*scale ) ; 
    stroke(240) ; 
    ellipse( 0, 0, aa*10*scale/2, aa*10*scale/2 ) ; 
    fill(240) ; 
    //line( 0, 0, end.x, end.y ) ; 
    float a = aa*scale*10 ; 
    triangle( 
      (end.x + a*cos(theta)), (end.y - a*sin(theta)), 
      (end.x - a*sin(theta)), (end.y - a*cos(theta)), 
      (end.x + a*sin(theta)), (end.y + a*cos(theta)) ) ;
    end.div(aa*scale*10) ; 
    ship.vel.add(end) ; 
    popMatrix() ;
  }
}
