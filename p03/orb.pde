class Orb {
  PVector pos, vel, acc;
  float mass;
  float charge;

  Orb(float x, float y) {
    pos = new PVector(x, y);
    vel = PVector.random2D();
    acc = new PVector();
    mass = random(5, 20);
    charge = random(-1, 1);
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
    }//gravity


    if (mode == 2) { //Spring
      int i = others.indexOf(this);
      if (i > 0) {
        total.add(getSpring(others.get(i - 1)));
      }

      if (i < others.size() - 1) {
        total.add(getSpring(others.get(i + 1)));
      }
    }//spring


    if (mode == 3) { // Drag
      total.add(getDrag());
    }//drag

    if (mode == 4) { // Electrostatic
      for (Orb o : others) {
        if (o != this) {
          total.add(getElectrostatic(o));
          //    total.add(getGravity(o));
        }
      }
    } //electrostatic
    applyForce(total);
  }//applyForces


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
    stretch = constrain(stretch, -50, 50);

    force.normalize();
    force.mult(-k * stretch);

    float maxForce = 5;
    force.limit(maxForce);
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

PVector getElectrostatic(Orb other) {
  PVector force = PVector.sub(other.pos, pos);

  float d = constrain(force.mag(), 5, 50); // avoid infinite force
  force.normalize();

  float strength = (K * charge * other.charge) / (d * d);

  force.mult(strength);
  PVector nil = new PVector(0,0);
  return nil.sub(force.x,force.y);
}


  void move() {
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);

    float r = mass; // radius

    //Boundaries
    if (pos.x < r) {
      pos.x = r;
      vel.x *= (mode == 4 ? -1 : -0.9);
    }
    if (pos.x > width - r) {
      pos.x = width - r;
      vel.x *= (mode == 4 ? -1 : -0.9);
    }
    if (pos.y < r) {
      pos.y = r;
      vel.y *= (mode == 4 ? -1 : -0.9);
    }
    if (pos.y > height - r) {
      pos.y = height - r;
      vel.y *= (mode == 4 ? -1 : -0.9);
    }
  }//move

  void display() {
    if (charge < 0) {
      fill(255, 0, 0);
    } else {
      fill(0, 0, 255);
    }
    stroke(255);
    ellipse(pos.x, pos.y, mass*2, mass*2);
  }
}//class
