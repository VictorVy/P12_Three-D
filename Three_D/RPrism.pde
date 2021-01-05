class RPrism extends Object
{
  float w, h, d;
  PImage topImg, botImg, frontImg, backImg, leftImg, rightImg;
  
  public RPrism(PVector pos, float size, color colour) //untextured cube
  {
    this.pos = pos;
    w = h = d = size;
    this.colour = colour;
    textured = false;
  }
  public RPrism(PVector pos, float size, PImage texture) //textured cube (same textures on all faces)
  {
    this.pos = pos;
    w = h = d = size;
    this.topImg = this.botImg = this.frontImg = this.backImg = this.leftImg = this.rightImg = texture;
    textured = true;
  }
  public RPrism(PVector pos, float size, PImage topImg, PImage botImg, PImage frontImg, PImage backImg, PImage leftImg, PImage rightImg) //textured cube (different textures on faces)
  {
    this.pos = pos;
    w = h = d = size;
    this.topImg = topImg;
    this.botImg = botImg;
    this.frontImg = frontImg;
    this.backImg = backImg;
    this.leftImg = leftImg;
    this.rightImg = rightImg;
    textured = true;
  }
  public RPrism(PVector pos, float w, float h, float d, color colour) //untextured rectangular prism
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
      
      //top
      beginShape(QUADS);
      texture(topImg);
      vertex(-0.5, -0.5, -0.5, 0, 0);
      vertex(0.5, -0.5, -0.5, 1, 0);
      vertex(0.5, -0.5, 0.5, 1, 1);
      vertex(-0.5, -0.5, 0.5, 0, 1);
      endShape();
      
      //bottom
      beginShape(QUADS);
      texture(botImg);
      vertex(-0.5, 0.5, -0.5, 0, 0);
      vertex(0.5, 0.5, -0.5, 1, 0);
      vertex(0.5, 0.5, 0.5, 1, 1);
      vertex(-0.5, 0.5, 0.5, 0, 1);
      endShape();
      
      //front
      beginShape(QUADS);
      texture(frontImg);
      vertex(-0.5, -0.5, 0.5, 0, 0);
      vertex(0.5, -0.5, 0.5, 1, 0);
      vertex(0.5, 0.5, 0.5, 1, 1);
      vertex(-0.5, 0.5, 0.5, 0, 1);
      endShape();
      
      //back
      beginShape(QUADS);
      texture(backImg);
      vertex(-0.5, -0.5, -0.5, 0, 0);
      vertex(0.5, -0.5, -0.5, 1, 0);
      vertex(0.5, 0.5, -0.5, 1, 1);
      vertex(-0.5, 0.5, -0.5, 0, 1);
      endShape();
      
      //left
      beginShape(QUADS);
      texture(leftImg);
      vertex(-0.5, -0.5, -0.5, 0, 0);
      vertex(-0.5, -0.5, 0.5, 1, 0);
      vertex(-0.5, 0.5, 0.5, 1, 1);
      vertex(-0.5, 0.5, -0.5, 0, 1);
      endShape();
      
      //right
      beginShape(QUADS);
      texture(rightImg);
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
