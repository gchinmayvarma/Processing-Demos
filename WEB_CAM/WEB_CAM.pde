import processing.video.* ; 
Capture video ; 
boolean Snap = false ;


void setup() { 
  size(640, 480) ; 
  //printArray(Capture.list()) ;  
  video = new Capture(this, 640, 480, 30 ) ; 
  video.start() ;
  loadPixels() ;
}

void draw() { 
  video.loadPixels() ; 
  for ( int x = 0; x < width - 1; x++ ) { 
    for ( int y = 0; y < height; y++ ) {
      int Index = x + width*y ; 
      color pix = color( video.pixels[Index] ) ; 
      float B = brightness(pix) ; 
      float r = red(pix)  ; 
      float g = green(pix); 
      float b = blue(pix) ;
      if (B< 100 ) { 
        pixels[Index] =color(0, 0, 0, 10) ;
      } else { 
        pixels[Index] = color(255, 255, 255, 10) ;
      }
    }
  }
  updatePixels() ;
}

void captureEvent( Capture video ) { 
  if ( !Snap ) video.read() ;
}

void mousePressed() { 
  Snap = !Snap ; 
  println(mouseX + " : " + mouseX*255/width) ;
}
