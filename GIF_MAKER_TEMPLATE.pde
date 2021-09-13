int totalFrames = 120 ; 
int counter = 0 ;
boolean record = false ; 
void setup() { 
  size(400,400) ; 
}

void draw() { 
  float t = float(counter) / totalFrames ; 
  render(t) ; 
  if(record) { 
    saveFrame("output/gif"+nf(counter,3)+".png"); 
    if(counter == totalFrames - 1) exit() ; 
  }
  counter++ ;
  counter %= totalFrames;
}

void render(float t){
  background(23) ; 
  //fill(255) ; 
  //ellipse(t*width,height/2 , 20,20) ; 
  float angle = t*TWO_PI ; 
  translate(width/2 , height/2 ) ; 
  rectMode(CENTER) ; 
  noFill() ; 
  stroke(255) ; 
  strokeWeight(2) ; 
  rotate(angle) ; 
  square(0,0,100) ; 
}
