class Rock {
  // Member Variables
  int x, y, diam, speed;
  PImage r1;

  // Constructor
  Rock() {
    x = int(random(width));
    y = -100;
    diam = 50;
    speed = int (random(1, 5));
    r1 = loadImage ("rock01.png");
  }

  // Member Methods
  void display() {
    //fill(127);
    //ellipse(x, y, diam, diam);
    imageMode(CENTER);
    r1.resize(diam,diam);
    image(r1, x, y);
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
