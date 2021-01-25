class SnowCloud extends Object
{
  int w, h, d, dist, snowTimer;
  
  public SnowCloud(int w, int h, int d, int dist)
  {
    super();
    this.w = w;
    this.h = h;
    this.d = d;
    this.dist = dist;
    colour = 200;
    snowTimer = 10;
  }
  
  void show()
  {
    world.pushMatrix();
    pos = thirdPerson ? camFocusPos.copy() : camPos.copy();
    pos.y -= dist;
    world.translate(pos.x, pos.y, pos.z);
    world.fill(colour);
    world.noStroke();
    world.box(w, h, d);
    world.popMatrix();
  }
  
  void act()
  {
    snowTimer++;
    if(snowTimer > 4 && random(-1, 1) > 0)
    {
      objects.add(new Snowflake(new PVector(random(pos.x - w / 2, pos.x + w / 2), pos.y, random(pos.z - d / 2, pos.z + d / 2))));
      snowTimer = 0;
    }
  }
}
