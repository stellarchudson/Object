/**
 *
 * Draws the villager and updates effects on them
 *
 * <p>Bugs: lags a lot when the villager moves too much, necromancy is possible, walk cycle is wack
 *
 * @author Caileigh Hudson
 *
 *Version 2 (12-11-20)
 */
class Villager {
  PImage man;
  int x;
  int y = 400;
  int i = 1;

  //instantiate the class
  Villager() {
    man = loadImage("vill1.png");
  }

  /** 
   *controlls all the villager graphics
   */
  void drawVill() {
    image(man, x, y);

    if (!v.alive) {
      //riv you funky little dude
      man = loadImage("vill5.png");
    } else if (v.status[4] >= 90) {
      //hungy
      man = loadImage("vill7.png");
    } else if (v.status[3] >= 80) {
      //sad
      man = loadImage("vill6.png");
    } else {

      //walk cycle- villager stands still if they are upset. Updates randomly so they wander a bit
      switch(int(random(0, 100))) {
      case 1: //move left
        for (int r = 1; r < int(random(3, 20)); r++) {
          man = loadImage("vill2.png");
          image(man, x, y);
          x -= 2;

          man = loadImage("vill1.png");
          image(man, x, y);
          x -= 2;
        }
        break;
      case 2: //move right
        for (int r = 1; r < int(random(3, 13)); r++) {
          man = loadImage("vill11.png");
          image(man, x, y);
          x += 2;

          man = loadImage("vill9.png");
          image(man, x, y);
          x += 2;

          man = loadImage("vill12.png");
          image(man, x, y);
          x += 2;

          man = loadImage("vill9.png");
          image(man, x, y);
          x += 2;
        }
        break;
      }

      //prevents villager from wandering off screen
      if (x>780) {
        x -= 2;
      } else if (x < 0) {
        x += 2;
      }
    }
  }
}
