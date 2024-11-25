class SpaceShip {
  // Member Variables
  int x,y,w,laserCount,turretCount,health;
  
  // Constructor
  SpaceShip() {
    x = width/2;
    y = height/2;
    w = 100;
    laserCount = 25;
    turretCount = 1;
    health = 100;
  }
  
  // Member Methods
  void display() {
    // paste spaceship code
    strokeWeight(3);
  fill(50);
  // thrusters
  rect(x+10,y+20,15,20);
  rect(x-25,y+20,15,20);
  stroke(70);
  fill(235);
  // turrets
  line(x+30,y-20,x+30,y+20);
  line(x-30,y+20,x-30,y-20);
  // wings
  triangle(x,y-30,x+45,y+30,x-45,y+30);
  fill(235);
  // center
  ellipse(x,y,20,80);
  // cockpit
  ellipse(x,y,10,100);
  //flames
  ellipse(x+18,y+60,13,30);
  ellipse(x-18,y+60,13,30);
  stroke(-150);
  // in side flame
  fill(255,0,0);
  ellipse(x+18,y+60,9,30);
  ellipse(x-18,y+60,9,30);
  }
  
  void move(int x,int y) {
      this.x = x;
      this.y = y;
  }
  
  boolean fire() {
  if (laserCount > 0) {
    return true;
  } else { 
    return false;
  }
}
  
  boolean intersect(Rock r) {
    float d = dist(x, y, r.x, r.y);
    if (d<50) {
    return true;
    } else {
      return false;
    }
  }
}
