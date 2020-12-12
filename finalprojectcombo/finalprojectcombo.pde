/**
 *
 * The main game class, has the basic setup() and draw() that runs the code, 
 *also in charge of detecting mouse clicks and loading and displaying 3D graphics
 *
 *
 * <p> Globe position doesn't seem to want to rotate side from side, but front back works well. 
 *village code doesn't work and loads graphics way too low (?) when you switch gamemode while running
 *
 *
 * @author Caileigh Hudson
 *
 *Version 3 (12-11-20)
 */
import processing.serial.*;

float lastRoll;
float lastYaw; 
PShape earth;
int gamemode;
float angle = 0;
World w;
Village v;
Villager m;



void setup() {
  //instantiate all the classes
  w = new World(this);
  v = new Village();
  m = new Villager();

  earth = loadShape("EarthModel.obj");
  gamemode = 2;
  lastRoll = w.roll;
  lastYaw = w.yaw;


  // set the window size: 
  size(1000, 800, P3D);

  // set initial background:
  background(0, 19, 48);
}

void mousePressed() {

  if (mouseX >= 100 && mouseX < 140 && mouseY >= 700 && mouseY <= 790) {
    //rain clicked 
    v.raincloud = loadImage("rainclicked.png");
    v.sun = loadImage("sun.png");
    v.sunMode = false;
    v.rainMode = true;
  } else if (mouseX >= 150 && mouseX < 200 && mouseY >= 700 && mouseY <= 790) {
    //sun clicked 
    v.sun = loadImage("sunclicked.png");
    v.raincloud = loadImage("rain.png");
    v.sunMode = true;
    v.rainMode = false;
  } else {
    v.sun = loadImage("sun.png");
    v.raincloud = loadImage("rain.png");
    v.sunMode = false;
    v.rainMode = false;
  }
}

/**
 *  creates a serial event in the main code that triggers the one inside World
 */
void serialEvent(Serial p) { 
  w.serialEvent(p);
}

/**
 *  manages graphics for the globe model, updates model position based on arduino averages
 */
void globeGraph() {

  lights();
  camera(0, 0, height * .86602, 
    0, 0, 0, 
    0, 2, 0);
  shape(earth);

  if (w.arrayFill) {

    if (w.avgRoll - w.pastAvg[2] < -5) {
      earth.rotateY(-0.1);
      angle += -0.1;
    } else if (w.avgRoll - w.pastAvg[2] > 5) {
      earth.rotateY(0.1);
      angle += 0.1;
    } 

    if (w.avgYaw - w.pastAvg[0] < -5) {
      earth.rotateX(-0.1);
      angle += -0.1;
    } else if (w.avgYaw - w.pastAvg[0] > 5) {
      earth.rotateX(0.1);
      angle += 0.1;
    }
  }
}


void draw() {
  background(0xffffffff);
  v.counter(); 

  if (gamemode == 1) {
    globeGraph();
  } else if (gamemode == 2) {
    v.villageGraphics();
    m.drawVill();
  }
}
