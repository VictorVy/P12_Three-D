class Object
{
  PVector pos;
  color colour;
  boolean textured;
  int hp;
  float size = 0, alpha = 255;
  
  public Object()
  {
    pos = new PVector(0, 0, 0);
    hp = 1;
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
    
  }
}
