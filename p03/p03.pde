ArrayList<Orb> orbs;

boolean isMoving = true;

int mode = 1; // 1=gravity, 2=spring, 3=drag

float G = 1;
float K = 200;
float k = 0.05;
float restLength = 100;
float dragC = 0.02;


void setup() {
  size(800, 600);
  resetSimulation();
}


void resetSimulation() {
  orbs = new ArrayList<Orb>();
  
  for (int i = 0; i < 5; i++) {
    Orb o = new Orb(random(width), random(height));
    orbs.add(o);
  }
}


void draw() {
  background(20);
  
  drawMenu();
  
  for (Orb o : orbs) {
    if (isMoving) {
      o.applyForces(orbs);
      o.move();
    }
    
    o.display();
  }
}


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
}


void keyPressed() {
  if (key == ' ') isMoving = !isMoving;
  
  if (key >= '1' && key <= '4') {
    mode = key - '0';
    resetSimulation();
  }
}
