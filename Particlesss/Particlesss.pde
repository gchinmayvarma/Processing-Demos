Particle[] p = new Particle[5] ; 
float FF = 10 ; 

boolean Inside = true ; 
void setup() { 
  size( 640, 360 ) ; 
  for ( int _ = 0; _ < p.length; _++ ) p[_] = new Particle() ; 
  background(50) ;
} 
float Theta = 0 ; 
void draw() { 
  //background(50) ;
  for ( int _ = 0; _ < p.length; _++ ) { 
    p[_].a += p[_].da ;
    if ( Inside ) { 
      p[_].Wisp() ;
      Tilt(p[_], p[_].Theta ) ;
      p[_].Ready() ; 
    } else { 
      p[_].Move() ;
      p[_].Wall_Collide() ;
    }
    p[_].Display() ;
    p[_].Theta += p[_].dTheta ; 
  }
 
} 

void mousePressed() { 
  //background(50) ; 
  Inside = !Inside ;
}

void Tilt(Particle P, float a) { 
  float Temp_x = P.x, Temp_y = P.y ;
  P.x = (Temp_x*cos(a) + Temp_y*sin(a)) ; 
  P.y = (Temp_x*sin(a) - Temp_y*cos(a)) ;
}
