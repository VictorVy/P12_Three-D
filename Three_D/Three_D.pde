///////////////////////////////////
/*                               */
/*   Press TAB to toggle view    */
/*       (scroll to zoom)        */
/*                               */
///////////////////////////////////

import java.awt.Robot;

Robot mouseBot;

int mode = 0, INTRO = 0, GAME = 1; //modes

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

PGraphics intro, world, hud;

void setup()
{
  intro = createGraphics(width, height, P3D);
  world = createGraphics(width, height, P3D);
  hud = createGraphics(width, height, P2D);
  
  size(displayWidth, displayHeight, P2D);
  noCursor();

  try{ mouseBot = new Robot(); }
  catch(Exception e) { e.printStackTrace(); }

  loadImages();

  introSetup();
}

void draw()
{
  if(mode == INTRO)
    introDraw();
  else if(mode == GAME)
    gameDraw();
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
