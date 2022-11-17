import processing.sound.*;
AudioIn in;
Amplitude amp;
int r;
int g;
int b;
int cubeDepth = 200;
int x;
void setup() {
  fullScreen(P3D);
  r = 0;
  g = 0;
  b = 0;
  in = new AudioIn(this, 0);
  in.start();
  amp = new Amplitude(this);
  amp.input(in);
  x=0;
}

void draw(){
  strokeWeight(4);
  background(0);
  translate(width/2, height/2);
  rotateY(x*0.003);
  for (int x = -cubeDepth; x<= cubeDepth; x +=50){
    for (int y = -cubeDepth; y <= cubeDepth; y+=50){
      for (int z = -cubeDepth; z <= cubeDepth; z+=50){
          pushMatrix();
          translate(x, y, z);
          rotateY(x*0.003);
          rotateX(frameCount * 0.005);
          fill(int(500*amp.analyze())+20, 0,210, 100);
          box(100*amp.analyze()+20);
          popMatrix();
      }
    }
  }
  x++;
}
