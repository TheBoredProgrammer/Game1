class enemy {
  //скорост враг
  float speed;
  float g = random(0,255);
  //локация
  float xl;
  float yl;
  //радиус
  int rad;
  //брой редове
  float rowNumber;
  //размер
  float rowSize;
  enemy(int spt, int radt, int rowNumbert) {
    speed = spt;
    rad = radt;
    rowNumber = rowNumbert;
    rowSize = height/rowNumber;
    //пресъздава враг
    respawn();
  }
  //движи
  void move() {
    xl += speed;
    if(keyPressed&&keyCode==RIGHT){
    xl += speed+0.0000;
    }
  }
  //създава враг на случайна позиция
  void respawn() {
    xl = int(int(random(0, width/rowSize))*rowSize)+width;
    yl = int(int(random(1, rowNumber+1))*rowSize-rowSize/2);
  }
  //убива играч ако се докоснат с врага
  void collide() {
    if (abs(xp-xl)<rad+radius && abs(yp-yl)<rad+radius) {
        alive = false;

    }
  }
  //връща врага когато излезе от екрана
  void teleport() {
    if (xl<-radius) {
      respawn();
    }
  }
  void display() {
    fill(0,g,0);
    rect(xl, yl, rad*2, rad*2);
  }
  void run() {
    move();
    teleport();
    display();
    collide();
  }
}
