import processing.sound.*;
SoundFile song;
Amplitude amp;
int r;
int g;
int b;
int cubeDepth = 200;
void setup() {
  fullScreen(P3D);
  r = 0;
  g = 0;
  b = 0;
  song = new SoundFile(this, "Taylor_Swift_Shake_It_Off.mp3");
  song.loop();
  amp = new Amplitude(this);
  amp.input(song);
}

void draw(){
  background(0);
  translate(width/2, height/2);
  rotateY(-1*(width/2-mouseX)*0.003);
  for (int x = -cubeDepth; x<= cubeDepth; x +=50){
    for (int y = -cubeDepth; y <= cubeDepth; y+=50){
      for (int z = -cubeDepth; z <= cubeDepth; z+=50){
          pushMatrix();
          translate(x, y, z);
          rotateY(-1*(width/2-mouseX)*0.003);
          rotateX(frameCount * 0.05);
          fill(int(255*amp.analyze()), 0, 50);
          box(30);
          popMatrix();
      }
    }
  }
}
