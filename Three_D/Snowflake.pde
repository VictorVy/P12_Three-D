class Snowflake extends Object
{
  float speed, size, alpha;
  
  public Snowflake(PVector pos)
  {
    super();
    speed = random(3, 6);
    size = random(2, 4);
    alpha = random(200, 255);
    this.pos = pos; 
    colour = 225;
  }
  
  void show()
  {
    world.pushMatrix();
    world.translate(pos.x, pos.y, pos.z);
    world.fill(colour, alpha);
    world.noStroke();
    world.box(size);
    world.popMatrix();
  }
  
  void act()
  {
    if(pos.y < height - blockSize)
      pos.y += speed;
    else
      hp--;
  }
}
