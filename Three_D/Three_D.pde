///////////////////////////////////
/*                               */
/*   Press TAB to toggle view    */
/*       (scroll to zoom)        */
/*                               */
///////////////////////////////////

import java.awt.Robot;

Robot mouseBot;

int blockSize = 100;
int shootTimer = 0;
int collideDist = 150;
int crosshairSize = 15;
float rX, rY, moveSpeed, camRotLR, camRotUD;
float tpCamDist = 750;
float camZoomSpeed = 25;

PVector camPos, camFocusPos, camUp;

boolean strafeR, strafeL, strafeF, strafeB, strafeU, strafeD;
boolean thirdPerson;

ArrayList<Object> objects = new ArrayList();

PImage diamondImg, dirtImg, grassTopImg, grassSideImg, mossyStoneBrickImg, oakPlankImg;
PImage floorMap, wallMap, ceilingMap;

color white = #FFFFFF;
color black = #000000;
color green = #00FF00;
color grey = #9b9b9b;
color brown = #bf8240;

PGraphics world, hud;

void setup()
{
  world = createGraphics(width, height, P3D);
  hud = createGraphics(width, height, P2D);
  
  size(displayWidth, displayHeight, P2D);
  noCursor();

  try{ mouseBot = new Robot(); }
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
  worldDraw();
  image(world, 0, 0);
  
  hudDraw();
  image(hud, 0, 0);
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
  //traffic light (rotatable)
  objects.add(new RPrism(new PVector(width / 2, height / 2, -200), width / 3, height, 100, 200));

  objects.add(new Sphere(new PVector(width / 2, height / 2 - 175, 0), 75, color(0, 255, 0)));
  objects.add(new Sphere(new PVector(width / 2, height / 2, 0), 75, color(255, 255, 0)));
  objects.add(new Sphere(new PVector(width / 2, height / 2 + 175, 0), 75, color(255, 0, 0)));

  //floating blocks (rotatable)
  objects.add(new RPrism(new PVector(200, 200, 100), 150, grassTopImg, dirtImg, grassSideImg, grassSideImg, grassSideImg, grassSideImg));
  objects.add(new RPrism(new PVector(width - 200, 200, 100), 150, grassTopImg, dirtImg, grassSideImg, grassSideImg, grassSideImg, grassSideImg));
  objects.add(new RPrism(new PVector(width - 200, height - 200, 100), 150, dirtImg));
  objects.add(new RPrism(new PVector(200, height - 200, 100), 150, dirtImg));

  objects.add(new RPrism(new PVector(200, height / 2, 0), 150, diamondImg));
  objects.add(new RPrism(new PVector(width - 200, height / 2, 0), 150, diamondImg));

  //third-person chracter
  objects.add(new FocusIndicator(blockSize / 2));
  
  //snow clouds
  objects.add(new SnowCloud(400, 25, 400, 250));
  objects.add(new SnowCloud(new PVector(width / 2, -blockSize, 0), width, 25, 400));

  addWorld();
}

void drawObjects()
{
  for(int i = 0; i < objects.size(); i++)
  {
    Object object = objects.get(i);
    
    object.act();
    object.show();
    
    if(object.hp <= 0)
    {
      objects.remove(object);
      i--;
    }
  }
}
