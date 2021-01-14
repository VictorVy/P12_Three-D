///////////////////////////////////
/*                               */
/*   Press TAB to toggle view    */
/*       (scroll to zoom)        */
/*                               */
///////////////////////////////////

import java.awt.Robot;

Robot mouseBot;

int blockSize = 100;
float rX, rY, moveSpeed, camRotLR, camRotUD;
PVector camPos, camFocusPos, camUp;
boolean strafeR, strafeL, strafeF, strafeB, strafeU, strafeD;
boolean thirdPerson;
float tpCamDist = 750;
float camZoomSpeed = 25;

ArrayList<Object> objects = new ArrayList();

PImage diamondImg, dirtImg, grassTopImg, grassSideImg, mossyStoneBrickImg, oakPlankImg;
PImage floorMap, wallMap, ceilingMap;

void setup()
{
  size(displayWidth, displayHeight, P3D);
  noCursor();
  textureMode(NORMAL);
  
  try { mouseBot = new Robot(); }
  catch(Exception e) { e.printStackTrace(); }

  camRotLR = radians(-90);
  camPos = new PVector(width / 2, height - blockSize * 3, 1000);
  camFocusPos = new PVector(camPos.x, camPos.y, camPos.z);
  camUp = new PVector(0, 1, 0);
  moveSpeed = 20;

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
  floorMap = loadImage("floorMap.png");
  wallMap = loadImage("wallMap.png");
  ceilingMap = loadImage("ceilingMap.png");
  
  diamondImg = loadImage("diamond.png");
  dirtImg = loadImage("dirt.jpg");
  grassTopImg = loadImage("grassTop.jpg");
  grassSideImg = loadImage("grassSide.jpg");
  mossyStoneBrickImg = loadImage("mossyStoneBrick.png");
  oakPlankImg = loadImage("oakPlank.png");
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
  
  objects.add(new FocusIndicator(blockSize / 2));
  
  addWorld();
}

void addWorld() //using img to map out floor
{
  for(int r = 0; r < floorMap.height; r++)
  {
    for(int c = 0; c < floorMap.width; c++)
    {
      PImage image;
      color colour;
      
      //floor
      colour = floorMap.get(c, r); 
      
      if(colour == #000000) image = dirtImg;
      else if(colour == #00FF00) image = grassTopImg;
      else if(colour == #9b9b9b) image = mossyStoneBrickImg;
      else if(colour == #bf8240) image = oakPlankImg;
      else continue;
      
      objects.add(new Block(new PVector(c * blockSize, -blockSize, r * blockSize), blockSize, image));
      
      //walls
      colour = wallMap.get(c, r); 
            
      if(colour == #000000) image = dirtImg;
      else if(colour == #00FF00) image = grassTopImg;
      else if(colour == #9b9b9b) image = mossyStoneBrickImg;
      else if(colour == #bf8240) image = oakPlankImg;
      else continue;
      
      objects.add(new Block(new PVector(c * blockSize, -blockSize * 2, r * blockSize), blockSize, image));
      objects.add(new Block(new PVector(c * blockSize, -blockSize * 3, r * blockSize), blockSize, image));
      objects.add(new Block(new PVector(c * blockSize, -blockSize * 4, r * blockSize), blockSize, image));
      
      //ceiling
      colour = ceilingMap.get(c, r); 
            
      if(colour == #000000) image = dirtImg;
      else if(colour == #00FF00) image = grassTopImg;
      else if(colour == #9b9b9b) image = mossyStoneBrickImg;
      else if(colour == #bf8240) image = oakPlankImg;
      else continue;
      
      objects.add(new Block(new PVector(c * blockSize, -height, r * blockSize), blockSize, image));
    }
  }
}

void drawGuide()
{ 
  pushMatrix();
  translate(-(blockSize * blockSize) / 2, height, -(blockSize * blockSize) / 2);
  
  //axis lines
  strokeWeight(5);
  stroke(255, 0, 0);
  line(0, 0, 0, blockSize * blockSize, 0, 0);
  stroke(0, 255, 0);
  line(0, 0, 0, 0, -(blockSize * blockSize) / 2, 0);
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, blockSize * blockSize);
  
  //guide lines
  strokeWeight(0.5);
  stroke(255);
  
  for(int i = 0; i <= blockSize; i++)
  {
    //floor
    line(0, 0, i * blockSize, blockSize * blockSize, 0, i * blockSize);
    line(i * blockSize, 0, 0, i * blockSize, 0, blockSize * blockSize);
    //ceiling
    line(0, -(blockSize * blockSize) / 2, i * blockSize, blockSize * blockSize, -(blockSize * blockSize) / 2, i * blockSize);
    line(i * blockSize, -(blockSize * blockSize) / 2, 0, i * blockSize, -(blockSize * blockSize) / 2, blockSize * blockSize);
  }
  
  popMatrix();
}

void lightScene()
{
  ambientLight(64, 64, 64); //don't work on textures, for some odd reason
  
  directionalLight(128, 128, 128, 0, -1, 0);
  directionalLight(128, 128, 128, 0, 1, 0);
  directionalLight(128, 128, 128, 1, 0, 0);
  directionalLight(128, 128, 128, -1, 0, 0);
  directionalLight(128, 128, 128, 0, 0, 1);
  directionalLight(128, 128, 128, 0, 0, -1);
  
  //spotLight(255, 255, 255, width / 2, height / 2, 400, 0, 0, -1, 0, 0);
  
  if(!thirdPerson)
    pointLight(255, 255, 255, camPos.x, camPos.y, camPos.z);
  else
    pointLight(255, 255, 255, camFocusPos.x, camFocusPos.y, camFocusPos.z);
}

void handleFPCamera()
{
  camera(camPos.x, camPos.y, camPos.z, camFocusPos.x, camFocusPos.y, camFocusPos.z, camUp.x, camUp.y, camUp.z);
  
  //movement
  if(strafeF)
  {
    camPos.x += cos(camRotLR) * moveSpeed;
    camPos.z += sin(camRotLR) * moveSpeed;
  }
  if(strafeL)
  {
    camPos.x -= cos(camRotLR + PI * 0.5) * moveSpeed;
    camPos.z -= sin(camRotLR + PI * 0.5) * moveSpeed;
  }
  if(strafeB)
  {
    camPos.x -= cos(camRotLR) * moveSpeed;
    camPos.z -= sin(camRotLR) * moveSpeed;
  }
  if(strafeR)
  {
    camPos.x += cos(camRotLR + PI * 0.5) * moveSpeed;
    camPos.z += sin(camRotLR + PI * 0.5) * moveSpeed;
  }
  if(strafeU)
    camPos.y -= moveSpeed;
  if(strafeD)
    camPos.y += moveSpeed;
  
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
    camFocusPos.x += cos(camRotLR) * moveSpeed;
    camFocusPos.z += sin(camRotLR) * moveSpeed;
  }
  if(strafeL)
  {
    camFocusPos.x -= cos(camRotLR + PI * 0.5) * moveSpeed;
    camFocusPos.z -= sin(camRotLR + PI * 0.5) * moveSpeed;
  }
  if(strafeB)
  {
    camFocusPos.x -= cos(camRotLR) * moveSpeed;
    camFocusPos.z -= sin(camRotLR) * moveSpeed;
  }
  if(strafeR)
  {
    camFocusPos.x += cos(camRotLR + PI * 0.5) * moveSpeed;
    camFocusPos.z += sin(camRotLR + PI * 0.5) * moveSpeed;
  }
  if(strafeU)
    camFocusPos.y -= moveSpeed;
  if(strafeD)
    camFocusPos.y += moveSpeed;
  
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
