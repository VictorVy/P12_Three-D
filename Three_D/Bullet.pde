class Bullet extends Object
{
  int size;
  PVector dir;
  float speed;
  
  public Bullet()
  {
    super();
    
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
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    fill(white);
    noStroke();
    box(size);
    popMatrix();
  }
  
  void act()
  {
    int mapX = int(pos.x + (blockSize * blockSize) / 2) / blockSize;
    int mapY = int(pos.z + (blockSize * blockSize) / 2) / blockSize;
    
    if(wallMap.get(mapX, mapY) == white && pos.y < height)
      pos.add(dir);
    else
    {
      hp--;
      //for(int i = 0; i < 8; i++)
      //  objects.add(new Particle(pos));
    }
  }
}
