void pauseSetup()
{
  cursor();
  screenCap = get();
}

void pauseDraw()
{
  layer.beginDraw();
  layer.clear(); //because I'm using the same PGraphic
  
  layer.image(screenCap, 0, 0);
  layer.fill(0, 128);
  layer.rect(0, 0, width, height);
  
  bigText("Paused");
  
  layer.endDraw();
  
  image(layer, 0, 0);
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
