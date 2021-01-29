class Enemy extends Object
{
  PVector dir;
  PImage img;
  
  public Enemy(PVector pos, PImage img)
  {
    super();
    
    this.pos = pos;
    this.img = img;
  }
  
  void show()
  {
    world.pushMatrix();
    world.translate(pos.x, height - pos.y - img.height, pos.z);
    
    PVector rotY = new PVector((thirdPerson ? camFocusPos.x : camPos.x) - pos.x, (thirdPerson ? camFocusPos.z : camPos.z) - pos.z);
    world.rotateY(-rotY.heading() + PI / 2);
    
    float wi = img.width / 2;
    float he = img.height / 2;
    
    world.beginShape(QUAD);
    world.texture(img);
    
    world.vertex(-wi, -he, 0, 0, 0);
    world.vertex(wi, -he, 0, 1, 0);
    world.vertex(wi, he, 0, 1, 1);
    world.vertex(-wi, he, 0, 0, 1);
    
    world.endShape();
    world.popMatrix();
  }
  
  void act()
  {
    
    
    
  }
}
