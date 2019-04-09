float colour = random(100,200);
int level = 1;
// r на играч
int radius = 15;
// left/right скорост
int horiz = 5;
// сила на скок
int jump = 7;
// x и y позиции на играч
float xp; 
float yp; 
// x и y скорост;
float xs = 0; 
float ys = 0; 
// съпротивление
float r = 0.7; 
// гравитация
float gravity = 0.4; 
// контроли
boolean upPressed = false;
boolean downPressed = false;
boolean rightPressed = false;
boolean leftPressed = false;
// брой на врагове
int enemyNumber = int(random(7,12));
int shape = int(random(1,3));

// проверка дали си жив
boolean alive = false;
// проверка дали си спечелил
boolean won = false;
int lives = 3;
//масив, който съдържа всички врагове
enemy[] enemies;

void setup() {

  size(1340, 300);
  // стартова позиция
  xp = width*0.2;
  yp = height/2;
  // create the enemy array
  enemies = new enemy[enemyNumber];

  //центрира
  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  // запълваме масива с врагове
 
  for (int i = 0; i<enemies.length; i++) {
    enemies[i] = new enemy(-3, 12, 6);
  }
}

void draw() {

  background(#E88C52);
  for (int q = 0; q<400; q+=50){
    for (int s = 0; s<1900; s+=100){
     fill(colour);
     rect(s,q,100,50);
    }
    
  }
  //ако си жив, програмата работи
  if (alive) {
  
    //функция контроли
    controll();
    //движи играча
    move();
    //стени
    walls();
    //показва играч
    display();
    //показва врагове
    for (int i = 0; i<enemies.length; i++) {
      //отива в специфичен враг намира функция рън и я пуска
      enemies[i].run();
    }
    //ако си умрял
  } else if (!alive) {
    //и не си спечелил
    if (!won) {
      background(27);
      fill(255);
      textSize(30);
      text("CLICK ANYWHERE TO PLAY AGAIN", width/2, height/2);
      fill(250,0,0);
      //aкo спечелиш
    } else if (won) {
      background(27);
      fill(0, 255, 0);
      textSize(50);
      text("YOU WON! \n CLICK ANYWHERE TO PLAY AGAIN.", width/2, height/2);
      level +=1;
    }

       
       
     }
   }
      





//функция контрол
void controll() {
  // if the right key is pressed then make the x-speed be going to the right
  if (rightPressed) {
    xs = horiz;
  }
  // if the left key is pressed then make the x-speed be going left
  if (leftPressed) {
    xs = -horiz;
  }
  // if the up key is pressed then make the y-speed be going up
  if (upPressed) {
    ys = -jump;
  }
  // if the down key is pressed then make the y-speed be going down
  if (downPressed) {
    ys += jump/2;
  }
}

//движение функция
void move() {
  //добавя скоростта към позицията
  xp += xs;
  yp += ys;
 //добавя гравитация и съпротивление към скоростта
  ys += gravity;
  xs *= r;
}


//показва играч
void display() {
  if (shape==1){
  fill(colour,0,0);
  ellipse(xp, yp, radius*2, radius*2);}
  else if(shape==2){
    fill(0,0,colour);
    rect(xp,yp,radius*2,radius*2);
  }
}

//прави стени
void walls() {
  //горна
  if (yp <= radius) {
    yp = radius+1;
    ys = -ys*(r/2);
  }
  //долна
  if (yp >= height-radius) {
    yp = height-(radius+1);
  }
  //лява
  if (xp <= radius) {
    xp = radius+1;
    xs = -xs*(r/2);
  }
  //когато минеш дясната стена, печелиш
  if (xp >= width+radius) {
    alive = false;
    won = true;
  }
}

void keyPressed() {
  if (keyCode == UP) {
    upPressed = true;
  }
  if (keyCode == DOWN) {
    downPressed = true;
  }
  if (keyCode == LEFT) {
    leftPressed = true;
  }
  if (keyCode == RIGHT) {
    rightPressed = true;
  }
}

void keyReleased() {
  if (keyCode == UP) {
    upPressed = false;
  }
  if (keyCode == DOWN) {
    downPressed = false;
  }
  if (keyCode == LEFT) {
    leftPressed = false;
  }
  if (keyCode == RIGHT) {
    rightPressed = false;
  }
}

void mouseReleased() {
  //ако си умрял
  if (!alive) {
    //върни се към живот
    alive = true;
    won = false;
    //пресъздай враговете
    for (int i = 0; i<enemies.length; i++) {
      enemies[i].respawn();
    }
    //презареди скорост
    xs = 0; 
    ys = 0;
    //върни начална позиция
    xp = width*0.2;
    yp = height/2;
  }
}
