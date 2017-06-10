
PGraphics screenBuffer;

void setup()
{
  size(500, 500);
  screenBuffer = createGraphics(width, height);

  screenBuffer.beginDraw();
  
  screenBuffer.fill(255, 0, 0);
  screenBuffer.ellipse(width/2, height/2, 100, 100); 

  screenBuffer.endDraw();
  screenBuffer.save("foobar.tiff");
  
  image(screenBuffer, 0, 0);
}

void draw()
{
}