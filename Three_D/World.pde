void worldDraw()
{
  world.beginDraw();

  world.background(0);
  world.textureMode(NORMAL);

  drawGuide();
  lightScene();

  if(!thirdPerson)
    handleFPCamera();
  else
    handleTPCamera();

  shootTimer++;

  wrapMouse();
  updateGameObjects();
  
  world.endDraw();
}

void addWorld() //using img to map out floor
{
  for (int r = 0; r < floorMap.height; r++)
  {
    for (int c = 0; c < floorMap.width; c++)
    {
      PImage image;
      color colour;

      //floor
      colour = floorMap.get(c, r); 

      if(colour != white)
      {
        if (colour == #000000) image = dirtImg;
        else if (colour == #00FF00) image = grassTopImg;
        else if (colour == #9b9b9b) image = mossyStoneBrickImg;
        else if (colour == #bf8240) image = oakPlankImg;
        else image = dirtImg;
  
        objects.add(new FloorBlock(new PVector(c * blockSize, blockSize, r * blockSize), blockSize, image));
      }
      
      //walls
      colour = wallMap.get(c, r); 

      if(colour != white)
      {
        if (colour == #000000) image = dirtImg;
        else if (colour == #00FF00) image = grassTopImg;
        else if (colour == #9b9b9b) image = mossyStoneBrickImg;
        else if (colour == #bf8240) image = oakPlankImg;
        else image = dirtImg;
  
        objects.add(new Block(new PVector(c * blockSize, blockSize * 2, r * blockSize), blockSize, image));
        objects.add(new Block(new PVector(c * blockSize, blockSize * 3, r * blockSize), blockSize, image));
        objects.add(new Block(new PVector(c * blockSize, blockSize * 4, r * blockSize), blockSize, image));
      }

      //ceiling
      colour = ceilingMap.get(c, r); 

      if(colour != white)
      {
        if (colour == #000000) image = dirtImg;
        else if (colour == #00FF00) image = grassTopImg;
        else if (colour == #9b9b9b) image = mossyStoneBrickImg;
        else if (colour == #bf8240) image = oakPlankImg;
        else image = dirtImg;
  
        objects.add(new Block(new PVector(c * blockSize, height * 2, r * blockSize), blockSize, image));
      }
    }
  }
}

void drawGuide()
{ 
  world.pushMatrix();
  world.translate(-(blockSize * blockSize) / 2, height, -(blockSize * blockSize) / 2);

  //axis lines
  world.strokeWeight(5);
  world.stroke(255, 0, 0);
  world.line(0, 0, 0, blockSize * blockSize, 0, 0);
  world.stroke(0, 255, 0);
  world.line(0, 0, 0, 0, -(blockSize * blockSize) / 2, 0);
  world.stroke(0, 0, 255);
  world.line(0, 0, 0, 0, 0, blockSize * blockSize);

  //guide lines
  world.strokeWeight(0.5);
  world.stroke(255);

  for (int i = 0; i <= blockSize; i++)
  {
    //floor
    world.line(0, 0, i * blockSize, blockSize * blockSize, 0, i * blockSize);
    world.line(i * blockSize, 0, 0, i * blockSize, 0, blockSize * blockSize);
    //ceiling
    world.line(0, -(blockSize * blockSize) / 2, i * blockSize, blockSize * blockSize, -(blockSize * blockSize) / 2, i * blockSize);
    world.line(i * blockSize, -(blockSize * blockSize) / 2, 0, i * blockSize, -(blockSize * blockSize) / 2, blockSize * blockSize);
  }

  world.popMatrix();
}

void lightScene()
{
  world.ambientLight(64, 64, 64); //don't work on textures, for some odd reason

  world.directionalLight(128, 128, 128, 0, -1, 0);
  world.directionalLight(128, 128, 128, 0, 1, 0);
  world.directionalLight(128, 128, 128, 1, 0, 0);
  world.directionalLight(128, 128, 128, -1, 0, 0);
  world.directionalLight(128, 128, 128, 0, 0, 1);
  world.directionalLight(128, 128, 128, 0, 0, -1);

  //world.spotLight(255, 255, 255, width / 2, height / 2, 400, 0, 0, -1, 0, 0);

  if (!thirdPerson)
    world.pointLight(255, 255, 255, camPos.x, camPos.y, camPos.z);
  else
    world.pointLight(255, 255, 255, camFocusPos.x, camFocusPos.y, camFocusPos.z);
}
