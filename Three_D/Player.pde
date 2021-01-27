void handleFPCamera()
{
  world.camera(camPos.x, camPos.y, camPos.z, camFocusPos.x, camFocusPos.y, camFocusPos.z, camUp.x, camUp.y, camUp.z);

  //movement
  if (strafeF && moveFront())
  {
    camPos.x += cos(camRotLR) * moveSpeed;
    camPos.z += sin(camRotLR) * moveSpeed;
  }
  if (strafeL && moveLeft())
  {
    camPos.x -= cos(camRotLR + PI / 2) * moveSpeed;
    camPos.z -= sin(camRotLR + PI / 2) * moveSpeed;
  }
  if (strafeB && moveBack())
  {
    camPos.x -= cos(camRotLR) * moveSpeed;
    camPos.z -= sin(camRotLR) * moveSpeed;
  }
  if (strafeR && moveRight())
  {
    camPos.x += cos(camRotLR + PI / 2) * moveSpeed;
    camPos.z += sin(camRotLR + PI / 2) * moveSpeed;
  }
  if (strafeU)
    camPos.y -= moveSpeed;
  if (strafeD)
    camPos.y += moveSpeed;

  camFocusPos.x = camPos.x + cos(camRotLR) * fpFocusDist;
  camFocusPos.y = camPos.y + tan(camRotUD) * fpFocusDist;
  camFocusPos.z = camPos.z + sin(camRotLR) * fpFocusDist;
}

void handleTPCamera()
{
  world.camera(camPos.x, camPos.y, camPos.z, camFocusPos.x, camFocusPos.y, camFocusPos.z, camUp.x, camUp.y, camUp.z);

  //movement
  if (strafeF && moveFront())
  {
    camFocusPos.x += cos(camRotLR) * moveSpeed;
    camFocusPos.z += sin(camRotLR) * moveSpeed;
  }
  if (strafeL && moveLeft())
  {
    camFocusPos.x -= cos(camRotLR + PI / 2) * moveSpeed;
    camFocusPos.z -= sin(camRotLR + PI / 2) * moveSpeed;
  }
  if (strafeB && moveBack())
  {
    camFocusPos.x -= cos(camRotLR) * moveSpeed;
    camFocusPos.z -= sin(camRotLR) * moveSpeed;
  }
  if (strafeR && moveRight())
  {
    camFocusPos.x += cos(camRotLR + PI / 2) * moveSpeed;
    camFocusPos.z += sin(camRotLR + PI / 2) * moveSpeed;
  }
  if (strafeU)
    camFocusPos.y -= moveSpeed;
  if (strafeD)
    camFocusPos.y += moveSpeed;

  camPos.x = camFocusPos.x - cos(camRotLR) * tpCamDist;
  camPos.y = camFocusPos.y - tan(camRotUD) * tpCamDist; //hmmm
  camPos.z = camFocusPos.z - sin(camRotLR) * tpCamDist;
  
  if(camPos.y - camFocusPos.y > tpCamDist)
    camPos.y = camFocusPos.y + tpCamDist;
  else if(camFocusPos.y - camPos.y > tpCamDist)
    camPos.y = camFocusPos.y - tpCamDist;
    
  //hmmm
  //PVector xzDist = new PVector(camPos.x - camFocusPos.x, camPos.z - camFocusPos.z);
  //xzDist.setMag(map(xzDist.mag(), 0, ));
}

void shoot() { objects.add(new Bullet()); }

boolean moveFront()
{
  float x, z, xR, zR, xL, zL;
  int mapX, mapY, mapXR, mapYR, mapXL, mapYL;

  if (!thirdPerson)
  {
    x = camPos.x + cos(camRotLR) * collideDist;
    z = camPos.z + sin(camRotLR) * collideDist;
    xR = camPos.x + cos(camRotLR + radians(20)) * collideDist;
    zR = camPos.z + sin(camRotLR + radians(20)) * collideDist;
    xL = camPos.x + cos(camRotLR - radians(20)) * collideDist;
    zL = camPos.z + sin(camRotLR - radians(20)) * collideDist;
  } else
  {
    x = camFocusPos.x + cos(camRotLR) * collideDist;
    z = camFocusPos.z + sin(camRotLR) * collideDist;
    xR = camFocusPos.x + cos(camRotLR + radians(20)) * collideDist;
    zR = camFocusPos.z + sin(camRotLR + radians(20)) * collideDist;
    xL = camFocusPos.x - cos(camRotLR + radians(20)) * collideDist;
    zL = camFocusPos.z - sin(camRotLR + radians(20)) * collideDist;
  }

  mapX = int(x + (blockSize * blockSize) / 2) / blockSize; 
  mapY = int(z + (blockSize * blockSize) / 2) / blockSize;
  mapXR = int(xR + (blockSize * blockSize) / 2) / blockSize; 
  mapYR = int(zR + (blockSize * blockSize) / 2) / blockSize;
  mapXL = int(xL + (blockSize * blockSize) / 2) / blockSize; 
  mapYL = int(zL + (blockSize * blockSize) / 2) / blockSize;

  return wallMap.get(mapX, mapY) == #FFFFFF && wallMap.get(mapXR, mapYR) == #FFFFFF && wallMap.get(mapXL, mapYL) == #FFFFFF;
}
boolean moveLeft()
{
  float x, z;
  int mapX, mapY;

  if (!thirdPerson)
  {
    x = camPos.x + cos(camRotLR - PI / 2) * collideDist;
    z = camPos.z + sin(camRotLR - PI / 2) * collideDist;
  } else
  {
    x = camFocusPos.x + cos(camRotLR - PI / 2) * collideDist;
    z = camFocusPos.z + sin(camRotLR - PI / 2) * collideDist;
  }

  mapX = int(x + (blockSize * blockSize) / 2) / blockSize; 
  mapY = int(z + (blockSize * blockSize) / 2) / blockSize;

  return wallMap.get(mapX, mapY) == #FFFFFF;
}
boolean moveBack()
{
  float x, z;
  int mapX, mapY;

  if (!thirdPerson)
  {
    x = camPos.x - cos(camRotLR) * collideDist;
    z = camPos.z - sin(camRotLR) * collideDist;
  } else
  {
    x = camFocusPos.x - cos(camRotLR) * collideDist;
    z = camFocusPos.z - sin(camRotLR) * collideDist;
  }

  mapX = int(x + (blockSize * blockSize) / 2) / blockSize; 
  mapY = int(z + (blockSize * blockSize) / 2) / blockSize;

  return wallMap.get(mapX, mapY) == #FFFFFF;
}
boolean moveRight()
{
  float x, z;
  int mapX, mapY;

  if (!thirdPerson)
  {
    x = camPos.x + cos(camRotLR + PI * 0.5) * collideDist;
    z = camPos.z + sin(camRotLR + PI * 0.5) * collideDist;
  } else
  {
    x = camFocusPos.x + cos(camRotLR + PI * 0.5) * collideDist;
    z = camFocusPos.z + sin(camRotLR + PI * 0.5) * collideDist;
  }

  mapX = int(x + (blockSize * blockSize) / 2) / blockSize; 
  mapY = int(z + (blockSize * blockSize) / 2) / blockSize;

  return wallMap.get(mapX, mapY) == #FFFFFF;
}
