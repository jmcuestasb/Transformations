/**
This sketch shows how geometric transformations could be regarded as
changing the frame (coordinate system) of reference. It also shows how
to use a matrix stack of transformations to "navigate" among frames.
See: http://processing.org/reference/pushMatrix_.html

A scene graph is just a hierarchy of nested frames. Here we implement
the following scene graph:

    W
    ^
    |\
    | \
    |  \
   L1  Eye
    ^\
    | \
    |  \
   L2  L3


Using off-screen rendering we draw the above scene twice.
See: http://processing.org/reference/PGraphics.html

Press any key and see what happens.

 -jp
*/

PFont font;

//Choose FX2D, JAVA2D, P2D
String renderer = P2D;

void setup() {
  size(700, 700, renderer);
  font = createFont("Arial", 12);
  textFont(font, 12);
}

public void draw() {
  background(255);
  drawAxes();
  // define a local frame L1 (respect to the world)
  pushMatrix();
  translate(350, 100);
  rotate(QUARTER_PI / 2);  
  // draw a robot in L1
  fill(255,0,0);
  robot();
  // define a local frame L2 respect to L1
  pushMatrix();
  translate(240, 300);
  rotate(-QUARTER_PI);
  scale(2);
  // draw a house in L2
  fill(0, 255, 255);
  house();
  // "return" to L1
  popMatrix();
  // define a local coordinate system L3 respect to L1
  pushMatrix();
  translate(50,300);
  rotate(HALF_PI);
  scale(1.5);
  // draw a robot in L3
  fill(38, 38, 200);
  robot();
  // return to L1
  popMatrix();
  // return to world
  popMatrix();
}

void robot() {
  robot(true);
}

//taken from: https://processing.org/tutorials/transform2d/
void robot(boolean drawAxes) {
  if(drawAxes)
    drawAxes();
  pushStyle();
  noStroke();
  rect(20, 0, 38, 30); // head
  rect(14, 32, 50, 50); // body
  rect(0, 32, 12, 37); // left arm
  rect(66, 32, 12, 37); // right arm
  rect(22, 84, 16, 50); // left leg
  rect(40, 84, 16, 50); // right leg
  fill(222, 222, 249);
  ellipse(30, 12, 12, 12); // left eye
  ellipse(47, 12, 12, 12); // right eye
  popStyle();
}

void house() {
  house(true);
}

//taken from: https://processing.org/tutorials/transform2d/
void house(boolean drawAxes) {
  if(drawAxes)
    drawAxes();
  pushStyle();
  triangle(15, 0, 0, 15, 30, 15);
  rect(0, 15, 30, 30);
  rect(12, 30, 10, 15);
  popStyle();
}

void drawAxes() {
  pushStyle();
  // X-Axis
  strokeWeight(4);
  stroke(255, 0, 0);
  fill(255, 0, 0);
  line(0, 0, 100, 0);
  text("X", 100 + 5, 0);
  // Y-Axis
  stroke(0, 0, 255);
  fill(0, 0, 255);
  line(0, 0, 0, 100);
  text("Y", 0, 100 + 15);
  popStyle();
}