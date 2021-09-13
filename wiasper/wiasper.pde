int num = 60;
float mx[] = new float[num];
float my[] = new float[num];

void setup() {
  size(640, 360);
  frameRate(120) ; 
  noStroke();
  fill(255, 153); 
}

void draw() {
  background(51); 
  int which = frameCount % num;
  mx[which] = mouseX;
  my[which] = mouseY;
  
  for (int i = 0; i < num; i++) {
    // which+1 is the smallest (the oldest in the array)
    int index = (which+1 + i) % num;
    ellipse(mx[index], my[index], i, i);
  }
}
