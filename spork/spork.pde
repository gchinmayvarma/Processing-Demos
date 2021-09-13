ArrayList <Fire> fire = new ArrayList<Fire>();
PVector up ; 
boolean isdown = false ; 
void setup() { 
  //size( 640, 360 ) ;
  fullScreen() ; 
  //frameRate(60) ; 
  up = new PVector( 0, -0.2) ; 
  noStroke() ;
} 

void draw() { 
  background(0) ; 
  for ( int i = fire.size() - 1; i >= 0; i-- ) {
    Fire f = fire.get(i) ;
    f.addspark() ;
    f.stuff() ;
    if ( f.l <= 0 && f.sparks.size() <= 0) fire.remove(i) ;
  }
  if ( mousePressed ) isdown = true ; 
  else isdown = false ; 
  if ( isdown ) fire.add( new Fire(mouseX, mouseY ) ) ;
} 
