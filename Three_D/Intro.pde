void introSetup()
{
  cursor();
    
  startButton = new Button(new PVector(width / 2, height / 2 + height / 16, 0), 300, 150, 50, dirtImg, "start");
  exitButton = new Button(new PVector(width / 2, height / 2 + height / 4, 0), 250, 125, 44, grassTopImg, "exit");
  
  addIntroObjects();
}

void introDraw()
{
  layer.beginDraw();
  layer.clear(); //because I'm using the same PGraphic
  layer.background(0);
  layer.textureMode(NORMAL);
  
  bigText("Three-D");
  
  layerLights();
  updateObjects();
  
  layer.endDraw();
  
  image(layer, 0, 0);
}

void addIntroObjects()
{
  objects.clear();
  
  //buttons
  objects.add(startButton);
  objects.add(exitButton);
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
