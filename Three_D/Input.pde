void mouseReleased()
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

void mouseDragged() //rotate objects
{
  rX += (pmouseY - mouseY) * 0.01;
  rY += (pmouseX - mouseX) * -0.01;
}

void mouseMoved()
{
  if(Math.abs(mouseX - pmouseX) < width - 10)
    camRotLR += (mouseX - pmouseX) * (thirdPerson ? 0.005 : 0.004);
  if(Math.abs(mouseY - pmouseY) < height - 10)
    camRotUD += (mouseY - pmouseY) * (thirdPerson ? 0.005 : 0.004);
  
  if(camRotUD > radians(89)) camRotUD = radians(89);
    else if(camRotUD < -radians(89)) camRotUD = -radians(89);
}

void mouseWheel(MouseEvent event)
{
  int e = event.getCount();
  
  if(thirdPerson)
    tpCamDist += camZoomSpeed * e;
}

void keyPressed()
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

void keyReleased()
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

void wrapMouse()
{
  if (mouseX > width - 2) mouseBot.mouseMove(2, mouseY);
  else if (mouseX < 2) mouseBot.mouseMove(width - 2, mouseY);

  if (mouseY > height - 2) mouseBot.mouseMove(mouseX, 2);
  else if (mouseY < 2) mouseBot.mouseMove(mouseX, height - 2);
}
