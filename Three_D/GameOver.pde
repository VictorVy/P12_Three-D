void gameOverSetup()
{
  cursor();
  deathWindowDist = 0;
  retryButton = new Button(new PVector(width / 2, height / 2 + height / 16, 0), 300, 150, 50, mossyStoneBrickImg, "retry");
  
  addGameOverObjects();
}

void gameOverDraw()
{
  layer.beginDraw();
  layer.clear(); //because I'm using the same PGraphic
  layer.background(0);
  layer.textureMode(NORMAL);
  
  layerLights();
  
  updateObjects();
  deathWindow();
  bigText("You Died");
  
  layer.endDraw();
  
  image(layer, 0, 0);
}

void addGameOverObjects()
{
  objects.clear();
  
  //buttons
  objects.add(retryButton);
  objects.add(exitButton);
}

void deathWindow()
{
  layer.pushMatrix();
  layer.translate(width / 2, height / 2, deathWindowDist);
  
  layer.beginShape(QUAD);
  layer.texture(screenCap);
  
  int wi = screenCap.width / 2;
  int he = screenCap.height / 2;
  
  layer.vertex(-wi, -he, 0, 0, 0);
  layer.vertex(wi, -he, 0, 1, 0);
  layer.vertex(wi, he, 0, 1, 1);
  layer.vertex(-wi, he, 0, 0, 1);
  
  layer.endShape();
  
  layer.popMatrix();
  
  if(deathWindowDist > -1750)
    deathWindowDist -= (100 + deathWindowDist / 15);
}

void gameOverMR()
{
  if(retryButton.mHover())
  {
    introSetup();
    mode = INTRO;
  }
  else if(exitButton.mHover())
    exit();
}
