import processing.video.*;
ArrayList fish = new ArrayList();
Capture video;
boolean videoToggle;

ColorTracker orangeFish, greenFish, blueFish, yellowBarnacle, pinkBarnacle, purpleBarnacle, greenBarnacle;

//bluegreenFish, orangegreenFish, seaHorse, yellowFish, octopus, redFish, dolphin;
 
void setup() {
  size(640, 640);
  video = new Capture(this,width,height);
  video.start();
  
  orangeFish = new ColorTracker(color(119,61,28),video);
  greenFish = new ColorTracker(color(29,60,36),video);
  blueFish = new ColorTracker(color(0,10,74),video);
  yellowBarnacle = new ColorTracker(color(160,147,69),video);
  pinkBarnacle = new ColorTracker(color(71,16,48),video);
  purpleBarnacle = new ColorTracker(color(61,26,72),video);
  greenBarnacle = new ColorTracker(color(95,131,78),video);
  //octopus = new ColorTracker(color(18,22,96),video);
  //redFish = new ColorTracker(color(97,16,41),video);
  //dolphin = new ColorTracker(color(15,29,95),video);
  //greenorangeFish = new ColorTracker(color(2,2,110),video);
  //allFish = new ColorTracker(color(46,60,62),video);
  
  /* Gives a nice glow feel */
  strokeWeight(10);
  /*
   IMPORTANT: because we are using vertex's to make our fish, the line joining becomes spiky when the
   strokeWeight is bigger than 1.
   */
  strokeJoin(ROUND);
  /* Add 100 fish */
  for (int i = 0; i < 60; i++) {
    fish.add(new Fish());
  }
}
 
void draw() {
  video.loadPixels();
  
  fill(0, 30);
  rect(-10, -10, width+20, height+20);
  fill(255, 255, 255, 255);
  stroke(255, 255, 255);
  
  if(videoToggle){
    image(video,0,0);
  }
  
  orangeFish.update();
  greenFish.update();
  blueFish.update();
  yellowBarnacle.update();
  pinkBarnacle.update();
  purpleBarnacle.update();
  greenBarnacle.update();
  //orangegreenFish.update();
  //seaHorse.update();
  //yellowFish.update();
  //octopus.update();
  //redFish.update();
  //dolphin.update();
  //allFish.update();
 
  for (int i = 0; i < fish.size (); i++) {
    Fish f = (Fish) fish.get(i);
    f.draw();
    f.boundaries();
  }
}
 
class Fish {
  PVector loc;
  PVector vel;
  /* Just to add some individuality to the fish wiggle */
  float s = random(-90, 90);
  float d = random(0.1, 0.3);
 
  Fish() {
    loc = new PVector(random(width), random(height));
    /* Make a random velocity */
    vel = new PVector(random(-1, 1), random(-1, 1));
  }
 
  void draw() {
    loc.add(vel);
    pushMatrix();
    translate(loc.x, loc.y);
    scale(d);
    /* Get the direction and add 90 degrees. */
    rotate(vel.heading2D()-radians(90));
    beginShape();
    for (int i = 0; i <= 180; i+=20) {
      float x = sin(radians(i)) * i/3;
      float angle = sin(radians(i+s+frameCount*5)) * 50;
      vertex(x-angle, i*2);
      vertex(x-angle, i*2);
    }
    /*
     Started from the top now we are here. We need to now start to draw from where the first for loop left off.
     Otherwise un ugly line will appear down the middle. To see what I mean uncomment the below line and comment
     the other line.
     */
    for (int i = 180; i >= 0; i-=20) {
      //for (int i = 0; i < 180; i+=20){
      float x = sin(radians(i)) * i/3;
      float angle = sin(radians(i+s+frameCount*5)) * 50;
      vertex(-x-angle, i*2);
      vertex(-x-angle, i*2);
    }
    endShape();
    popMatrix();
  }
 
  void boundaries() {
    /* Instead of changing the velocity when the fish  */
    if (loc.x < -100) loc.x = width+100;
    if (loc.x > width+100) loc.x = -100;
    if (loc.y < -100) loc.y = height+100;
    if (loc.y > height+100) loc.y = -100;
  }
}
void captureEvent(Capture video){
  video.read();  
}



