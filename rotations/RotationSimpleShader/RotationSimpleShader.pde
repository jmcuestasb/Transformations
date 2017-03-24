// 1. Rotation parameters
float pivotX=30, pivotY=20;
float beta = 0;
boolean applyMatrix = true;
// 2. simple custom shader
PShader simpleShader;

void setup() {
  size(700, 700, P3D);
  // simple custom shader
  simpleShader = loadShader("simple_frag.glsl", "simple_vert.glsl");
  shader(simpleShader);
}

void draw() {
  background(0);
  // default and simple custom shaders:
  if (applyMatrix) {
    // move origin to the center of the screen:
    applyMatrix(1, 0, 0, width/2, 
      0, 1, 0, height/2, 
      0, 0, 1, 0, 
      0, 0, 0, 1);
    // We do the rotation as: T(xr,yr)Rz(β)T(−xr,−yr)
    // 1. T(xr,yr)
    applyMatrix(1, 0, 0, pivotX, 
      0, 1, 0, pivotY, 
      0, 0, 1, 0, 
      0, 0, 0, 1);
    // 2. Rz(β)
    applyMatrix(cos(beta), -sin(beta), 0, 0, 
      sin(beta), cos(beta), 0, 0, 
      0, 0, 1, 0, 
      0, 0, 0, 1);
    // 3. T(−xr,−yr)
    applyMatrix(1, 0, 0, -pivotX, 
      0, 1, 0, -pivotY, 
      0, 0, 1, 0, 
      0, 0, 0, 1);
  } else {
    // move origin to the center of the screen:
    translate(width/2, height/2);
    // we do the rotation as: T(xr,yr)Rz(β)T(−xr,−yr)
    // 1. T(xr,yr)
    translate(pivotX, pivotY);
    // 2. Rz(β)
    rotate(beta);
    // 3. T(−xr,−yr)
    translate(-pivotX, -pivotY);
  }
  pivot();
  lShape();
}

void keyPressed() {
  if (key != '+' && key != '-' && key != ' ')
    return;
  if (key == '+')
    beta += .1;
  if (key == '-')
    beta -= .1;
  if (key == ' ')
    applyMatrix = !applyMatrix;
}

void mouseDragged() {
  beta = map(mouseX, 0, width, HALF_PI, 0);
}

void pivot() {
  pushStyle();
  stroke(0, 255, 255);
  strokeWeight(6);
  point(pivotX, pivotY);
  popStyle();
}

void lShape() {
  pushStyle();
  fill(204, 102, 0, 150);
  rect(50, 50, 200, 100);
  rect(50, 50, 100, 200);
  popStyle();
}