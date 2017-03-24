// 1. Rotation parameters
float pivotX=30, pivotY=20;
float beta = 0;
// 2. unal custom shader, with custom (unalMatrix) uniforms
PShader unalShader;
//the unal shader thus requires all of the following:
PMatrix3D modelview, projection;
PMatrix3D projectionTimesModelview;

void setup() {
  size(700, 700, P2D);
  // unal custom shader, with custom (unalMatrix) uniforms
  unalShader = loadShader("unal_frag.glsl", "unal_vert.glsl");
  shader(unalShader);
  // the unal shader thus requires projection and modelview matrices:
  modelview = new PMatrix3D();
  projection = new PMatrix3D();
  projection.m00 = 2.0f / width;
  projection.m11 = -2.0f / height;
  projection.m22 = -1;
  projectionTimesModelview = new PMatrix3D();
}

void draw() {
  background(0);
  //discard Processing matrices (only necessary in P3D)
  //resetMatrix();
  //load identity
  modelview.reset();
  // we do the rotation as: T(xr,yr)Rz(β)T(−xr,−yr)
  // 1. T(xr,yr)
  modelview.translate(pivotX, pivotY);
  // 2. Rz(β)
  modelview.rotate(beta);
  // 3. T(−xr,−yr)
  modelview.translate(-pivotX, -pivotY);
  //emit model-view and projection custom matrices
  emitUniforms();
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

//Whenever the model-view or projection matrices changes we need to emit the uniforms
void emitUniforms() {
  projectionTimesModelview.set(projection);
  projectionTimesModelview.apply(modelview);
  //GLSL uses column major order, whereas processing uses row major order
  projectionTimesModelview.transpose();
  unalShader.set("unalMatrix", projectionTimesModelview);
}