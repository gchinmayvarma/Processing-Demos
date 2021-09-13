import processing.video.* ; 

Particle[] p = new Particle[50] ; 
Capture video ; 

void setup() { 
  size(320 , 240) ; 
  for ( int _ = 0; _ < p.length; _++ ) { 
    p[_] = new Particle() ;
  }
  video = new Capture(this, 320 , 240) ; 
  video.start() ;
} 

void draw() {
  //background(50);
  video.loadPixels() ; 
  image( video , 0 , 0 ) ;  
  for ( int x = 0; x < video.width; x++ ) { 
    for ( int y = 0; y < video.height; y++ ) { 
      int Index = x + width*y ; 
      for ( int _ = 0; _ < p.length; _++ ) { 
        if ( (int)p[_].x == x && (int)p[_].y == y ) { 
          p[_].c = video.pixels[Index] ;
        }
      }
    }
  }
  for ( int _ = 0; _ < p.length; _++ ) { 
    p[_].Display() ;
    p[_].Set() ; 
  }
}

void captureEvent( Capture video ) { 
  video.read() ;
}
