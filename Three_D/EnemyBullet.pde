class EnemyBullet extends Bullet
{
  public EnemyBullet(PVector pos, float aimAdjust)
  {
    super();
    
    this.pos = pos;
    
    dir = new PVector((thirdPerson ? camFocusPos.x : camPos.x) - pos.x, (thirdPerson ? camFocusPos.y : camPos.y) - pos.y - aimAdjust, (thirdPerson ? camFocusPos.z : camPos.z) - pos.z); //unhealthy addiction to the ternary operator
    
    dir.setMag(speed);
  }
}
