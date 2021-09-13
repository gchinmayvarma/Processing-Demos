import processing.video.* ; 

//Capture video ; 
Dot[] dots = new Dot[4] ; 

void setup() { 
  size( 400, 400 ) ; 
  //video = new Capture( this , 320 , 240 ) ; 
  //video.start() ; 
  for ( int i = 0; i < dots.length; i++ ) { 
    dots[i] = new Dot( 100 + (i%2)*100 , 100 + int(i/2)*100 ) ;
  }
} 

void draw() { 
  //image( video , 0 , 0 ) ;
  background(50) ; 
  fill(255 , 0 , 255 , 100 ) ; 
  //texture(video) ; 
  quad( dots[0].loc.x , dots[0].loc.y , dots[1].loc.x , dots[1].loc.y , 
  dots[3].loc.x , dots[3].loc.y , dots[2].loc.x , dots[2].loc.y ) ; 
  for ( Dot d : dots ) { 
    d.move() ; 
    d.display() ;
  }
} 

void mousePressed() { 
  for ( Dot d : dots ) d.check() ;
}
void mouseReleased() { 
  for ( Dot d : dots ) d.caught = false ;
}

void captureEvent( Capture video ) { 
  video.read() ;
} 
