import processing.video.* ; 

Capture video ;
boolean Snap = false ; 
void setup() { 
  size(640,480);
  //printArray(Capture.list()) ; 
  video = new Capture(this, 640 , 480 , 30) ; 
  video.start() ; 
  loadPixels() ;
}

void draw() {
  //background(50) ; 
  //image(video, 0, 0 , mouseX , mouseY);
  for ( int x = 0; x < width; x++ ) { 
    for ( int y = 0; y < height; y++ ) {
      int Index = x + width*y ;
      color pix = video.pixels[Index] ;
      float r = red(pix) ;
      float g = green(pix) ; 
      float b = blue(pix) ;  
      float B = brightness(pix) ;
      /*if (R > 32 ) { // ) { 
       pixels[Index] = color(20) ; //color(x/2, 0, mouseX*255/width) ;
       } else */
      float R = dist( r, g, b, 255, 0, 0 ) ; 
      if ( R < mouseX*255/width ) {
        pixels[Index] = color(255, 0, 0) ;
      } else if ( B > 100 ) {
        pixels[Index] = color(255) ;
      } else { 
        pixels[Index] = color(0) ;
      }
    }
  }
  updatePixels() ;
}

void captureEvent( Capture video ) { 
  if( !Snap ) video.read() ;
}

void mousePressed() { 
  Snap = !Snap ; 
  println(255*mouseX/width) ;
}
