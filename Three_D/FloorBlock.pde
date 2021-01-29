class FloorBlock extends Block
{
  public FloorBlock(PVector pos, int size, PImage texture)
  {
    super(pos, size, texture);
  }
  
  void show()
  {
    world.pushMatrix();
    world.translate(-(blockSize * blockSize) / 2 + pos.x, height - pos.y, -(blockSize * blockSize) / 2 + pos.z);
    
    world.scale(size);
    
    world.beginShape(QUAD);
    world.texture(topImg);
    
    world.vertex(0, 0, 0, 0, 0);
    world.vertex(1, 0, 0, 1, 0);
    world.vertex(1, 0, 1, 1, 1);
    world.vertex(0, 0, 1, 0, 1);
    
    world.endShape();
    world.popMatrix();
  }
}
