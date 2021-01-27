void gameSetup()
{
  noCursor();
  
  camRotLR = radians(-90);
  camPos = new PVector(width / 2, height - blockSize * 3, 1000);
  camFocusPos = new PVector(camPos.x, camPos.y, camPos.z);
  camUp = new PVector(0, 1, 0);
  moveSpeed = 20;
  
  addGameObjects();
}

void gameDraw()
{
  worldDraw();
  hudDraw();
  
  image(world, 0, 0);
  image(hud, 0, 0);
}

void addGameObjects()
{
  objects.clear();
  
  //traffic light (rotatable)
  objects.add(new RPrism(new PVector(width / 2, height / 2.5, -200), width / 3, height, 100, dirtImg));

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

  //third-person character
  objects.add(new FocusIndicator(blockSize / 2));
  
  //snow clouds
  objects.add(new SnowCloud(400, 25, 400, 250));
  objects.add(new SnowCloud(new PVector(width / 2, -blockSize, 0), width, 25, 400));

  addWorld();
}

void updateGameObjects()
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

void gameMR()
{
  switch(mouseButton)
  {
    case LEFT:
      if(shootTimer > 20)
      {
        shoot();
        shootTimer = 0;
      }
      break;
  }
}

void gameMD()
{
  rX += (pmouseY - mouseY) * 0.01;
  rY += (pmouseX - mouseX) * -0.01;
}

void gameMM()
{
  if(Math.abs(mouseX - pmouseX) < width - 10)
    camRotLR += (mouseX - pmouseX) * (thirdPerson ? 0.005 : 0.004);
  if(Math.abs(mouseY - pmouseY) < height - 10)
    camRotUD += (mouseY - pmouseY) * (thirdPerson ? 0.005 : 0.004);
  
  if(camRotUD > radians(89)) camRotUD = radians(89);
    else if(camRotUD < -radians(89)) camRotUD = -radians(89);
}

void gameMW(MouseEvent event)
{
  int e = event.getCount();
  
  if(thirdPerson && !(e < 0 && tpCamDist < blockSize * 2))
    tpCamDist += camZoomSpeed * e;
}

void gameKP()
{
  switch(key)
  {
    case 'w':
      strafeF = true;
      break;
    case 'a':
      strafeL = true;
      break;
    case 's':
      strafeB = true;
      break;
    case 'd':
      strafeR = true;
      break;
    case ' ':
      strafeU = true;
      break;
  }
  
  switch(keyCode)
  {
    case SHIFT:
      strafeD = true;
      break;
  }
}

void gameKR()
{
  switch(key)
  {
    case 'w':
      strafeF = false;
      break;
    case 'a':
      strafeL = false;
      break;
    case 's':
      strafeB = false;
      break;
    case 'd':
      strafeR = false;
      break;
    case ' ':
      strafeU = false;
      break;
  }
  
  switch(keyCode)
  {
    case SHIFT:
      strafeD = false;
      break;
    case TAB:
      thirdPerson = !thirdPerson;
      //swap camera/focus
      PVector tmp = camFocusPos;
      camFocusPos = camPos;
      camPos = tmp;
      break;
  }
}
