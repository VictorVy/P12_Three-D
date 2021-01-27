void introSetup()
{
  cursor();
  
  startButton = new Button(new PVector(width / 2, height / 2, 0), 300, 150, 50, dirtImg, "start");
  
  addIntroObjects();
}

void introDraw()
{
  intro.beginDraw();
  intro.background(0);
  intro.textureMode(NORMAL);
  
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
}

void introLights()
{
  
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
}
