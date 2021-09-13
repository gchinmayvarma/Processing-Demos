import processing.video.* ; 

Capture video ; 
float s = 2 ;
void setup() {
  size( 640 , 480 ) ; 
  video = new Capture(this , 320 , 240 ) ; 
  video.start() ; 
}

void draw() { 
  imageMode( CORNERS ) ; 
  image(video , 0 , 0 , width , height ) ; 
}

void captureEvent( Capture video ) { 
  video.read() ; 
  video.loadPixels() ; 
  color C = video.pixels[ int((mouseX + video.width*mouseY)/s) ] ; 
  float R = red(C) ; 
  float G = green(C) ; 
  float B = blue(C) ; 
  
  for( int x = 0 ; x < video.width ; x++ ) { 
    for( int y = 0 ; y < video.height ; y++ ) { 
      int i = x + video.width*y ; 
      color c = color(video.pixels[i]) ; 
      float r = red(c) ; 
      float g = green(c) ; 
      float b = blue(c) ; 
      float d = dist( r , g , b , R , G , B ) ; 
      if( d < 5 ) {
        c = color(250) ; 
      } 
      video.pixels[i] = c ;
    }
  }
  video.updatePixels() ; 
} 
