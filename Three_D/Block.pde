class Block extends Object //specialised minecraft-like block
{
  int size;
  PImage topImg, botImg, frontImg, backImg, leftImg, rightImg;
  
  public Block(PVector pos, int size, PImage texture) //same texture on all faces
  {
    this.pos = pos;
    this.size = size;
    this.topImg = this.botImg = this.frontImg = this.backImg = this.leftImg = this.rightImg = texture;
    textured = true;
  }
  public Block(PVector pos, int size, PImage topImg, PImage botImg, PImage frontImg, PImage backImg, PImage leftImg, PImage rightImg) //different textures on faces
  {
    this.pos = pos;
    this.size = size;
    this.topImg = topImg;
    this.botImg = botImg;
    this.frontImg = frontImg;
    this.backImg = backImg;
    this.leftImg = leftImg;
    this.rightImg = rightImg;
    textured = true;
  }
  
  void show()
  {
    pushMatrix();
    translate(-(worldSize * worldSize) / 2 + pos.x, height + pos.y, -(worldSize * worldSize) / 2 + pos.z);
    
    noStroke();
    scale(size);
    
    //top
    beginShape(QUADS);
    texture(topImg);
    vertex(0, 0, 0, 0, 0);
    vertex(1, 0, 0, 1, 0);
    vertex(1, 0, 1, 1, 1);
    vertex(0, 0, 1, 0, 1);
    endShape();
    
    //bottom
    beginShape(QUADS);
    texture(botImg);
    vertex(0, 1, 0, 0, 0);
    vertex(1, 1, 0, 1, 0);
    vertex(1, 1, 1, 1, 1);
    vertex(0, 1, 1, 0, 1);
    endShape();
    
    //front
    beginShape(QUADS);
    texture(frontImg);
    vertex(0, 0, 1, 0, 0);
    vertex(1, 0, 1, 1, 0);
    vertex(1, 1, 1, 1, 1);
    vertex(0, 1, 1, 0, 1);
    endShape();
    
    //back
    beginShape(QUADS);
    texture(backImg);
    vertex(0, 0, 0, 0, 0);
    vertex(1, 0, 0, 1, 0);
    vertex(1, 1, 0, 1, 1);
    vertex(0, 1, 0, 0, 1);
    endShape();
    
    //left
    beginShape(QUADS);
    texture(leftImg);
    vertex(0, 0, 0, 0, 0);
    vertex(0, 0, 1, 1, 0);
    vertex(0, 1, 1, 1, 1);
    vertex(0, 1, 0, 0, 1);
    endShape();
    
    //right
    beginShape(QUADS);
    texture(rightImg);
    vertex(1, 0, 0, 0, 0);
    vertex(1, 0, 1, 1, 0);
    vertex(1, 1, 1, 1, 1);
    vertex(1, 1, 0, 0, 1);
    endShape();
    
    popMatrix();
  }
}
