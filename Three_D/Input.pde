void mouseDragged()
{
  rX += (pmouseY - mouseY) * 0.01;
  rY += (pmouseX - mouseX) * -0.01;
}

void mouseMoved()
{
  camFocusX += (mouseX - pmouseX) * 2;
  camFocusY += (mouseY - pmouseY) * 2;
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
  }
}
