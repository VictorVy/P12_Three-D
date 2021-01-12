class FocusIndicator extends Object //focus indicator
{
  float size;
  
  public FocusIndicator(float size, color colour)
  {
    this.size = size;
    this.colour = colour;
  }
  
  void show()
  {
    super.show();
    
    noStroke();
    
    pushMatrix();
    
    pos = camFocusPos;
    translate(pos.x, pos.y, pos.z);
    
    sphere(size);
    
    popMatrix();
  }
}
