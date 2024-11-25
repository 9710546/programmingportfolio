class Powerup {
  // Member Variables
  int x, y, diam, speed;
  char type;
  //PImage r1;

  // Constructor
  Powerup() {
    x = int(random(width));
    y = -100;
    diam = 50;
    speed = int (random(1, 5));
    //r1 = loadImage ("rock01.png");
    int rand = int(random(3));
    if (rand == 0) {
      type = 'h';
    } else if (rand == 1) {
      type = 'a';
    } else if (rand == 2) {
      type = 't';
    }
  }


  // Member Methods
  void display() {
    if (type == 'h') {
      fill(0, 255, 0);
    } else if (type == 'a') {
      fill(255, 0, 0);
    } else if (type == 't') {
      fill(0, 0, 255);
    }
    ellipse(x, y, diam, diam);
    //imageMode(CENTER);
    //r1.resize(diam,diam);
    //image(r1, x, y);
  }

  void move() {
    y += speed;
  }

  boolean reachedBottom() {
    if (y>height) {
      return true;
    } else {
      return false;
    }
  }
  boolean intersect(SpaceShip s) {
    float d = dist(x, y, s.x, s.y);
    if (d<50) {
      return true;
    } else {
      return false;
    }
  }
}
