class SnowCloud extends Object
{
  int w, h, d, dist;
  boolean followingPlayer = false;;
  
  public SnowCloud(PVector pos, int w, int h, int d)
  {
    super();
    this.pos = pos;
    this.w = w;
    this.h = h;
    this.d = d;
    colour = 200;
    alpha = 196;
  }
  public SnowCloud(int w, int h, int d, int dist)
  {
    super();
    this.w = w;
    this.h = h;
    this.d = d;
    this.dist = dist;
    colour = 200;
    alpha = 196;
    followingPlayer = true;
  }
  
  void show()
  {
    world.pushMatrix();
    
    if(followingPlayer)
    {
      pos = thirdPerson ? camFocusPos.copy() : camPos.copy();
      pos.y -= dist;
    }
    
    world.translate(pos.x, pos.y, pos.z);
    world.fill(colour, alpha);
    world.noStroke();
    world.box(w, h, d);
    world.popMatrix();
  }
  
  void act()
  {
    if(random(-1, 1) < 0)
      objects.add(new Snowflake(new PVector(random(pos.x - w / 2, pos.x + w / 2), pos.y, random(pos.z - d / 2, pos.z + d / 2))));
  }
}
