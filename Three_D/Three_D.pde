//controls: WASD to move horizontally, space or shift to move vertically (movement is kind of janky)
//          click and drag to rotate objects

float rX, rY, camSpeed;
PVector camPos, camFocusPos, camUp;
boolean strafeR, strafeL, strafeF, strafeB, strafeU, strafeD;

ArrayList<Object> objects = new ArrayList();

PImage diamondImg, dirtImg, grassTopImg, grassSideImg;

void setup()
{
  size(800, 800, P3D);
  textureMode(NORMAL);

  camPos = new PVector(width / 2, height / 2, 1000);
  camFocusPos = new PVector(camPos.x, camPos.y, camPos.z - 1000);
  camUp = new PVector(0, 1, 0);
  camSpeed = 10;

  loadImages();
  addObjects();
}

void draw()
{
  background(0);

  drawGuide(100, height);
  lightScene();

  handleCamera();
  
  drawObjects();
}

void loadImages()
{
  diamondImg = loadImage("diamond.png");
  dirtImg = loadImage("dirt.png");
  grassTopImg = loadImage("grass_top.png");
  grassSideImg = loadImage("grass_side.png");
}

void addObjects()
{
  objects.add(new RPrism(new PVector(width / 2, height / 2, -200), width / 3, height, 100, 200));
  
  objects.add(new Sphere(new PVector(width / 2, height / 2 - 175, 0), 75, color(0, 255, 0)));
  objects.add(new Sphere(new PVector(width / 2, height / 2, 0), 75, color(255, 255, 0)));
  objects.add(new Sphere(new PVector(width / 2, height / 2 + 175, 0), 75, color(255, 0, 0)));
  
  objects.add(new RPrism(new PVector(200, 200, 100), 150, grassTopImg, dirtImg, grassSideImg, grassSideImg, grassSideImg, grassSideImg));
  objects.add(new RPrism(new PVector(width - 200, 200, 100), 150, grassTopImg, dirtImg, grassSideImg, grassSideImg, grassSideImg, grassSideImg));
  objects.add(new RPrism(new PVector(width - 200, height - 200, 100), 150, dirtImg));
  objects.add(new RPrism(new PVector(200, height - 200, 100), 150, dirtImg));
  
  objects.add(new RPrism(new PVector(200, height / 2, 0), 150, diamondImg));
  objects.add(new RPrism(new PVector(width - 200, height / 2, 0), 150, diamondImg));
}

void drawGuide(int n, int h)
{ 
  pushMatrix();
  translate(-(n * n) / 2, h, -(n * n) / 2);
  
  //axis lines
  strokeWeight(5);
  stroke(255, 0, 0);
  line(0, 0, 0, n * n, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, -(n * n) / 2, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, n * n);
  
  //guide lines
  strokeWeight(0.5);
  stroke(255);
  
  for(int i = 0; i <= n; i++)
  {
    //floor
    line(0, 0, i * n, n * n, 0, i * n);
    line(i * n, 0, 0, i * n, 0, n * n);
    //ceiling
    line(0, -(n * n) / 2, i * n, n * n, -(n * n) / 2, i * n);
    line(i * n, -(n * n) / 2, 0, i * n, -(n * n) / 2, n * n);
    //walls
    //if(i <= n / 2) line(0, -(i * n), 0, n * n, -(i * n), 0);
    //line(i * n, 0, 0, i * n, -(n * n) / 2, 0);
  }
  
  popMatrix();
}

void lightScene()
{
  ambientLight(64, 64, 64);
  directionalLight(128, 128, 128, 0, -1, 0);
  directionalLight(128, 128, 128, 0, 1, 0);
  spotLight(255, 255, 255, width / 2, height / 2, 400, 0, 0, -1, 0, 0);
}

void drawObjects()
{
  for(Object object : objects)
    object.show();
}

void handleCamera()
{
  camera(camPos.x, camPos.y, camPos.z, camFocusPos.x, camFocusPos.y, camFocusPos.z, camUp.x, camUp.y, camUp.z);
  
  //movement
  if(strafeF)
  {
    camPos.z -= camSpeed;
    camFocusPos.z -= camSpeed;
  }
  if(strafeL)
  {
    camPos.x -= camSpeed;
    camFocusPos.x -= camSpeed;
  }
  if(strafeB)
  {
    camPos.z += camSpeed;
    camFocusPos.z += camSpeed;
  }
  if(strafeR)
  {
    camPos.x += camSpeed;
    camFocusPos.x += camSpeed;
  }
  if(strafeU)
  {
    camPos.y -= camSpeed;
    camFocusPos.y -= camSpeed;
  }
  if(strafeD)
  {
    camPos.y += camSpeed;
    camFocusPos.y += camSpeed;
  }
}
