import processing.serial.*;
//Serial myPort;

//float yaw;
//float pitch;
//float roll;
//float button;
PShape earth;
int gamemode;
Village village;
World world;
//world = new World();
//village = new Village();



void setup() {
  size(512, 512, P3D);
  earth = loadShape("EarthModel.obj");
  gamemode = 1;
  // set the window size:
  // List all the available serial ports
  // if using Processing 2.1 or later, use Serial.printArray()
  println(Serial.list());

  // I know that the first port in the serial list on my Mac is always my
  // Arduino, so I open Serial.list()[0].
  // Open whatever port is the one you're using

  //I use serial[1], I think my bluetooth is serial [0]
 // myPort = new Serial(this, Serial.list()[1], 9600);

  // don't generate a serialEvent() unless you get a newline character:
  //myPort.bufferUntil('\n');

  // set initial background:
  background(0);
}



void globeGraph() {
  lights();
  camera(0, 0, height * .86602, 
    0, 0, 0, 
    0, 1, 0);
  shape(earth);
  earth.rotateY((world.roll -100)/10);
  print(round(world.yaw/10));
  earth.rotateX(round(yaw/10));
}

void draw() {
  background(0xffffffff);
  if (gamemode == 1) {
    globeGraph();
  }else if(gamemode == 2){
    //village code here
  }
  
}
