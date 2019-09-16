
class Pipe {//#creative
  float x;
  float y;
  float topH;
  float bottomY;
  float bottomH;
  float w = 40;

  Pipe() {
    x = wid + w;
    topH = random(100, height/2);
    bottomY = topH + 150;
    bottomH = height - (topH + 150);
  }

  boolean hits(Cat cat) {//collision detection
    if ((cat.pos.x > x) && (cat.pos.x < (x + w))) {
      if ((cat.pos.y < (topH + cat.r)) || (cat.pos.y > (height - bottomH - cat.r))) {
        return true;
      }
    }
    return false;
  }

  void update() {
    x -= 3;
  }

  void display(boolean hit) {
    stroke(255);

    if (hit) {
      gamestate = 3;
    } else {
      fill(255);
    }

    rect(x, 0, w, topH); 
    rect(x, bottomY, w, bottomH);
  }
}