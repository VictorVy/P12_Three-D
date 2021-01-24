class Object
{
  PVector pos;
  color colour;
  boolean textured;
  int hp;
  
  public Object()
  {
    hp = 1;
  }
  
  void show()
  {
    world.fill(colour);
  }
  
  void act()
  {
    
  }
}
