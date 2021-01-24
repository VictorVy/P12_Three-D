class Particle extends Object
{
  PVector dir;
  float speed, size, alpha, alphaSpeed, deceleration, gravity, gravitySpeed;
  
  public Particle(PVector pos)
  {
    super();
    
    this.pos = pos;
    dir = new PVector(random(-10, 10), random(-4, 0.1), random(-10, 10)); //why do they all go the same direction? it's random isn't it?
    speed = random(3, 5);
    colour = white;
    size = random(2, 6);
    alpha = random(200, 255);
    alphaSpeed = random(10, 20);
    deceleration = random(0.01, 0.1);
    gravity = random(0.2, 0.8);
    gravitySpeed = random(0.05, 0.2);
  }
  
  void show()
  {
    world.pushMatrix();
    world.translate(pos.x, pos.y, pos.z);
    world.fill(colour, alpha);
    world.noStroke();
    world.box(size);
    world.popMatrix();
  }
  
  void act()
  {
    if(alpha >= 0) alpha -= alphaSpeed;
    else hp = 0;
    
    if(pos.y >= blockSize)
    {
      dir.setMag(speed);
      pos.add(dir);
      
      if(speed > 0) speed -= deceleration;
      else speed = 0;
      
      pos.y += gravity;
      gravity += gravitySpeed;
    }
  }
}
