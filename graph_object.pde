
// Graphing sketch

// This program takes ASCII-encoded strings from the serial port at 9600 baud
// and graphs them. It expects values in the range 0 to 1023, followed by a
// newline, or newline and carriage return

// created 20 Apr 2005
// updated 24 Nov 2015
// by Tom Igoe
// This example code is in the public domain.

import processing.serial.*;

Serial myPort; // The serial port
int xPos = 1; // horizontal position of the graph
float inByte = 0;
PImage img;
float xData;
float yData;
float button;


void setup () {
// set the window size:
size(500, 500);

// List all the available serial ports
// if using Processing 2.1 or later, use Serial.printArray()
println(Serial.list());

// I know that the first port in the serial list on my Mac is always my
// Arduino, so I open Serial.list()[0].
// Open whatever port is the one you're using

//I use serial[1], I think my bluetooth is serial [0]
myPort = new Serial(this, Serial.list()[1], 9600);

// don't generate a serialEvent() unless you get a newline character:
myPort.bufferUntil('\n');

// set initial background:
background(0);

//load images
img = loadImage("badfrog2.png");
image(img, 0, 0);
}

void draw () {
// draw the line:
//stroke(127, 34, 255);
//line(xPos, height, xPos, height - inByte);
image(img, xData, yData);
if (button == 0.0){
  tint(random(0,255),random(0,255),random(0,255));
  
  
}

// at the edge of the screen, go back to the beginning:
if (xPos >= width) {
xPos = 0;
background(0);
} else {
// increment the horizontal position:
xPos++;
}
}

void serialEvent (Serial myPort) {
// get the ASCII string:
String inString = myPort.readStringUntil('\n');

if (inString != null) {
// trim off any whitespace:
inString = trim(inString);

String[] splitData = inString.split(",");

xData = float(splitData[0]);
yData = float(splitData[1]);
button = float(splitData[2]);

print("X-value: " + xData);
println(" Y-value: " + yData);
println(" button: " + button);

inByte = map(xData, 0, 1023, width, height);
inByte = map(yData, 0, 1023, width, height);

}
}
