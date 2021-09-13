class Spark { 
  PVector loc, vel ;
  float size, t, ds, dt; 
  color c ; 
  Spark(float x, float y) { 
    loc = new PVector( x, y ) ; 
    vel = new PVector( random(-3,3)*scaling , random(-9, 9)*scaling ) ;
    size = random(20 , 50)*scaling ;
    c = color( random(200, 255), random(15), random(200) ) ;
    t = random(100, 255) ;
    ds = random(0.1, 0.8)*scaling ; 
    dt = random(5, 15)*scaling ;
  } 
  void update() { 
    loc.add(vel) ;
    t -= dt ; 
    t = constrain( t , 0 , 255 )  ; 
    size -= ds ;
  }
  void show() {  
    fill(c, t) ; 
    ellipse( loc.x, loc.y, size, size ) ;
  }
}
