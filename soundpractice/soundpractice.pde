import processing.sound.*;

SoundFile song;
Amplitude amp;
Waveform waveform;
int r;
int g;
int b;
int songs = 100;

public void setup() {
  fullScreen();
  background(0);
  r = 0;
  g = 0;
  b = 0;
  song = new SoundFile(this, "DejaVuReal.mp3");
  song.loop();
  amp = new Amplitude(this);
  amp.input(song);
  waveform = new Waveform(this, songs);
  waveform.input(song);
}

public void draw() {
  background(0);
  waveform.analyze();
  drawGradient(amp.analyze());
  if (amp.analyze()<0.5){
    stroke(0,193,255);
  }
  else if (0.5<amp.analyze() && amp.analyze()<0.75){
    stroke(255,248,220);
  }
  else if (amp.analyze()>0.75){
    stroke(225,218,0,255);
  }
  doingTheWaveform();
}

void drawGradient(float a){
  if (a<0.5){
    fill(255,248,220);
  }
  else if (0.5<a && a<0.75){
    fill(225,218,0);
  }
  else if (a>0.75){
    fill(0,193,255);
  }
  noStroke();
  rect(0,0,width/10, height);
  rect(width-(width/10),0,width/10, height);
}

public void doingTheWaveform(){
  beginShape();
  for(int i = 0; i < songs; i++){
    vertex(
      map(i, 0, songs, 0, width+20),
      map(waveform.data[i], -1, 1, 0, 100)
    );
  }
  noFill();
  endShape();
  beginShape();
  for(int i = 0; i < songs; i++){
    vertex(
      map(i, 0, songs, 0, width+20),
      map(waveform.data[i], -1, 1, height-100, height)
    );
  }
  endShape();
}
