import processing.pdf.*;

int rectsize = 40;
int posX;
int posY;


void setup()
{
  size(600,600);
  //frameRate(10);
}


boolean dosave;

void keyPressed()
{
  println(key);
  if(key == 's')
  {
    dosave = true;
  }
}


int speed = 1;

void mouseWheel(MouseEvent event) {
  float e = event.getCount();

  if (e > 0)
    speed = speed - 2;
  else
    speed = speed + 2;

  if (speed > 100)
    speed = 100;
  if (speed < -100)
    speed = -100;
}


void draw()
{
  if(dosave)
  {
    beginRecord(PDF, "frame-###.pdf");
  }
  background(255);
  posX = 0;
  posY = 0;
  for(int i=0; i<255; i++){
    fill(random(0, 255), random(0, 255), random(50, 120));
    
    rect(posX, posY, rectsize, rectsize);
    posX += rectsize;
    
    if(posX >= width){
      posY += rectsize;
      posX=0;
    }
  }
  
  if(dosave)
  {
    endRecord();
    dosave = false;
  }
  
  
  int waitTime;
  if (speed == 0)
    waitTime = 5000;
  else
    waitTime = 1000 / abs(speed);
    
  delay(waitTime);
}