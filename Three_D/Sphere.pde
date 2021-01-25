class Sphere extends Object //generic sphere
{
  float size;
  
  public Sphere(PVector pos, float size, color colour)
  {
    super();
    
    this.pos = pos;
    this.size = size;
    this.colour = colour;
  }
  
  void show()
  {
    world.fill(colour);
    
    world.stroke(0);
    world.strokeWeight(0.4);
    
    world.pushMatrix();
    
    world.translate(pos.x, pos.y, pos.z);
    world.rotateX(rX);
    world.rotateY(rY);
    
    world.sphere(size);
    
    world.popMatrix();
  }
}
