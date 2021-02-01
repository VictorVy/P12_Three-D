void mouseReleased()
{
  if(mode == GAME)
    gameMR();
  else if(mode == INTRO)
    introMR();
  else if(mode == GAMEOVER)
    gameOverMR();
}

void mouseDragged() //rotate objects
{
  if(mode == GAME)
    gameMD();
}

void mouseMoved()
{
  if(mode == GAME)
    gameMM();
}

void mouseWheel(MouseEvent event)
{
  if(mode == GAME)
    gameMW(event);
}

void keyPressed()
{
  if(mode == GAME)
    gameKP();
}

void keyReleased()
{
  if(mode == GAME)
    gameKR();
  else if(mode == PAUSE)
    pauseKR();
}

void wrapMouse()
{
  if (mouseX > width - 2) mouseBot.mouseMove(2, mouseY);
  else if (mouseX < 2) mouseBot.mouseMove(width - 2, mouseY);

  if (mouseY > height - 2) mouseBot.mouseMove(mouseX, 2);
  else if (mouseY < 2) mouseBot.mouseMove(mouseX, height - 2);
}
