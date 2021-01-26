class Button extends RPrism
{
  String text;
  float rotX, rotY, rotSpeed;
  
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
    rotSpeed = radians(3);
  }
  
  void show()
  {    
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
    
    intro.popMatrix();
  }
  
  void act()
  {
    rotX += rotSpeed;
    rotY += rotSpeed;
  }
}
