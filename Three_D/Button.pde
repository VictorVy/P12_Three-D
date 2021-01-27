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
    intro.pushMatrix();
    
    intro.translate(pos.x, pos.y, pos.z);
    intro.rotateX(rotX);
    intro.rotateY(rotY);
    
    intro.noStroke();
    
    float wi = w / 2, he = h / 2, de = d / 2;
    
    //top    
    intro.beginShape(QUADS);
    intro.texture(topImg);
    intro.vertex(-wi, -he, -de, 0, 0);
    intro.vertex(wi, -he, -de, 1, 0);
    intro.vertex(wi, -he, de, 1, 1);
    intro.vertex(-wi, -he, de, 0, 1);
    intro.endShape();
    
    //bottom
    intro.beginShape(QUADS);
    intro.texture(botImg);
    intro.vertex(-wi, he, -de, 0, 0);
    intro.vertex(wi, he, -de, 1, 0);
    intro.vertex(wi, he, de, 1, 1);
    intro.vertex(-wi, he, de, 0, 1);
    intro.endShape();
    
    //front
    intro.beginShape(QUADS);
    intro.texture(frontImg);
    intro.vertex(-wi, -he, de, 0, 0);
    intro.vertex(wi, -he, de, 1, 0);
    intro.vertex(wi, he, de, 1, 1);
    intro.vertex(-wi, he, de, 0, 1);
    intro.endShape();
    
    //back
    intro.beginShape(QUADS);
    intro.texture(backImg);
    intro.vertex(-wi, -he, -de, 0, 0);
    intro.vertex(wi, -he, -de, 1, 0);
    intro.vertex(wi, he, -de, 1, 1);
    intro.vertex(-wi, he, -de, 0, 1);
    intro.endShape();
    
    //left
    intro.beginShape(QUADS);
    intro.texture(leftImg);
    intro.vertex(-wi, -he, -de, 0, 0);
    intro.vertex(-wi, -he, de, 1, 0);
    intro.vertex(-wi, he, de, 1, 1);
    intro.vertex(-wi, he, -de, 0, 1);
    intro.endShape();
    
    //right
    intro.beginShape(QUADS);
    intro.texture(rightImg);
    intro.vertex(wi, -he, -de, 0, 0);
    intro.vertex(wi, -he, de, 1, 0);
    intro.vertex(wi, he, de, 1, 1);
    intro.vertex(wi, he, -de, 0, 1);
    intro.endShape();
    
    intro.fill(mHover() ? black : white);
    intro.textAlign(CENTER);
    intro.textSize(h / 1.5);
    intro.text(text, 0, he / 2.5, de + 1);
    
    intro.popMatrix();
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
