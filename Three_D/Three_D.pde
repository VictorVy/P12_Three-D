///////////////////////////////////
/*                               */
/*   Press TAB to toggle view    */
/*       (scroll to zoom)        */
///////////////////////////////////

import java.awt.Robot;

Robot mouseBot;

int worldSize = 100;
float rX, rY, camSpeed, camRotLR, camRotUD;
PVector camPos, camFocusPos, camUp;
boolean strafeR, strafeL, strafeF, strafeB, strafeU, strafeD;
boolean thirdPerson;
float tpCamDist = 750;
float camZoomSpeed = 25;

ArrayList<Object> objects = new ArrayList();

PImage diamondImg, dirtImg, grassTopImg, grassSideImg;

void setup()
{
  size(displayWidth, displayHeight, P3D);
  noCursor();
  textureMode(NORMAL);
  
  try { mouseBot = new Robot(); }
  catch(Exception e) { e.printStackTrace(); }

  camRotLR = radians(-90);
  camPos = new PVector(width / 2, height / 2, 1000);
  camFocusPos = new PVector(camPos.x, camPos.y, camPos.z);
  camUp = new PVector(0, 1, 0);
  camSpeed = 10;

  loadImages();
  addObjects();
}

void draw()
{
  background(0);

  drawGuide();
  lightScene();

  if(!thirdPerson)
    handleFPCamera();
  else
    handleTPCamera();
    
  wrapMouse();

  drawObjects();
}

void loadImages()
{
  diamondImg = loadImage("diamond.png");
  dirtImg = loadImage("dirt.jpg");
  grassTopImg = loadImage("grass_top.jpg");
  grassSideImg = loadImage("grass_side.jpg");
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
  
  objects.add(new FocusIndicator(10, 255));
  
  //world
  for(int r = 0; r < worldSize; r++)
  {
    for(int c = 0; c < worldSize; c++)
      objects.add(new Block(new PVector(c * worldSize, 0, r * worldSize), worldSize, grassTopImg));
  }
}

void drawGuide()
{ 
  pushMatrix();
  translate(-(worldSize * worldSize) / 2, height, -(worldSize * worldSize) / 2);
  
  //axis lines
  strokeWeight(5);
  stroke(255, 0, 0);
  line(0, 0, 0, worldSize * worldSize, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, -(worldSize * worldSize) / 2, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, worldSize * worldSize);
  
  //guide lines
  strokeWeight(0.5);
  stroke(255);
  
  for(int i = 0; i <= worldSize; i++)
  {
    //floor
    line(0, 0, i * worldSize, worldSize * worldSize, 0, i * worldSize);
    line(i * worldSize, 0, 0, i * worldSize, 0, worldSize * worldSize);
    //ceiling
    line(0, -(worldSize * worldSize) / 2, i * worldSize, worldSize * worldSize, -(worldSize * worldSize) / 2, i * worldSize);
    line(i * worldSize, -(worldSize * worldSize) / 2, 0, i * worldSize, -(worldSize * worldSize) / 2, worldSize * worldSize);
  }
  
  popMatrix();
}

void lightScene()
{
  ambientLight(64, 64, 64);
  directionalLight(128, 128, 128, 0, -1, 0);
  directionalLight(128, 128, 128, 0, 1, 0);
  directionalLight(128, 128, 128, 1, 0, 0);
  directionalLight(128, 128, 128, -1, 0, 0);
  directionalLight(128, 128, 128, 0, 0, 1);
  directionalLight(128, 128, 128, 0, 0, -1);
  spotLight(255, 255, 255, width / 2, height / 2, 400, 0, 0, -1, 0, 0);
}

void handleFPCamera()
{
  camera(camPos.x, camPos.y, camPos.z, camFocusPos.x, camFocusPos.y, camFocusPos.z, camUp.x, camUp.y, camUp.z);
  
  //movement
  if(strafeF)
  {
    camPos.x += cos(camRotLR) * camSpeed;
    camPos.z += sin(camRotLR) * camSpeed;
  }
  if(strafeL)
  {
    camPos.x -= cos(camRotLR + PI * 0.5) * camSpeed;
    camPos.z -= sin(camRotLR + PI * 0.5) * camSpeed;
  }
  if(strafeB)
  {
    camPos.x -= cos(camRotLR) * camSpeed;
    camPos.z -= sin(camRotLR) * camSpeed;
  }
  if(strafeR)
  {
    camPos.x += cos(camRotLR + PI * 0.5) * camSpeed;
    camPos.z += sin(camRotLR + PI * 0.5) * camSpeed;
  }
  if(strafeU)
    camPos.y -= camSpeed;
  if(strafeD)
    camPos.y += camSpeed;
  
  camFocusPos.x = camPos.x + cos(camRotLR) * 250;
  camFocusPos.y = camPos.y + tan(camRotUD) * 250;
  camFocusPos.z = camPos.z + sin(camRotLR) * 250;
}

void handleTPCamera()
{
  camera(camPos.x, camPos.y, camPos.z, camFocusPos.x, camFocusPos.y, camFocusPos.z, camUp.x, camUp.y, camUp.z);
  
  //movement
  if(strafeF)
  {
    camFocusPos.x += cos(camRotLR) * camSpeed;
    camFocusPos.z += sin(camRotLR) * camSpeed;
  }
  if(strafeL)
  {
    camFocusPos.x -= cos(camRotLR + PI * 0.5) * camSpeed;
    camFocusPos.z -= sin(camRotLR + PI * 0.5) * camSpeed;
  }
  if(strafeB)
  {
    camFocusPos.x -= cos(camRotLR) * camSpeed;
    camFocusPos.z -= sin(camRotLR) * camSpeed;
  }
  if(strafeR)
  {
    camFocusPos.x += cos(camRotLR + PI * 0.5) * camSpeed;
    camFocusPos.z += sin(camRotLR + PI * 0.5) * camSpeed;
  }
  if(strafeU)
    camFocusPos.y -= camSpeed;
  if(strafeD)
    camFocusPos.y += camSpeed;
  
  camPos.x = camFocusPos.x - cos(camRotLR) * tpCamDist;
  camPos.y = camFocusPos.y - tan(camRotUD) * tpCamDist;
  camPos.z = camFocusPos.z - sin(camRotLR) * tpCamDist;
}

void wrapMouse()
{
  if(mouseX > width - 2) mouseBot.mouseMove(2, mouseY);
  else if(mouseX < 2) mouseBot.mouseMove(width - 2, mouseY);
  
  if(mouseY > height - 2) mouseBot.mouseMove(mouseX, 2);
  else if(mouseY < 2) mouseBot.mouseMove(mouseX, height - 2);
}

void drawObjects()
{
  for(Object object : objects)
    object.show();
}
