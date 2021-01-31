class PlayerBullet extends Bullet
{
  public PlayerBullet()
  {
    super();
    
    if(!thirdPerson)
    {
      pos = new PVector(camPos.x, camPos.y, camPos.z);
      dir = new PVector(cos(camRotLR), tan(camRotUD) - 0.05, sin(camRotLR));
    }
    else
    {
      pos = new PVector(camFocusPos.x, camFocusPos.y, camFocusPos.z);
      dir = new PVector(cos(camRotLR), -0.25, sin(camRotLR));
    }
    
    dir.setMag(speed);
  }
}
