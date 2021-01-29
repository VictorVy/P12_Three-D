void pauseSetup()
{
  screenCap = get();
  cursor();
}

void pauseDraw()
{
  pause.beginDraw();
  
  pause.image(screenCap, 0, 0);
  pause.fill(0, 128);
  pause.rect(0, 0, width, height);
  
  pauseText();
  
  pause.endDraw();
  
  image(pause, 0, 0);
}

void pauseText() //can't reuse intro method because different PGraphics :^(
{
  pause.textFont(mcTitle);
  pause.textSize(196);
  pause.textAlign(CENTER, CENTER);
  pause.fill(white);
  
  pause.pushMatrix();
  pause.translate(width / 2, height / 4, 200);

  float rotX = map(mouseY, 0, height / 4, radians(70), radians(5));
  float rotY = map(mouseX, 0, width, -radians(85), radians(85));
  if(rotX < -radians(100)) rotX = -radians(100);
  
  pause.rotateX(rotX);
  pause.rotateY(rotY);
  
  pause.text("Paused", 0, 0, 0);
  
  pause.popMatrix();
}

void pauseKR()
{
  switch(key)
  {
    case 'p':
      noCursor();
      mode = GAME;
      break;
  }
}
