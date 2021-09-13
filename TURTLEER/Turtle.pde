class Turtle { 
  float x, y, theta ;
  int pensize ; 
  color pencolor ;
  boolean shown ; 
  Turtle(float temp_x, float temp_y ) { 
    shown = false ; 
    gotoxy(temp_x, temp_y) ; 
    theta = 0 ;
    pencolor = color(255) ;
    pensize = 1 ;
    shown = true ; 
  } 
  void pu() { 
    shown = false ;
  } 
  void pd() { 
    shown = true ;
  }
  void gotoxy( float temp_x, float temp_y ) { 
    if (shown) { 
      stroke(pencolor) ; 
      strokeWeight(pensize) ; 
      line( temp_x, temp_y, x, y ) ;
    }
    x = temp_x ; 
    y = temp_y ;
  }
  void lt(float angle) { 
    theta += angle*PI/180 ;
  } 
  void rt(float angle) { 
    theta -= angle*PI/180 ;
  } 
  void fd(float d) { 
    gotoxy(x + d*cos(theta), y - d*sin(theta) ) ;
  } 
  void display() { 
    if ( shown ) { 
      float a = pensize*1.5 ;
      strokeWeight(1) ; 
      stroke(250) ; 
      fill(pencolor) ; 
      triangle( 
        (x + a*cos(theta)), (y - a*sin(theta)), 
        (x - a*sin(theta)), (y - a*cos(theta)), 
        (x + a*sin(theta)), (y + a*cos(theta)) ) ;
    }
  }
} 
