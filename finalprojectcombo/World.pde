/**
 *
 * Manages all the input we get from the arduino, and averages the data
 *
 * <p>Bugs: average still doesn't give the best data, the sensor tends to wander, 
 *and is offset depending on where the arduino is upon load so always keep in prime position when initializing
 *(Button left, hinge towards you)
 *It also helps to reset or unplug the arduino if you're getting weird values
 *
 *
 * @author Caileigh Hudson
 *
 *Version 9 (12-11-20)
 */
class World {

  Serial myPort;

  float yaw;
  int avgYaw = 0;
  float pitch;
  int avgPitch = 0;
  float roll;
  int avgRoll = 0;
  float button;
  float[][] pastData  = new float[3][5];
  int[] pastAvg  = new int[3];
  int i = 0;
  boolean arrayFill = false;



  World(PApplet parent) { 
    //PApplet refers to the main code object

    myPort = new Serial(parent, Serial.list()[1], 9600);
    myPort.bufferUntil('\n');
  }

  /**
   *manages all the data we get from arduino
   */
  void serialEvent (Serial myPort) {

    // get the ASCII string:
    String inString = myPort.readStringUntil('\n');
    {

      // trim off any whitespace:
      if (inString != null) {
        inString = trim(inString);

        String[] splitData = inString.split(",");

        //makes sure we don't get an error when arduino doesn't send over 4 values
        if (splitData.length == 4) {

          yaw = float(splitData[0]);
          pitch = float(splitData[1]);
          roll = float(splitData[2]);
          button = float(splitData[3]);


          print(" Yaw: " + yaw);
          print(" Pitch: " + pitch);
          print(" Roll: " + roll);
          println(" Button: " + button);

          pastData[0][i] = yaw;
          pastData[1][i] = pitch;
          pastData[2][i] = roll;

          i++; 


          if ( i >= 4) {
            i = i%5;
            arrayFill = true;
          }


          //getting the average data from the past 5 readings, arrayFill makes sure we aren't reading an empty array
          if (arrayFill) {
            pastAvg[0] = avgYaw;
            pastAvg[1] = avgPitch;
            pastAvg[2] = avgRoll;

            avgYaw = int((pastData[0][0] + pastData[0][1]+pastData[0][2]+pastData[0][3]+pastData[0][4])/5);
            avgPitch = int((pastData[1][0] + pastData[1][1]+pastData[1][2]+pastData[1][3]+pastData[1][4])/5);
            avgRoll = int((pastData[2][0] + pastData[2][1]+pastData[2][2]+pastData[2][3]+pastData[2][4])/5);
            print("avg data"+ avgYaw + ", " +avgPitch + ", " + avgRoll);
          }
        }
      }
    }
  }
}
