/**
 *
 * Takes care of all the village code, tracks all the various statuses that effect the world, and draws the backgroud graphics
 *
 * <p>Bugs: lags a lot when time changes, i hate how the rain looks, (consider splitting into another class? getting kinda long)
 *
 *
 * @author Caileigh Hudson
 *
 * Version 6.5 (12-11-20)
 *
 *Bug fixes: flood now makes you sad
 */
class Village {


  float[] status = {0, 0, 0, 0, 0, 0, 0}; //fire, flood, earthquakes, happyness, food, time, energy

  //all the images
  PImage background;
  PImage crops;
  PImage cloud;
  PImage flood;
  PImage raincloud;
  PImage sun;
  PImage raindrops;
  PImage happy = loadImage("happy1.png");
  PImage food = loadImage("food1.png");
  PImage energy = loadImage("energy1.png");

  //asset lists
  String[] happyList = {"happy1.png", "happy2.png", "happy4.png", "happy5.png", "happy7.png", "happy8.png", "happy9.png"};
  String[] foodList = {"food1.png", "food2.png", "food3.png", "food4.png", "food5.png", "food6.png", "food8.png", "food9.png", "food10.png"};
  String[] energyList = {"energy1.png", "energy2.png", "energy3.png", "energy4.png", "energy5.png", "energy6.png", "energy7.png", "energy9.png", "energy10.png"};

  int i = 1;
  int[] cloudData = {int(random(50, 100)), int(random(50, 100)), int(random(0, 400)), int(random(1, 6))};

  //game states
  boolean day = true;
  boolean sunMode = false;
  boolean rainMode = false;
  boolean alive = true;
  float moisture = 0;

  color sky = color(150, 230, 255);

  //instantiate the class
  Village() {

    //randomly picks location
    String[] village = {"Beach", "Desert", "Mountain"};
    int whichLand = int(random(village.length));
    background = loadImage(village[whichLand]+ "Background.png");
    image(background, 0, 0);

    background(0, 0, 100);

    //loading in images
    cloud = loadImage("White.png");
    flood = loadImage("flood.png");
    raincloud = loadImage("rain.png");
    raindrops = loadImage("raindrops.png");
    sun = loadImage("sun.png");
    crops = loadImage("crops.png");

    status[5]=50; //start at day
  }

  /**
   * All the graphics and things that need to run in the main class go here. 
   *Mostly just displays the images but also controlls when flood (and other disasters if I implement them) triggers
   */
  void villageGraphics() {

    clear();

    modes();

    //sky color
    background(sky);
    if (day && moisture <= 20) {
      sky = color(150, 230, 255);
    } else if (!day) {
      sky = color(0, 19, 48);
    }

    //cloud cycles
    image(cloud, i + cloudData[0] % cloudData[3], cloudData[2], cloudData[0], cloudData[1]);
    image(cloud, i * cloudData[3], 20, cloudData[0] + cloudData[1], cloudData[1] + cloudData[0]);
    image(cloud, i + 2 * cloudData[3], 0, cloudData[0] + cloudData[0], cloudData[1] + cloudData[1]);
    image(cloud, int(i + cloudData[1] * cloudData[3]), cloudData[2], cloudData[0] + cloudData[0], cloudData[1] + cloudData[1]);
    image(background, -2, 150);

    i += 1;
    if (i ==1000) {
      i = 0;
    }

    //flood
    if (moisture >= 20) {
      sky = color(128, 128, 128);
      image(flood, 0, 100);
      status[3] += 0.01;
      
      if (day) {
        moisture -= 2;
      }
    }


    image(happy, 900, 750, 50, 50);
    image(food, 950, 750, 50, 50);
    image(energy, 850, 750, 50, 50);
    image(raincloud, 100, 750, 50, 50);
    image(sun, 150, 750, 50, 50);
    image(crops, 600, 620, 200, 200);

    //rain
    if (rainMode && w.button == 1.0) {
      moisture += 0.01;
      image(raindrops, 150, 0+i, 1000, 800);
    }
  }



