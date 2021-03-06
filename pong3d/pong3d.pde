import ketai.sensors.*;


//PVector contains x, y, z components for each of the elements listed. Used for positioning.
PVector player, enemy, ball;

//speeds for things that are moving automatically (the ball and the enemy)
float ballSpeedX, ballSpeedY, enemySpeed;

//declare and initializing scores
int playerScore = 0;
int enemyScore = 0;

//declaring ball size
float ballSize;


//sensor stuff
KetaiSensor sensor;
float accelerometerX, accelerometerY, accelerometerZ;

void setup()
{
    /*for desktop testing*/
    //size(480, 320, OPENGL);
  
  
    /*
    For Android devices, you'll want to set the sketch window size as below to take the full screen.
    If you don't set the orientation, your app will have auto-rotate enabled.
    */
    //orientation(PORTRAIT);
    size(displayWidth, displayHeight, OPENGL);
   
    
    /*
    Instead of using actual numbers, we're using ratios of width and height for different objects here. 
    This is to ensure that visual elements retain their relative sizes when running on multiple resolutions.
    */
    ball = new PVector(width/2, height/2);
    player = new PVector(width, height/2);
    enemy = new PVector(0, height/2);
    
    /*
    Same idea as using ratios for sizes. We want the ball to move at relatively same speed across multiple resolutions, so we're using ratios.
    */
    ballSpeedX = width/100;
    ballSpeedY = width/100;
    
    
    enemySpeed = width/150;
    
    ballSize = width/40;
    
    //accelerometer info
    sensor = new KetaiSensor(this);
    sensor.start();
      
}

//this part runs every frame, calls all the methods that need to run every frame
void draw()
{
    //background is important for clearing the frame every frame, so that there is nothing remaining from the previous frame drawn
    background(0);
    
    //lights create lighting effect for the 3d elements on the scene
    lights();
    
    float tempOrientation = (float) ((int) (accelerometerY * 1000)) / 1000;
    
    //camera sensor test
    camera(width/2.0 + tempOrientation * width/10, height/2.0, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0);
    
    //calling methods for drawing the ball, the player, the enemy, and the scores
    
    centerLine();
    drawBall();
    drawPlayer();
    drawEnemy();
    scoreText();
    
    
    println("-------");
    println("X: " + accelerometerX);
    println("Y: " + accelerometerY);
    println("Z: " + accelerometerZ);
    println("-------");
}

//draw and move the ball
void drawBall()
{
    pushMatrix();
      translate(ball.x, ball.y, width/100);
      fill(255);
      
      fill(255 * (ball.x/width), 255 * ((width - ball.x)/width), 0);
      
      noStroke();
      //ellipse(0, 0, width/20, width/20);
      sphere(ballSize);
    popMatrix();
    
    ball.x += ballSpeedX;
    ball.y += ballSpeedY;
    
    ballBoundary();
}

//creates boundaries for the ball to detect
void ballBoundary()
{
   //top
   if (ball.y < 0) {
      ball.y = 0;
      ballSpeedY *= -1; 
   }
  
   //bottom
   if (ball.y > height) {
      ball.y = height;
      ballSpeedY *= -1; 
   }
  
  
//   //left
//   if (ball.x < 0) {
//      ball.x = 0;
//      ballSpeedX *= -1; 
//   }
//  
//  
//   //right 
//   if (ball.x > width) {
//      ball.x = width;
//      ballSpeedX *= -1; 
//   }

    float playerDist = ball.dist(player);
    
    if (ball.x > width) {
       ball.x = width/2;
       ballSpeedX *= -1;
       enemyScore ++;
    }
    
    if (ball.x < 0) {
       ball.x = width/2; 
       ballSpeedX *= -1;
       playerScore ++;
    }
    
    //player
    if (ball.x > width - width/40 - ballSize && ball.x < width && Math.abs(ball.y - player.y) < width/10) {
       ball.x = width - width/40 - ballSize;
       ballSpeedX *= -1;
    }
    
    //enemy
    if (ball.x < width/40 + ballSize && ball.x > 0 && Math.abs(ball.y - enemy.y) < width/10) {
       ball.x = width/40 + ballSize;
       ballSpeedX *= -1; 
    }
    
    
 
}

//draws player bar
void drawPlayer()
{  
   player.y = mouseY;
  
   pushMatrix();
     translate(player.x, player.y);
     stroke(0);
     strokeWeight(1);
     fill(255);
     box(width/20, width/5, width/50);
   popMatrix();
  
}

// draw enemy bar
void drawEnemy()
{
    enemy.y += enemySpeed;
  
    pushMatrix();
      translate(enemy.x, enemy.y);
      fill(255, 0, 0);
      strokeWeight(1);
      box(width/20, width/5, width/50);  
    popMatrix();
    
    enemyAI();
  
}

//determines the movement of enemy bar depending on ball location
void enemyAI()
{
    if (enemy.y < ball.y) {
      enemySpeed = width/150;
    }
    
    if (enemy.y > ball.y) {
      enemySpeed = - width/150; 
    }
    
    if (enemy.y == ball.y) {
      enemySpeed = 0; 
    }
    
    if (ball.x > width/2) {
      enemySpeed = 0; 
    }
}

//display score text
void scoreText()
{
    fill(255);
    textSize(width/20);
    text(enemyScore, width/10 * 3, height/5);
    text(playerScore, width/10 * 7, height/5);  
}

//assign values to accelerometer variables
void onAccelerometerEvent(float x, float y, float z)
{
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}

//draw dotted lines on the center
void centerLine()
{
  //number of dots on the line
   int numberOfLines = 20;
  
   for (int i = 0; i < numberOfLines; i++) {
     strokeWeight(width/100);
     stroke(255);
     line(width/2, i * width/numberOfLines, width/2, (i+1) * width/numberOfLines - width/40);
     stroke(0, 0);
     line(width/2, (i+1) * width/numberOfLines - width/40, width/2, (i+1) * width/numberOfLines);
     
   }
}
