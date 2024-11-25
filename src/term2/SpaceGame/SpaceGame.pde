// Luke Robison | 6 Nov 2024 | SpaceGame
SpaceShip s1;
ArrayList<Rock> rocks = new ArrayList<Rock>();
ArrayList<Laser> lasers = new ArrayList<Laser>();
ArrayList<Powerup> powups = new ArrayList<Powerup>();
ArrayList<Star> stars = new ArrayList<Star>();
int score, level;
boolean play;
Timer rTime, puTime;

void setup() {
  size(800, 800);
  s1 = new SpaceShip();
  score = 0;
  level = 1;
  play = false;
  rTime = new Timer(500);
  rTime.start();
  puTime = new Timer(5000);
  puTime.start();
}

void draw() {
  if (!play) {
    startScreen();
  } else {
    background(20);
    stars.add(new Star());
    for (int i=0; i<stars.size(); i++) {
      Star s = stars.get(i);
      s.display();
      s.move();
      if (s.reachedBottom()) {
        stars.remove(s);
      }
    }

    //Render powerups
    if (puTime.isFinished()) {
      powups.add(new Powerup());
      puTime.start();
    }
    for (int i = 0; i <powups.size(); i++) {
      Powerup pu = powups.get(i);
      pu.display();
      pu.move();
      if (pu.intersect(s1)) {
        if (pu.type == 'h') {
          s1.health += 100;
        } else if (pu.type == 'a') {
          s1.laserCount += 100;
        } else if (pu.type == 't') {
          s1.turretCount ++;
        }
        powups.remove(pu);
      }
      //if (pu.intersect(s1) && pu.type == 'h') {
      //  // 1. remove powerup
      //  powups.remove(pu);
      //  // 2. health benefit
      //  s1.health += 100;
      //} else if (pu.intersect(s1) && pu.type == 'a') {
      //  s1.laserCount += 100;
      //  powups.remove(pu);
      //} else if (pu.intersect(s1) && pu.type == 't') {
      //  s1.turretCount ++;
      //  powups.remove(pu);
      //}


      if (pu.reachedBottom()) {
        powups.remove(pu);
      }
    }


    if (rTime.isFinished()) {
      rocks.add(new Rock());
      rTime.start();
    }
    for (int i = 0; i < rocks.size(); i++) {
    Rock rock = rocks.get(i);
    rock.display();
    rock.move();
    if(s1.intersect(rock)) {
      // deduct 10 points
      score -= 10;
      // deduct 10 health;
      s1.health -= 10;
      // delete rock;
      rocks.remove(rock);
    }
    if(rock.reachedBottom()) {
      rocks.remove(rock);
    }
  }
    //if(keyPressed && key == ' ') {
    // lasers.add(new Laser(s1.x,s1.y));
    //}

    // Render lasers and detect rock collide
    for (int i =0; i < lasers.size(); i++) {
      Laser laser = lasers.get(i);
      for (int j = 0; j <rocks.size(); j++) {
        Rock rock = rocks.get(j);
        if (laser.intersect(rock)) {
          rock.diam -= 10;
          if (rock.diam <1) {
            rocks.remove(rock);
          }
          score+= 100;
          lasers.remove(laser);
        }
      }
      laser.display();
      laser.move();
      if (laser.reachedTop()) {
        lasers.remove(laser);
      }
    }
  }
  
  s1.display();
  s1.move(mouseX, mouseY);
  infoPanel();
  // change code to detect when x number of rocks pass
  if (s1.health<1) {
    gameOver();
    noLoop();
  }
}

void infoPanel() {
  rectMode(CENTER);
  fill(127, 127);
  rect(width/2, 20, width, 40);
  fill(255);
  textSize(35);
  text("Score:" + score, 20, 36);
  text("Health:" + s1.health, 200, 36);
  text("Level:" + level, 400, 36);
  text("Ammo:" + s1.laserCount, 500, 36);
}

void startScreen () {
  background(0);
  fill(255);
  text("Welcome to SpaceGame!", width/2, 300);
  text("Made by: Luke Robison", width/2, 320);
  text("Click to Start!", width/2, 340);
  if (mousePressed) {
    play = true;
  }
}

void gameOver () {
  background(0);
  fill(255);
  text("Game Over!", width/2, 300);
  text("Score:" + score, width/2, 320);
  text("Level:"+ level, width/2, 340);
}

void ticker() {
}



void mousePressed () {
  if ( s1.fire() && s1.turretCount == 1) {
    lasers.add(new Laser(s1.x, s1.y));
    s1.laserCount--;
  } else if (s1.fire() && s1.turretCount == 2) {
    lasers.add(new Laser(s1.x-10, s1.y));
    lasers.add(new Laser(s1.x+10, s1.y));
  } else {
    lasers.add(new Laser(s1.x-10, s1.y));
    lasers.add(new Laser(s1.x+10, s1.y));
    s1.laserCount-=2;
  }
}
