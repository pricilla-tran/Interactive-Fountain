// A simple Particle class

class WaterDrop {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float lifespan;
  color WaterColour;
  
  WaterDrop(PVector l) {
    acceleration = new PVector(0, 0);
    float vx = randomGaussian()*0.3;
    float vy = randomGaussian()*0.3 - 1.0;
    velocity = new PVector(vx, vy);
    //velocity = new PVector(random(-1, 1), random(-2, 0));
    position = l.copy();
    lifespan = 100.0;
  }
   
  
  void applyForce(PVector f) {
    acceleration.add(f);
  }
  
  void run() {
    update();
    display();
  }

  // Method to update position
  void update() {
    velocity.add(acceleration);
    position.add(velocity);
    lifespan -= 1.0;
    acceleration.mult(0);
  }

  // Method to display
  void display() {
    ellipseMode(CENTER);
    stroke(255, lifespan);
    fill(255, lifespan);
    ellipse(position.x, position.y, 10, 15);
    stroke(#8CD6F7, lifespan);
    fill(#8CD6F7, lifespan);
    ellipse(position.x, position.y-10, 15, 10);
  }

  // Is the particle still useful?
  boolean isDead() {
    if (lifespan < 0.0) {
      return true;
    } else {
      return false;
    }
  }
}
