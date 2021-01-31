abstract class Bullet extends Object
{
  PVector dir;
  float speed, gravity, gravitySpeed;
  
  public Bullet()
  {
    super();
    
    colour = white;
    size = 10;
    speed = 50;
    gravity = 1;
    gravitySpeed = 0.75;
  }
  
  void show()
  {
    super.show();
  }
  
  void act()
  {
    int mapX = int(pos.x + (blockSize * blockSize) / 2) / blockSize;
    int mapY = int(pos.z + (blockSize * blockSize) / 2) / blockSize;
    
    if(wallMap.get(mapX, mapY) == white && pos.y < height - blockSize)
    {
      pos.add(dir);
      pos.y += gravity;
      gravity += gravitySpeed;
    }
    else
    {
      hp--;
      for(int i = 0; i < 18; i++)
        objects.add(new Particle(pos.copy()));
    }
  }
}
