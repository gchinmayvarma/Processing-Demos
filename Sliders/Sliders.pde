class Slider {
  int x, y, val, maxval, minval, r ; 
  String name ;
  boolean caught ; 
  Slider(String n, float X, float Y, int... etc) {
    name = n ; 
    x = int(X) ; 
    y = int(Y) ; 
    if (etc.length > 0) {
      if ( etc.length > 1) minval = etc[1] ;
      else minval = 0 ;
      maxval = etc[0] ;
    } else {
      minval = 0 ; 
      maxval = 100 ;
    }
    val = minval ;
    caught = false ; 
    r = 10 ;
  }
  void display() { 
    stroke(60) ; 
    strokeWeight(5) ; 
    line( x, y, x + maxval - minval, y) ; 
    if ( inside() || caught ) fill(70, 70, 240) ;
    else fill(40) ; 
    strokeWeight(2) ;
    circle( x + val - minval, y, 2*r ) ; 
    textSize(20) ; 
    textAlign(RIGHT, BOTTOM) ; 
    text(name, x, y ) ;  
    if ( inside() || caught ) { 
      textAlign(LEFT, TOP) ; 
      text(val, x + maxval - minval, y ) ;
    }
  }
  boolean inside() { 
    return ( dist( mouseX, mouseY, x + val - minval, y ) < r ) ;
  }
}
ArrayList<Slider> sliders ; 
boolean caughtSlider = false ; 
void setup() {
  size( 800, 200 ) ;   
  sliders = new ArrayList<Slider>() ; 
  sliders.add( new Slider( "Red", width/10, height*0.5, 255 , 100) ) ;
  sliders.add( new Slider( "Green", width/10, height*0.7, 255) ) ;
  sliders.add( new Slider( "Blue", width/10, height*0.9, 255) ) ;
}

void draw() { 
  background(0) ; 
  for (Slider s : sliders) { 
    s.display() ;
  }
  noStroke() ; 
  fill( sliders.get(0).val, sliders.get(1).val, sliders.get(2).val ) ;
  rect( width*0.7, height/5, height*3/5, height*3/5 ) ;
}

void mousePressed() {
  for (Slider s : sliders) { 
    if ( s.inside() ) {
      caughtSlider = true ; 
      s.caught = true ;
    }
  }
}
void mouseReleased() {
  caughtSlider = false ;   
  for (Slider s : sliders) { 
    s.caught = false ;
  }
}
void mouseDragged() { 
  for (Slider s : sliders) { 
    if ( s.caught ) {
      s.val = mouseX - s.x + s.minval ; 
      s.val = constrain( s.val, s.minval, s.maxval) ;
    }
  }
}
