/**
 * Simple Write. 
 * 
 * Check if the mouse is over a rectangle and writes the status to the serial port. 
 * This example works with the Wiring / Arduino program that follows below.
 */


import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;        // Data received from the serial port
boolean buttonState = false;

void setup() 
{
  size(800, 800);
  // I know that the first port in the serial list on my mac
  // is always my  FTDI adaptor, so I open Serial.list()[0].
  // On Windows machines, this generally opens COM1.
  // Open whatever port is the one you're using.
  String portName = Serial.list()[1]; //sometimes we have to change this to locate the port
  myPort = new Serial(this, portName, 9600);
}

void draw() {
  background(255);
  color(65, 200, 34);
  rect(375,375,50,50);

  if (mouseX > 375 && mouseX < 425 && mouseY > 375 && mouseY < 425) {
    if (mousePressed == true) {
      fill(random(0,255),random(0,255),random(0,255));
      buttonState = true;
      myPort.write('H'); 
      delay(150);
    } else {
      buttonState  = false;
      myPort.write('L');
      
      
    }
  }      
}  



/*
  // Wiring/Arduino code:
 // Read data from the serial and turn ON or OFF a light depending on the value
 
 char val; // Data received from the serial port
 int ledPin = 4; // Set the pin to digital I/O 4
 
 void setup() {
 pinMode(ledPin, OUTPUT); // Set pin as OUTPUT
 Serial.begin(9600); // Start serial communication at 9600 bps
 }
 
 void loop() {
 while (Serial.available()) { // If data is available to read,
 val = Serial.read(); // read it and store it in val
 }
 if (val == 'H') { // If H was received
 digitalWrite(ledPin, HIGH); // turn the LED on
 } else {
 digitalWrite(ledPin, LOW); // Otherwise turn it OFF
 }
 delay(100); // Wait 100 milliseconds for next reading
 }
 
 */
