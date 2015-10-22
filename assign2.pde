PImage bg1, bg2, end1, end2, enemy1, fighter, hp, start1, start2, treasure;
final int GAME_START=1, GAME_RUN=2, GAME_OVER=3;  
int gameState;

//gamebackground
int bg1X, bg2X, bg3X;

//fighter
float fighterX, fighterY;
float fighterSpeed = 5;

//fightermove
boolean upPressed = false;
boolean downPressed = false;
boolean leftPressed = false;
boolean rightPressed = false;

//hp
int hpLong;

//enemy
int enemyX;
int enemySpeed;

//treasure
int treasureX, treasureY;


void setup(){
  size(640,480);
  colorMode(RGB);
  
  gameState = GAME_START;
  
  //image
  bg1 = loadImage("img/bg1.png");
  bg2 = loadImage("img/bg2.png");
  end1 = loadImage("img/end1.png");
  end2 = loadImage("img/end2.png");
  enemy1 = loadImage("img/enemy.png");
  fighter = loadImage("img/fighter.png");
  hp = loadImage("img/hp.png");
  start1 = loadImage("img/start1.png");
  start2 = loadImage("img/start2.png");
  treasure = loadImage("img/treasure.png");
  
  //background
  bg1X=0;
  bg2X=0;
  
  //fighter
  fighterX = 640-62;
  fighterY = 240;
  
  //hp
  hpLong = 50;
  
  //enemy
  enemySpeed = 5;
  
  //treasure
  treasureX = floor(random(0,640-41));
  treasureY = floor(random(0,480-41));
  
  
}

void draw(){
  switch(gameState){
    case GAME_START: //start
    image(start2,0,0);
    if (mouseX > 200 && mouseX < 454 && mouseY > 372 && mouseY < 415){
      if (mousePressed){
        //click
        gameState = GAME_RUN;
      }else{
      image(start1,0,0);}
    }
    break;
    
    case GAME_RUN: //run
    //background
    bg1X =(bg1X+1)%1280;
    image(bg1,bg1X,0);
    bg2X =(bg1X-640+1)%1280;
    image(bg2,bg2X,0);
    bg3X =(bg2X-640+1)%1280;
    image(bg1,bg3X,0);
    
    // figtermove
    image(fighter, fighterX, fighterY);
    if (upPressed){
    fighterY = fighterY-fighterSpeed;
    if(fighterY<0){
      fighterY=0;
    }
  }
    if (downPressed){
    fighterY = fighterY+fighterSpeed;
      if(fighterY>419){
        fighterY=419;}
    }
    if (leftPressed){
    fighterX = fighterX-fighterSpeed;
       if(fighterX<0){
         fighterX=0;}
  }
    if (rightPressed){
    fighterX = fighterX+fighterSpeed;
      if(fighterX>579){
        fighterX=579;}
    }
    
    
    //dont let fighter go our
    
    
    
    
    //hp
    rectMode(CORNERS);
    rect(10,9,hpLong,25);
    fill(255,0,0);
    stroke(255,0,0);
    image(hp,2,5);
    
    //enemy
    enemyX = enemyX+enemySpeed;
    enemyX %= 640;
    image(enemy1,enemyX,100);
    if(fighterX >= enemyX && fighterX <= enemyX+61 && fighterY >= 100 && fighterY <= 161 ){
    hpLong -= 40;}
    if(fighterX >= enemyX && fighterX <= enemyX+61 && fighterY >= 100 && fighterY <= 161){
    enemyX = 0;}
   
    
    //treasure
    image(treasure, treasureX, treasureY);
    if(fighterX >= treasureX && fighterX <= treasureX+41 && fighterY >= treasureY && fighterY <= treasureY+41){
    hpLong += 20;}
    if(fighterX >= treasureX && fighterX <= treasureX+41 && fighterY >= treasureY && fighterY <= treasureY+41){
     treasureX = floor(random(0,640-41)); treasureY = floor(random(0,480-41));}
    
    //die
    if(hpLong <= 10){
    gameState = GAME_OVER;}
    
    break;
    
    case GAME_OVER: //gameover
    image(end1,0,0);
    if (mouseX >= 204 && mouseX < 434 && mouseY >= 306 && mouseY <= 350){
      if(mousePressed){
      gameState = GAME_RUN; fighterX = 580 ; fighterY = 240; hpLong = 50;}
    }
    else{image(end2,0,0);}
    break;

  }
}


void keyPressed(){
  if(key == CODED){
    switch (keyCode){
      case UP:
        upPressed = true;
        break;
      case DOWN:
        downPressed = true;
        break;
      case LEFT:
        leftPressed = true;
        break;
      case RIGHT:
        rightPressed = true;
        break;
      }
    }
  }
  
void keyReleased(){
  if(key == CODED){
    switch(keyCode){
      case UP:
        upPressed = false;
        break;
      case DOWN:
        downPressed = false;
        break;
      case LEFT:
        leftPressed = false;
        break;
      case RIGHT:
        rightPressed = false;
        break;
    }
  }

}
