class Button extends RPrism
{
  String text;
  float rotX, rotY, rotXSpeed, rotYSpeed, rotAccel;
  
  public Button(PVector pos, float w, float h, float d, PImage texture, String text) //textured rectangular prism (same texture on all faces)
  {
    super();
    
    this.pos = pos;
    this.w = w;
    this.h = h;
    this.d = d;
    this.topImg = this.botImg = this.frontImg = this.backImg = this.leftImg = this.rightImg = texture;
    this.text = text;
    textured = true;
    rotX = rotY = 0;
    rotXSpeed = random(-1, 1) < 0 ? -radians(0.5) : radians(0.5);
    rotYSpeed = random(-1, 1) < 0 ? -radians(0.5) : radians(0.5);
    rotAccel = radians(0.01);
  }
  
  void show()
  {
    //unfortunately can't use super.show() because different PGraphics :^(
    layer.pushMatrix();
    
    layer.translate(pos.x, pos.y, pos.z);
    layer.rotateX(rotX);
    layer.rotateY(rotY);
    
    layer.noStroke();
    
    float wi = w / 2, he = h / 2, de = d / 2;
    
    //top    
    layer.beginShape(QUADS);
    layer.texture(topImg);
    layer.vertex(-wi, -he, -de, 0, 0);
    layer.vertex(wi, -he, -de, 1, 0);
    layer.vertex(wi, -he, de, 1, 1);
    layer.vertex(-wi, -he, de, 0, 1);
    layer.endShape();
    
    //bottom
    layer.beginShape(QUADS);
    layer.texture(botImg);
    layer.vertex(-wi, he, -de, 0, 0);
    layer.vertex(wi, he, -de, 1, 0);
    layer.vertex(wi, he, de, 1, 1);
    layer.vertex(-wi, he, de, 0, 1);
    layer.endShape();
    
    //front
    layer.beginShape(QUADS);
    layer.texture(frontImg);
    layer.vertex(-wi, -he, de, 0, 0);
    layer.vertex(wi, -he, de, 1, 0);
    layer.vertex(wi, he, de, 1, 1);
    layer.vertex(-wi, he, de, 0, 1);
    layer.endShape();
    
    //back
    layer.beginShape(QUADS);
    layer.texture(backImg);
    layer.vertex(-wi, -he, -de, 0, 0);
    layer.vertex(wi, -he, -de, 1, 0);
    layer.vertex(wi, he, -de, 1, 1);
    layer.vertex(-wi, he, -de, 0, 1);
    layer.endShape();
    
    //left
    layer.beginShape(QUADS);
    layer.texture(leftImg);
    layer.vertex(-wi, -he, -de, 0, 0);
    layer.vertex(-wi, -he, de, 1, 0);
    layer.vertex(-wi, he, de, 1, 1);
    layer.vertex(-wi, he, -de, 0, 1);
    layer.endShape();
    
    //right
    layer.beginShape(QUADS);
    layer.texture(rightImg);
    layer.vertex(wi, -he, -de, 0, 0);
    layer.vertex(wi, -he, de, 1, 0);
    layer.vertex(wi, he, de, 1, 1);
    layer.vertex(wi, he, -de, 0, 1);
    layer.endShape();
    
    layer.fill(mHover() ? black : white);
    layer.textAlign(CENTER);
    layer.textFont(mcRegular);
    layer.textSize(h);
    layer.text(text, 0, he / 2.5, de + 1);
    
    layer.popMatrix();
  }
  
  void act()
  {
    if(!mHover())
    {
      if(rotX >= radians(5))
        rotXSpeed -= rotAccel;
      else if(rotX <= -radians(5))
        rotXSpeed += rotAccel;
      if(rotY >= radians(15))
        rotYSpeed -= rotAccel;
      else if(rotY <= -radians(15))
        rotYSpeed += rotAccel;  
    
      rotX += rotXSpeed;
      rotY += rotYSpeed;
    }
  }
  
  boolean mHover() { return mouseX >= pos.x - w / 2 && mouseX <= pos.x + w / 2 && mouseY >= pos.y - h / 2 && mouseY <= pos.y + h / 2; }
}
