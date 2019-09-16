class Cat {//#creative
  PVector pos;
  PVector vel;
  PVector acc;
  float r = 20;
  Cat() {
    pos = new PVector(50, height/2);//position
    vel = new PVector(0, 0);//velocity
    acc = new PVector();//acceloration
  }

  void applyForce(PVector force) {
    acc.add(force);//force applied to the top of the object
  }

  void update() {
    applyForce(gravity);
    pos.add(vel);//adding velocity to position
    vel.add(acc);//adding acceleloration to veloicty
    vel.limit(4);//velocity limit
    acc.mult(0);//multiplying the acceleration

    if (pos.y > height) {
      pos.y = height;
      vel.mult(0);
    }
  }

  void display() {
    image(nyan[m], pos.x, pos.y, r*5, r*2); 
    m++;
    if (m >= nyan.length) {//resets the animation loop
      m = 0;
    }
    nyan[m].resize(100, 40);
  }
}