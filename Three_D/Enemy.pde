class Enemy extends Object
{
  PVector dir;
  PImage img;
  int shootTimer, range;
  
  public Enemy(PVector pos, PImage img)
  {
    super();
    
    this.pos = pos;
    this.img = img;
    shootTimer = 0;
    range = blockSize * 40;
  }
  
  void show()
  {
    world.pushMatrix();
    world.translate(pos.x, height - pos.y - img.height, pos.z);
    
    PVector rotY = new PVector((thirdPerson ? camFocusPos.x : camPos.x) - pos.x, (thirdPerson ? camFocusPos.z : camPos.z) - pos.z);
    world.rotateY(-rotY.heading() + PI / 2);
    
    float wi = img.width / 2;
    float he = img.height / 2;
    
    world.beginShape(QUAD);
    world.texture(img);
    
    world.vertex(-wi, -he, 0, 0, 0);
    world.vertex(wi, -he, 0, 1, 0);
    world.vertex(wi, he, 0, 1, 1);
    world.vertex(-wi, he, 0, 0, 1);
    
    world.endShape();
    world.popMatrix();
  }
  
  void act()
  {
    shootTimer++;
    if(shootTimer > 60 && dist(pos.x, pos.z, camPos.x, camPos.z) <= range && Math.abs((pos.y + img.height * 1.25) - (thirdPerson ? camFocusPos.y : camPos.y)) <= range / 4)
    {
      shoot();
      shootTimer = 0;
    } 
  }
  
  void shoot()
  {
    objects.add(new EnemyBullet(new PVector(pos.x, pos.y + img.height * 1.25, pos.z), expMap(dist(pos.x, pos.z, thirdPerson? camFocusPos.x : camPos.x, thirdPerson ? camFocusPos.z : camPos.z), 2, 0, range, 0, range / 1.5))); //unhealthy addiction to the ternary operator
  }
}
