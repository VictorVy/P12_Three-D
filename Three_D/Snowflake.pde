class Snowflake extends Object
{
  float speed, driftSpeed;
  
  public Snowflake(PVector pos)
  {
    super();
    speed = random(4, 7);
    size = random(1.5, 3.5);
    alpha = random(200, 255);
    this.pos = pos; 
    colour = 225;
    driftSpeed = random(0.5, 1.5);
  }
  
  void show()
  {
    super.show();
  }
  
  void act()
  {
    if(random(-1, 4) < 0) pos.x += driftSpeed;
    if(random(-1, 4) < 0) pos.x -= driftSpeed;
    if(random(-1, 4) < 0) pos.z += driftSpeed;
    if(random(-1, 4) < 0) pos.z -= driftSpeed;
    
    if(pos.y < height - blockSize)
      pos.y += speed;
    else
      hp--;
  }
}
