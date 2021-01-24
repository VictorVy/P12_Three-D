class Bullet extends Object
{
  int size;
  PVector dir;
  float speed;
  
  public Bullet()
  {
    super();
    
    colour = white;
    size = 10;
    
    if(!thirdPerson)
    {
      pos = new PVector(camPos.x, camPos.y, camPos.z);
      dir = new PVector(cos(camRotLR), tan(camRotUD), sin(camRotLR));
    }
    else
    {
      pos = new PVector(camFocusPos.x, camFocusPos.y, camFocusPos.z);
      dir = new PVector(cos(camRotLR), 0, sin(camRotLR));
    }
    
    dir.setMag(speed = 50);
  }
  
  void show()
  {
    world.pushMatrix();
    world.translate(pos.x, pos.y, pos.z);
    world.fill(colour);
    world.noStroke();
    world.box(size);
    world.popMatrix();
  }
  
  void act()
  {
    int mapX = int(pos.x + (blockSize * blockSize) / 2) / blockSize;
    int mapY = int(pos.z + (blockSize * blockSize) / 2) / blockSize;
    
    if(wallMap.get(mapX, mapY) == white && pos.y < height - blockSize)
      pos.add(dir);
    else
    {
      hp--;
      for(int i = 0; i < 16; i++)
        objects.add(new Particle(pos));
    }
  }
}
