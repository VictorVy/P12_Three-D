//controls: WASD to move horizontally, space or shift to move vertically (movement is kind of janky)
//          click and drag to rotate objects

float rX, rY;
float camX, camY, camZ, camSpeed, camFocusX, camFocusY;
boolean strafeR, strafeL, strafeF, strafeB, strafeU, strafeD;

ArrayList<Object> objects = new ArrayList();

PImage diamondImg, dirtImg, grassTopImg, grassSideImg;

void setup()
{
  size(800, 800, P3D);
  textureMode(NORMAL);

  camX = width / 2;
  camY = height / 2;
  camZ = 1000;
  camSpeed = 10;
  camFocusX = width / 2;
  camFocusY = height / 2;

  loadImages();
  addObjects();
}

void draw()
{
  background(0);

  camera(camX, camY, camZ, camFocusX, camFocusY, camZ - 1000, 0, 1, 0);
  
  drawObjects();
  moveCamera();
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

void drawObjects()
{
  for(Object object : objects)
    object.show();
}

void moveCamera()
{
  if(strafeF)
    camZ -= camSpeed;
  if(strafeL)
  {
    camX -= camSpeed;
    camFocusX -= camSpeed;
  }
  if(strafeB)
    camZ += camSpeed;
  if(strafeR)
  {
    camX += camSpeed;
    camFocusX += camSpeed;
  }
  if(strafeU)
  {
    camY -= camSpeed;
    camFocusY -= camSpeed;
  }
  if(strafeD)
  {
    camY += camSpeed;
    camFocusY += camSpeed;
  }
}
