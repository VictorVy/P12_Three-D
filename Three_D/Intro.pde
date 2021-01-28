void introSetup()
{
  cursor();
    
  startButton = new Button(new PVector(width / 2, height / 2 + height / 16, 0), 300, 150, 50, dirtImg, "start");
  exitButton = new Button(new PVector(width / 2, height / 2 + height / 4, 0), 250, 125, 44, dirtImg, "exit");
  
  addIntroObjects();
}

void introDraw()
{
  intro.beginDraw();
  intro.background(0);
  intro.textureMode(NORMAL);
  
  title();
  
  introLights();
  updateIntroObjects();
  
  intro.endDraw();
  
  image(intro, 0, 0);
}

void addIntroObjects()
{
  objects.clear();
  
  //buttons
  objects.add(startButton);
  objects.add(exitButton);
}

void title()
{
  intro.textFont(mcTitle);
  intro.textSize(196);
  intro.textAlign(CENTER, CENTER);
  intro.fill(white);
  
  intro.pushMatrix();
  intro.translate(width / 2, height / 4);

  float rotX = map(mouseY, 0, height / 4, radians(70), radians(5));
  float rotY = map(mouseX, 0, width, -radians(85), radians(85));
  if(rotX < -radians(100)) rotX = -radians(100);
  
  intro.rotateX(rotX);
  intro.rotateY(rotY);
  
  intro.text("Three-Dee", 0, 0);
  
  intro.popMatrix();
}

void introLights()
{
  intro.pointLight(225, 225, 225, width / 2, height / 2 + height / 4, 200);
  intro.pointLight(225, 225, 225, width / 2, height / 2 - height / 4, 200);
}

void updateIntroObjects()
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

void introMR()
{
  if(startButton.mHover())
  {
    gameSetup();
    mode = GAME;
  }
  else if(exitButton.mHover())
    exit();
}
