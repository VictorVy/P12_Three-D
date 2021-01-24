class Block extends Object //specialised minecraft-like block
{
  int size;
  PImage topImg, botImg, frontImg, backImg, leftImg, rightImg;
  
  public Block(PVector pos, int size, PImage texture) //same texture on all faces
  {
    super();
    
    this.pos = pos;
    this.size = size;
    this.topImg = this.botImg = this.frontImg = this.backImg = this.leftImg = this.rightImg = texture;
    textured = true;
  }
  public Block(PVector pos, int size, PImage topImg, PImage botImg, PImage frontImg, PImage backImg, PImage leftImg, PImage rightImg) //different textures on faces
  {
    super();
    
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
    world.pushMatrix();
    world.translate(-(blockSize * blockSize) / 2 + pos.x, height + pos.y, -(blockSize * blockSize) / 2 + pos.z);
    
    world.noStroke();
    world.scale(size);
    
    //top
    world.beginShape(QUADS);
    world.texture(topImg);
    world.vertex(0, 0, 0, 0, 0);
    world.vertex(1, 0, 0, 1, 0);
    world.vertex(1, 0, 1, 1, 1);
    world.vertex(0, 0, 1, 0, 1);
    world.endShape();
    
    //bottom
    world.beginShape(QUADS);
    world.texture(botImg);
    world.vertex(0, 1, 0, 0, 0);
    world.vertex(1, 1, 0, 1, 0);
    world.vertex(1, 1, 1, 1, 1);
    world.vertex(0, 1, 1, 0, 1);
    world.endShape();
    
    //front
    world.beginShape(QUADS);
    world.texture(frontImg);
    world.vertex(0, 0, 1, 0, 0);
    world.vertex(1, 0, 1, 1, 0);
    world.vertex(1, 1, 1, 1, 1);
    world.vertex(0, 1, 1, 0, 1);
    world.endShape();
    
    //back
    world.beginShape(QUADS);
    world.texture(backImg);
    world.vertex(0, 0, 0, 0, 0);
    world.vertex(1, 0, 0, 1, 0);
    world.vertex(1, 1, 0, 1, 1);
    world.vertex(0, 1, 0, 0, 1);
    world.endShape();
    
    //left
    world.beginShape(QUADS);
    world.texture(leftImg);
    world.vertex(0, 0, 0, 0, 0);
    world.vertex(0, 0, 1, 1, 0);
    world.vertex(0, 1, 1, 1, 1);
    world.vertex(0, 1, 0, 0, 1);
    world.endShape();
    
    //right
    world.beginShape(QUADS);
    world.texture(rightImg);
    world.vertex(1, 0, 0, 0, 0);
    world.vertex(1, 0, 1, 1, 0);
    world.vertex(1, 1, 1, 1, 1);
    world.vertex(1, 1, 0, 0, 1);
    world.endShape();
    
    world.popMatrix();
  }
}
