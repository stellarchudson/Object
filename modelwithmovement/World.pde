import processing.serial.*;

class World{{
  float yaw;
float pitch;
float roll;
float button;

  Serial myPort;
  myPort = new Serial(this, Serial.list()[1], 9600);
  myPort.bufferUntil('\n');
  
  //Serial myPort; // The serial port
  
  
  // get the ASCII string:
  String inString = myPort.readStringUntil('\n');{

  if (inString != null) {
    // trim off any whitespace:
    inString = trim(inString);

    String[] splitData = inString.split(",");

    yaw = float(splitData[0]);
    pitch = float(splitData[1]);
    roll = float(splitData[2]);
    button = float(splitData[3]);


    print(" Yaw: " + yaw);
    print(" Pitch: " + pitch);
    print(" Roll: " + roll);
    println(" Button: " + button);
  
  
}
}
}}
