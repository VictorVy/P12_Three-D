class Sphere extends Object //generic sphere
{
  float size;
  
  public Sphere(PVector pos, float size, color colour)
  {
    this.pos = pos;
    this.size = size;
    this.colour = colour;
  }
  
  void show()
  {
    super.show();
    
    stroke(0);
    strokeWeight(0.4);
    
    pushMatrix();
    
    translate(pos.x, pos.y, pos.z);
    rotateX(rX);
    rotateY(rY);
    
    sphere(size);
    
    popMatrix();
  }
}
