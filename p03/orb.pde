class Orb {
  PVector pos, vel, acc;
  float mass;
  
  Orb(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D();
    acc = new PVector();
    mass = random(5, 20);
  }
  
  void applyForce(PVector f) {
    PVector a = PVector.div(f, mass);
    acc.add(a);
  }//applyforce 
  
  void applyForces(ArrayList<Orb> others) {
    PVector total = new PVector();
    
    if (mode == 1) { // Gravity
      for (Orb o : others) {
        if (o != this) {
          total.add(getGravity(o));
        }
      }
    }
    
    if (mode == 2) { // Spring
      for (Orb o : others) {
        if (o != this) {
          total.add(getSpring(o));
        }
      }
    }
    
    if (mode == 3) { // Drag
      total.add(getDrag());
    }
    
    applyForce(total);
  }

  PVector getGravity(Orb other) {
    PVector force = PVector.sub(other.pos, pos);
    
    float d = constrain(force.mag(), 5, 50);
    force.normalize();
    
    float strength = (G * mass * other.mass) / (d * d);
    force.mult(strength);
    
    return force;
  } //gravity
  

  PVector getSpring(Orb other) {
    PVector force = PVector.sub(other.pos, pos);
    
    float d = force.mag();
    float stretch = d - restLength;
    
    force.normalize();
    
    float strength = -k * stretch;
    force.mult(strength);
    
    return force;
  }//spring
  
  PVector getDrag() {
    PVector force = vel.copy();
    
    float speed = force.mag();
    
    force.normalize();
    force.mult(-1);
    
    float strength = dragC * speed * speed;
    force.mult(strength);
    
    return force;
  }//drag
  

  void move() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
  

  void display() {
    fill(100, 200, 255);
    stroke(255);
    ellipse(pos.x, pos.y, mass*2, mass*2);
  }
}
