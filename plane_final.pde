//plane test //<>//


Plane flag;
PImage img, sky;
Vec gravity;
Vec wind;
ScrollBar windBar;
ScrollBar gravityBar;
Button imgButton;
Button lineButton;

float maxWind = 10;
int poleLength = 1000;
int row = 50;
int col = 45;
int rowLength;
int colLength;

void setup() {
  //fullScreen(P3D);
  size(1800, 1000, P3D);
  frameRate(30);
  noiseSeed(6174);

  rowLength = 550;
  colLength = 400;
  flag = new Plane(row, col, rowLength, colLength);


  //pin flag
  flag.upperLeft.pinned = true;
  flag.bottomLeft.pinned = true;


  flag.bottomLeft.setPos(width/2, height-poleLength+colLength);
  flag.upperLeft.setPos(width/2, height-poleLength);

  gravity = new Vec(0, 0.05);
  wind = new Vec();

  windBar = new ScrollBar(100, 100, 500, 7, 0, maxWind).setString("wind");
  gravityBar = new ScrollBar(100, 300, 500, gravity.y, 0, 0.2).setString("gravity");
  imgButton = new Button(width-100, 100, 100, 100).setText("img");
  lineButton = new Button(width-100, 220, 100, 100).setText("line");

  img = loadImage("taegukgi.png");
  flag.setImage(img);

  sky = loadImage("school.jpg");
  sky.resize(5000, 2500);
}



void draw() {
  background(170);
  
  if (lineButton.getState()) {
    flag.strokeWeight = 0;
  } else {
    flag.strokeWeight = 0.4;
  }
  pushMatrix();
  translate(0, 0, -300);

  if (sky != null && imgButton.getState()) {
    pushMatrix();
    translate(0, 0, -500);
    image(sky, -1200, -800);
    popMatrix();
  }

  //
  println(gravityBar.getVal());
  gravity.setY(gravityBar.getVal());
  float n = 0;
  for (int i=0; i < col; i++) {
    wind.setX(map(noise(frameCount*0.02, n), 0, 1, map(windBar.getVal(), 0, maxWind, 0, -1), windBar.getVal()));
    wind.setY(map(noise(frameCount*0.04+3000, n+3000), 0, 1, map(windBar.getVal(), 0, maxWind,-1, 0), map(windBar.getVal(), 0, maxWind, 1, 0)));
    wind.setZ(map(noise(frameCount*0.03+1000, n+1000), 0, 1, map(windBar.getVal(), 0, maxWind,-1, 0), map(windBar.getVal(), 0, maxWind, 1, 0)));
    for (int j=0; j<row; j++) {
      wind.add(gravity);
      flag.P[i*row+j].update(wind);
    }
    n += 0.001;
  }
  flag.interact(flag.iterateNum);
  flag.display();
  
  //

  //gravity.setY(gravityBar.getVal());
  //wind.setX(map(noise(frameCount*0.02), 0, 1, map(windBar.getVal(), 0, 10, -2, 0), windBar.getVal()));
  //wind.setZ(map(noise(frameCount*0.03), 0, 1, -1, 1));
  //wind.setY(map(noise(frameCount*0.04+3), 0, 1, -1, 1));
  //Vec netForce = new Vec();
  //netForce.add(wind);
  //netForce.add(gravity);
  //flag.run(netForce);
  //


  strokeWeight(10);
  stroke(0);
  line(flag.upperLeft.curPos.x, flag.upperLeft.curPos.y, width/2, height);

  pushMatrix();
  translate(flag.upperLeft.curPos.x, flag.upperLeft.curPos.y);
  circle(0, 0, 20);
  translate(30, 30);
  popMatrix();


  if (mousePressed && !windBar.lock && !gravityBar.lock && !imgButton.isOver() && !lineButton.isOver()) {

    float angle = atan2(mouseY-height, mouseX-width/2)+PI;
    flag.bottomLeft.setPos(width/2-cos(angle)*(poleLength-colLength), height-sin(angle)*(poleLength-colLength));
    flag.upperLeft.setPos(width/2-cos(angle)*(poleLength), height-sin(angle)*(poleLength));
  }

  popMatrix();
  windBar.run();
  gravityBar.run();
  imgButton.run();
  lineButton.run();
}



void mousePressed() {
  if (windBar.isOver()) {
    windBar.lock = true;
  }
  if (gravityBar.isOver()) {
    gravityBar.lock = true;
  }
}

void mouseClicked() {
  if (imgButton.isOver()) {
    imgButton.toggleState();
  }
  if (lineButton.isOver()) {
    lineButton.toggleState();
  }
}

void mouseReleased() {
  windBar.lock = false;
  gravityBar.lock = false;
}
