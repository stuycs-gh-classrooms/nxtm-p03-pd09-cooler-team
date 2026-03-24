ArrayList<Orb> orbs;

boolean isMoving = true;

int mode = 1; //1=gravity, 2=spring, 3=drag

float G = 1;
float K = 200;
float k = 0.005;
float restLength = 100;
float dragC = 0.02;


void setup() {
  size(800, 600);
  resetSimulation();
}


void resetSimulation() {
  orbs = new ArrayList<Orb>();

  if (mode == 2) {
    // spring layout (line)
    float startX = 200;
    float y = height / 2;

    for (int i = 0; i < 5; i++) {
      orbs.add(new Orb(startX + i * restLength, y));
    }
  } //mode 2

  else {
    // electrostatics + others (random)
    for (int i = 0; i < 5; i++) {
      orbs.add(new Orb(random(width), random(height)));
    }
  }
}//resetSimulation


void draw() {
  background(20);

  drawMenu();

  // draw springs between all pairs (only in spring mode)
  if (mode == 2) {
    for (int i = 0; i < orbs.size() - 1; i++) {
      drawSpring(orbs.get(i), orbs.get(i + 1));
    }
  }
  for (Orb o : orbs) {
    if (isMoving) {
      o.applyForces(orbs);
      o.move();
    }
    o.display();
  }
}//draw

void drawSpring(Orb o0, Orb o1) {
  float d = o0.pos.dist(o1.pos); // distance between orbs

  if (d > restLength) { // stretched
    stroke(255, 0, 0); // red
  } else if (d < restLength) { // compressed
    stroke(0, 255, 0); // green
  } else { // perfect length
    stroke(255);
  }

  line(o0.pos.x, o0.pos.y, o1.pos.x, o1.pos.y);
}//drawSpring


void drawMenu() {
  fill(255);
  textSize(14);

  String modeName = "";
  if (mode == 1) modeName = "Gravity";
  if (mode == 2) modeName = "Spring";
  if (mode == 3) modeName = "Drag";
  if (mode == 4) modeName = "Electrostatics";


  text("Mode: " + modeName, 10, 20);
  text("Movement: " + (isMoving ? "ON" : "OFF"), 10, 40);
  text("Keys: 1=Gravity | 2=Spring | 3=Drag | 4=Electrostatics | SPACE=Move", 10, 60);
}//draw menu

void keyPressed() {
  if (key == ' ') isMoving = !isMoving;

  if (key >= '1' && key <= '4') {
    mode = key - '0';
    resetSimulation();
  }
}//keypressed
