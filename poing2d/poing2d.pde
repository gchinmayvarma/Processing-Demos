PVector player, enemy, ball, up ;
float ballSpeedX, ballSpeedY, enemySpeed, ballSize, es, ka ;
int playerScore = 0, enemyScore = 0, rc = 255, bc = 0, gc = 0 ;
ArrayList <Fire> fire ;
void setup()
{
  fullScreen() ; // size(480, 320) ; 
  //orientation(LANDSCAPE);
  //size(displayWidth, displayHeight);
  ball = new PVector(width/2, height/2);
  player = new PVector(width, height/2);
  enemy = new PVector(0, height/2);
  up = new PVector( 0, -0.2 ) ;
  fire = new  ArrayList<Fire>() ; 
  ballSpeedX = width/100;
  ballSpeedY = width/100; 
  es = width/200 ; 
  enemySpeed = es ; 
  ballSize = width/20;
  rectMode(CENTER) ;
  ka = 0 ;//width/40 ;
}

void draw()
{
  background(0); 
  //centerLine();
  drawBall();
  drawPlayer();
  drawEnemy();
  scoreText();
  noStroke() ; 
  for ( int i = fire.size() - 1; i >= 0; i-- ) {
    Fire f = fire.get(i) ;
    f.addspark() ;
    f.stuff() ;
    if ( f.l <= 0 && f.sparks.size() <= 0) fire.remove(i) ;
  }
  ka += 0.1 ; 
  if ( ka >= width/40 ) ka = 0 ;
}
/*
    println("-------");
 println("X: " + accelerometerX);
 println("Y: " + accelerometerY);
 println("Z: " + accelerometerZ);
 println("-------");
 */

void drawBall()
{
  //pushMatrix();
  //translate(ball.x, ball.y);
  //fill(255 * (ball.x/width), 255 * ((width - ball.x)/width), 0);
  //noStroke();
  ellipse(ball.x, ball.y, width/20, width/20);
  //popMatrix();
  ball.x += ballSpeedX ;
  ball.y += ballSpeedY ;
  fire.add( new Fire(ball.x, ball.y) ) ; 
  ballBoundary();
}

void ballBoundary()
{
  if (ball.y < 0) {
    ball.y = 0;
    ballSpeedY *= -1;
  }
  if (ball.y > height) {
    ball.y = height;
    ballSpeedY *= -1;
  }
  //float playerDist = ball.dist(player);
  if (ball.x > width) {
    ball.x = width/2;
    ballSpeedX *= -1;
    enemyScore ++;
    gc = 100 ; 
    rc = 100 ; 
    bc = 0 ;
  }
  if (ball.x < 0) {
    ball.x = width/2; 
    ballSpeedX *= -1;
    playerScore ++;
    gc = 255 ; 
    rc = 255 ; 
    bc = 0 ;
  }
  if (ball.x > width - width/40 - ballSize && ball.x < width && Math.abs(ball.y - player.y) < width/10) {
    ball.x = width - width/40 - ballSize;
    ballSpeedX *= -1;
    bc = 200 ; 
    rc = 255 ;
    gc = 0 ;
  }
  if (ball.x < width/40 + ballSize && ball.x > 0 && Math.abs(ball.y - enemy.y) < width/10) {
    ball.x = width/40 + ballSize;
    ballSpeedX *= -1;
    bc = 50 ; 
    rc = 255 ;
    gc = 15 ;
  }
}

void drawPlayer()
{  
  player.y = mouseY;
  pushMatrix();
  translate(player.x - width/20, player.y);
  stroke(0);
  fill(255);
  rect(0, 0, width/20, width/5);
  //box(width/20, width/5, width/50);
  popMatrix();
}

void drawEnemy()
{
  enemy.y += enemySpeed;

  pushMatrix();
  translate(enemy.x + width/20, enemy.y);
  fill(255, 0, 0);
  rect(0, 0, width/20, width/5);
  //box(width/20, width/5, width/50);  
  popMatrix();

  enemyAI();
}

void enemyAI()
{
  if (enemy.y < ball.y) enemySpeed = es ;
  if (enemy.y > ball.y) enemySpeed = - es ; 
  if (enemy.y == ball.y) enemySpeed = 0;
  if (ball.x > width/2) enemySpeed = 0;
}

void scoreText()
{
  //fill(255);
  textSize(width/20);
  if ( enemyScore > playerScore ) fill( 255, 255, 0 ) ; 
  else fill(255) ; 
  text(enemyScore, width/10 * 3, height/5);
  if ( enemyScore < playerScore ) fill( 255, 255, 0 ) ; 
  else fill(255) ;
  text(playerScore, width/10 * 7, height/5);
}

void centerLine()
{
  int numberOfLines = 20; 
  for (int i = int(ka); i < numberOfLines; i++) {
    strokeWeight(width/100);
    stroke(255);
    line(width/2, i * width/numberOfLines, width/2, (i+1) * width/numberOfLines - width/40);
    stroke(0, 0);
    line(width/2, (i+1) * width/numberOfLines - width/40, width/2, (i+1) * width/numberOfLines);
  }
}