  /**
   * keeps track of when the buttons are clicked, and looks at globe position to determine time change 
   *(tilt forward for night, back for day with the button to the left and the hinge facing towards you)
   */
  void modes() {

    if (sunMode && w.avgYaw >= 4) {
      //day
      day = true;
      status[5] = 0;
    }
    if (sunMode && w.avgYaw >= -40) {
      //night
      day = false;
      status[6] = 1;
      status[5] = 131;
    }
  }

  /**
   * The timer method, this keeps track of and gradually increases all the statuses as time goes on.
   * Also manages the graphics for all the visible statuses like hunger, energy, and mood.
   * Also keeps track of the day/night cycle which currently lasts about 2 mins
   *
   *@return status, the list of all the current statuses -> fire, flood, earthquakes, happyness, food, time, energy
   */
  float[] counter() {

    for (int j = 0; j < status.length; j++) {
      status[j] = status[j] + 0.05; //change this number to change the rate of status growth
    }

    // day/night cycle
    if (status[5] < 70) {
      //day
      day = true;
      status[3] -= 0.1;
    } else if (status[5] > 70 && status[5] < 130) {
      //night
      day = false;
      status[6] = 1;
    } else {
      //loops day back after night
      status[5] = 0;
    }

    if (moisture > 5 && day) {
      //food growth
      status[4] -= 1;
    }

    //-counter visuals-//

    //hunger visuals
    switch(int(status[4])) {
    case 1: 
      food = loadImage(foodList[0]);
      crops = loadImage("crops6.png");
      status[3] -= 1;
      break;
    case 30: 
      food = loadImage(foodList[1]); 
      crops = loadImage("crops5.png");
      break;
    case 40: 
      food = loadImage(foodList[2]); 
      crops = loadImage("crops4.png");
      break;
    case 50: 
      food = loadImage(foodList[3]); 
      crops = loadImage("crops3.png");
      break;
    case 60: 
      food = loadImage(foodList[4]);
      crops = loadImage("crops3.png");
      break;
    case 70: 
      food = loadImage(foodList[5]); 
      crops = loadImage("crops2.png");
      break;
    case 80: 
      food = loadImage(foodList[6]);
      crops = loadImage("crops2.png");
      break;
    case 90: 
      food = loadImage(foodList[7]);
      crops = loadImage("crops1.png");
      break;
    case 100: 
      food = loadImage(foodList[8]);
      crops = loadImage("crops.png");
      break;
    case 160: 
      food = loadImage(foodList[8]);
      alive = false; //f

      break;
    }

    //mood visuals
    switch(int(status[3])) {
    case 1: 
      happy = loadImage(happyList[0]);
      status[3] -= 1;
      break;
    case 30: 
      happy = loadImage(happyList[1]); 
      break;
    case 40: 
      happy = loadImage(happyList[2]); 
      break;
    case 50: 
      happy = loadImage(happyList[3]); 
      break;
    case 60: 
      happy = loadImage(happyList[4]); 
      break;
    case 70: 
      happy = loadImage(happyList[5]); 
      break;
    case 80: 
      happy = loadImage(happyList[6]);
      break;
    case 120: 
      happy = loadImage(happyList[6]);
      alive = false;
      break;
    }

    //energy visuals
    switch(int(status[6])) {
    case 1: 
      energy = loadImage(energyList[0]);
      break;
    case 30: 
      energy = loadImage(energyList[1]); 
      break;
    case 40: 
      energy = loadImage(energyList[2]); 
      break;
    case 50: 
      energy = loadImage(energyList[3]); 
      break;
    case 60: 
      energy = loadImage(energyList[4]); 
      break;
    case 70: 
      energy = loadImage(energyList[5]); 
      break;
    case 80: 
      energy = loadImage(energyList[6]);
      break;
    case 90: 
      energy = loadImage(energyList[7]);
      break;
    case 160: 
      energy = loadImage(energyList[7]);
      alive = false;
      break;
    }

    return status;
  }
}
