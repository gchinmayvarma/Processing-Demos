class Particle { 
  float x, y, r, a, speed, dx, dy, da, A, Sin_Mod, Radius, Theta, dTheta ; 
  color c ;
  Particle() { 
    Set( width/2, height/2 ) ; //random(width), random(height) ) ; 
    r = 5 ; //random(7) ;
    a = random(TWO_PI) ; 
    A = random(100 , 255) ; 
    speed = random(2) ; 
    dx = speed*cos(a) ;
    dy = speed*sin(a) ;
    da = random(7)/100 ; 
    c = color( random(100, 255), 0, random(100, 255) ) ;
    Sin_Mod = random(5) ; 
    Radius = random(50, 100) ;
    Theta = random(TWO_PI) ; 
    dTheta = random(1)/(1000) ;
  } 
  void Heart() { 
    x = 16*( sin(a)*sin(a)*sin(a) ) ;
    y = 1*(13*cos(a) - 5*cos(2*a) - 2*cos(3*a) - cos(4*a) ) ;
  }
  void Wisp() { 
    x = cos(a) ; 
    y = sin(Sin_Mod*a) ;
  }
  void Ready() { 
    x *= Radius ; 
    y *= Radius ;
    if ( mouseX > width *(1 - 1/FF) || mouseX < width/FF 
      || mouseY > height*(1 - 1/FF) || mouseY < height/FF ) {
      x += width/2 ; 
      y += height/2 ;
    } else { 
      x += mouseX ; 
      y += mouseY ;
    }
  }
  void Set( float Temp_x, float Temp_y ) { 
    x = Temp_x ;
    y = Temp_y ;
  }
  void Move() {
    x += dx ;
    y += dy ;
  }
  void Display() { 
    //noStroke() ; 
    fill(c, A) ;
    ellipse( x, y, 2*r, 2*r) ;
  }
  void Wall_Collide() { 
    if ( (x >= width )||(x <=   0) ) dx *= -1 ;
    if ( (y >= height)||(y <=   0) ) dy *= -1 ;
  }
}
