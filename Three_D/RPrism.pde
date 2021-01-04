class RPrism extends Object
{
  float w, h, d;
  
  public RPrism(PVector pos, float size, color colour)
  {
    this.pos = pos;
    w = h = d = size;
    this.colour = colour;
    textured = false;
  }
  public RPrism(PVector pos, float size, PImage texture)
  {
    this.pos = pos;
    w = h = d = size;
    this.texture = texture;
    textured = true;
  }
  public RPrism(PVector pos, float w, float h, float d, color colour)
  {
    this.pos = pos;
    this.w = w;
    this.h = h;
    this.d = d;
    this.colour = colour;
    textured = false;
  }
  
  void show()
  {
    super.show();
    
    pushMatrix();
    
    translate(pos.x, pos.y, pos.z);
    rotateX(rX);
    rotateY(rY);
    
    if(textured)
    {
      noStroke();
      scale(100);
      
      beginShape(QUADS);
      texture(texture);
      
      //top
      vertex(-0.5, -0.5, -0.5, 0, 0);
      vertex(0.5, -0.5, -0.5, 1, 0);
      vertex(0.5, -0.5, 0.5, 1, 1);
      vertex(-0.5, -0.5, 0.5, 0, 1);
      
      //bottom
      vertex(-0.5, 0.5, -0.5, 0, 0);
      vertex(0.5, 0.5, -0.5, 1, 0);
      vertex(0.5, 0.5, 0.5, 1, 1);
      vertex(-0.5, 0.5, 0.5, 0, 1);
      
      //front
      vertex(-0.5, -0.5, 0.5, 0, 0);
      vertex(0.5, -0.5, 0.5, 1, 0);
      vertex(0.5, 0.5, 0.5, 1, 1);
      vertex(-0.5, 0.5, 0.5, 0, 1);
      
      //back
      vertex(-0.5, -0.5, -0.5, 0, 0);
      vertex(0.5, -0.5, -0.5, 1, 0);
      vertex(0.5, 0.5, -0.5, 1, 1);
      vertex(-0.5, 0.5, -0.5, 0, 1);
      
      //left
      vertex(-0.5, -0.5, -0.5, 0, 0);
      vertex(-0.5, -0.5, 0.5, 1, 0);
      vertex(-0.5, 0.5, 0.5, 1, 1);
      vertex(-0.5, 0.5, -0.5, 0, 1);
      
      //right
      vertex(0.5, -0.5, -0.5, 0, 0);
      vertex(0.5, -0.5, 0.5, 1, 0);
      vertex(0.5, 0.5, 0.5, 1, 1);
      vertex(0.5, 0.5, -0.5, 0, 1);
      
      endShape();
    }
    else
    {
      stroke(0);
      strokeWeight(2);
      
      box(w, h, d);
    }
    
    popMatrix();
  }
}
