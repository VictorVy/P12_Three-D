///////////////////////////////////
/*                               */
/*   Press TAB to toggle view    */
/*       (scroll to zoom)        */
/*                               */
///////////////////////////////////

//apologies, the organization is terrible because I wanted to combine all the 3D stuff into one project :^(

import java.awt.Robot;

Robot mouseBot;

int mode = 0, INTRO = 0, GAME = 1, PAUSE = 2, GAMEOVER = 3; //modes

int pLives, deathWindowDist;
int blockSize = 100;
int shootTimer = 0;
int collideDist = 150;
int crosshairSize = 15;
int dmgAlpha = 0;
float rX, rY, moveSpeed, camRotLR, camRotUD;
float fpFocusDist = 250;
float tpCamDist = 750;
float camZoomSpeed = 34;

PVector camPos, camFocusPos, camUp;

boolean strafeR, strafeL, strafeF, strafeB, strafeU, strafeD;
boolean thirdPerson;

ArrayList<Object> objects = new ArrayList();

PImage diamondImg, dirtImg, grassTopImg, grassSideImg, mossyStoneBrickImg, oakPlankImg;
PImage floorMap, wallMap, ceilingMap;
PImage screenCap;

color white = #FFFFFF;
color black = #000000;
color green = #00FF00;
color grey = #9b9b9b;
color brown = #bf8240;

PGraphics layer, world, hud;
PFont mcTitle, mcRegular;

Button startButton, exitButton, retryButton;

void setup()
{
  layer = createGraphics(width, height, P3D);
  world = createGraphics(width, height, P3D);
  hud = createGraphics(width, height, P2D);
  mcTitle = createFont("mcTitle.ttf", 256);
  mcRegular = createFont("mcRegular.ttf", 128);
  
  size(displayWidth, displayHeight, P2D);

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
  else if(mode == PAUSE)
    pauseDraw();
  else if(mode == GAMEOVER)
    gameOverDraw();
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

void updateObjects()
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

//I took inspiration from this thread: https://forum.processing.org/two/discussion/17706/map-command-with-different-intervals
float expMap(float num, float exp, float lBound1, float uBound1, float lBound2, float uBound2)
{
  return map((float) Math.pow(norm(num, lBound1, uBound1), exp), 0, 1, lBound2, uBound2);
}

void bigText(String text)
{
  layer.textFont(mcTitle);
  layer.textSize(196);
  layer.textAlign(CENTER, CENTER);
  layer.fill(white);
  
  layer.pushMatrix();
  layer.translate(width / 2, height / 4, 200);

  float rotX = map(mouseY, 0, height / 4 - blockSize, radians(70), radians(5));
  float rotY = map(mouseX, 0, width, -radians(85), radians(85));
  if(rotX < -radians(100)) rotX = -radians(100);
  
  layer.rotateX(rotX);
  layer.rotateY(rotY);
  
  layer.text(text, 0, 0, 0);
  
  layer.popMatrix();
}

void layerLights()
{
  layer.pointLight(225, 225, 225, width / 2, height / 2 + height / 4, 350);
  layer.pointLight(225, 225, 225, width / 2, height / 2 - height / 4, 350);
}
