float rX, rY;

ArrayList<Object> objects = new ArrayList();

PImage dTexture;

void setup()
{
  size(800, 800, P3D);
  textureMode(NORMAL);
  
  dTexture = loadImage("diamond.png");
  
  objects.add(new RPrism(new PVector(width / 2, height / 2, -200), width / 3, height, 100, 200));
  
  objects.add(new Sphere(new PVector(width / 2, height / 2 - 175, 0), 75, color(0, 255, 0)));
  objects.add(new Sphere(new PVector(width / 2, height / 2, 0), 75, color(255, 255, 0)));
  objects.add(new Sphere(new PVector(width / 2, height / 2 + 175, 0), 75, color(255, 0, 0)));
  
  objects.add(new RPrism(new PVector(200, 200, 100), 150, dTexture));
  objects.add(new RPrism(new PVector(width - 200, 200, 100), 150, dTexture));
  objects.add(new RPrism(new PVector(width - 200, height - 200, 100), 150, dTexture));
  objects.add(new RPrism(new PVector(200, height - 200, 100), 150, dTexture));
}

void draw()
{
  background(0);
  
  drawObjects();
}

void mouseMoved()
{
  rX += (pmouseY - mouseY) * 0.01;
  rY += (pmouseX - mouseX) * 0.01;
}

void drawObjects()
{
  for(Object object : objects)
    object.show();
}
