//Private Polocy
//https://www.freeprivacypolicy.com/live/0f893439-0864-4f3c-85a2-1d5769a93ddd
// Site https://sites.google.com/view/sparkle-app/
//android:icon="@mipmap/ic_launcher"
int b_sec, b_min, b_hr, d_sec = 2, d_min = 2, d_hr = 2 ; 
String[] Months = { "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec" } ; 
String[] Days = { "MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY" } ;
int[] Days_Buffer = { 0, 3, 2, 5, 0, 3, 5, 1, 4, 6, 2, 4 } ;
ArrayList<Point> points ; 
ArrayList <Fire> fire ;
PVector up ; 
boolean isdown = false ; 
float scaling ; 
float scaledr ;

void settings() { 
  fullScreen() ;   
}
void setup() { 
  //size( displayWidth, displayHeight , P2D) ; 
  //size( 300 , 500 , P2D ) ; 
  scaling = pixelDensity*height/1080.0 ; 
  scaledr = scaling*10 ;

  points = new ArrayList<Point>() ;
  fire = new ArrayList<Fire>() ; 
  up = new PVector( 0.5*scaling, -1.2*scaling) ; 
  for ( int i = 0; i < 60; i++ ) points.add( new Point() ) ;
  noStroke() ;
}
void keyPressed() {
  save("C:\\Users\\Chinmay\\Desktop\\tab.png") ; 
}
void draw() { 
  background(0) ; 
  pushMatrix() ; 
  translate( width/2, height/2 ) ; 
  Hour() ; 
  Minute() ; 
  Second() ;  
  popMatrix() ; 
  Clock() ;
  for ( Point p : points ) { 
    p.update() ; 
    p.walls() ; 
    p.display() ;
  }
  for ( int i = fire.size() - 1; i >= 0; i-- ) {
    Fire f = fire.get(i) ;
    f.addspark() ;
    f.stuff() ;
    if ( f.l <= 0 && f.sparks.size() <= 0) fire.remove(i) ;
  }
  if ( mousePressed ) isdown = true ; 
  else isdown = false ; 
  if ( isdown ) {
    fire.add( new Fire(mouseX, mouseY ) ) ;
    //float distoff = dist( mouseX, mouseY, pmouseX, pmouseY ) ; 
    //if (  distoff > 100 ) { 
    //  for( float i = 0 ; i < distoff ; i+= distoff/100 ) 
    //  fire.add( new Fire((pmouseX+mouseX)*i/2, (pmouseY+mouseY)*i/2)); // FIUX THIS
    //}
  }
}
void Hour() { 
  float r = 260*scaling ; 
  float d = PI/360 ; 
  // 
  if ( hour() == 0 ) { 
    d_hr = 0 ;
    b_hr = 60 ;
  }
  if ( d_hr != 2 ) { 
    fill(80, 250, 20, b_hr) ; 
    if ( d_hr == 0 ) b_hr++ ; 
    else b_hr -- ; 
    if ( b_hr >= 355 ) d_hr = 1 ;
    if ( b_hr <= -50 ) d_hr = 2 ;
    for ( float i = 0; i <= TWO_PI; i += d) {
      ellipse( r*cos(i - PI/2), r*sin(i - PI/2), 10, 10);
    }
  }
  fill(80, 250, 20, 60); 
  for ( float i = 0; i <= ( (float)minute()/60 + (float)hour()%12)*PI/6; i += d) {
    ellipse( r*cos(i - PI/2), r*sin(i - PI/2), scaledr, scaledr );
  }
}

void Minute() { 
  float r = 280*scaling ; 
  float d = PI/360 ; 
  // 
  if ( minute() == 0 ) { 
    d_min = 0 ;
    b_min = 130 ;
  }
  if ( d_min != 2 ) { 
    fill(50, 150, 150, b_min) ; 
    if ( d_min == 0 ) b_min++ ; 
    else b_min -- ; 
    if ( b_min >= 255 ) d_min = 1 ;
    if ( b_min <=  0  ) d_min = 2 ;

    for ( float i = 0; i <= TWO_PI; i += d) {
      ellipse( r*cos(i - PI/2), r*sin(i - PI/2), scaledr, scaledr );
    }
  }
  fill(50, 150, 150, 130); 
  for ( float i = 0; i <= ((float)second()/60 + (float)minute())*PI/30; i += d) {
    ellipse( r*cos(i - PI/2), r*sin(i - PI/2), scaledr, scaledr );
  }
}

void Second() {
  float r = 300*scaling ; 
  float d = PI/30 ; 
  // 
  if ( second() == 0 ) { 
    d_sec = 0 ;
    b_sec = 230 ;
  }
  if ( d_sec != 2 ) { 
    fill(b_sec, b_sec ) ; 
    if ( d_sec == 0 ) b_sec += 3 ; 
    else b_sec -= 3 ; 
    if ( b_sec >= 250 ) { 
      d_sec = 1 ;
    }
    if ( b_sec <= 50 ) { 
      d_sec = 2 ;
    }
    for ( float i = 0; i <= TWO_PI; i += d) {
      ellipse( r*cos(i - PI/2), r*sin(i - PI/2), scaledr, scaledr );
    }
  }
  fill(230, 230); 
  for ( float i = 0; i <= second()*PI/30; i += d) {
    ellipse( r*cos(i - PI/2), r*sin(i - PI/2), scaledr, scaledr );
  }
}


void Clock() { 
  String s ; 
  fill(255, 230)  ; 
  textSize(40*scaling) ; 
  textAlign(CENTER, CENTER ) ; 
  s = str(hour()) + " : " + str(minute()) + " : " + str(second()) ; 
  text(s, width/2, height/2) ;

  fill( 255, 25, 25, 175 ) ; 
  textSize(80*scaling) ; 
  textAlign( RIGHT, BOTTOM ) ; 
  s = str( day() ) ; 
  text( s, width/2 - 10, height/2 - 20) ;

  fill( 250, 50, 250, 150 ) ; 
  textSize(60*scaling) ;
  textAlign( LEFT, BOTTOM ) ; 
  s = Months[ month() - 1 ] ;
  text( s, width/2, height/2 - 24 ) ;

  fill( 250, 250, 50, 150 ) ; 
  textSize(30*scaling) ; 
  textAlign( CENTER, TOP ) ; 
  s = Days[ (year() + year()/4 - year()/100 + year()/400 + Days_Buffer[month() - 1] + day() - 1)%7] ;
  text( s, width/2, height/2 + 50) ;
}
