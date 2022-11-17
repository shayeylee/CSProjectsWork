import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import processing.sound.*;
AudioIn in;
Amplitude amp;

Kinect kinect;

// Depth image
PImage depthImg;

// Which pixels do we care about?
int minDepth =  30;
int maxDepth = 900;
int index;
int d;

// What is the kinect's angle
float angle;

void setup() {
  size(640, 480);

  kinect = new Kinect(this);
  kinect.initDepth();
  angle = kinect.getTilt();

  // Blank image
  depthImg = new PImage(kinect.width, kinect.height);
  in = new AudioIn(this, 0);
  in.start();
  in.play();
  amp = new Amplitude(this);
  amp.input(in);
}

void draw() {
  // Threshold the depth image
  int[] rawDepth = kinect.getRawDepth();
  for (int i=0; i < height; i++) {
    for (int j=0; j<width; j++){
      int index = i*width+j;
      int d = rawDepth[index];
      if (d>=minDepth && d<=maxDepth){
        if (j>0 && j<width/6){
          depthImg.pixels[index] = color(150,0,0);
        }
        else if (j>=width/6 && j<(2*width)/6){
          depthImg.pixels[index] = color(255,131,0);
        }
        else if (j>=2*width/6 && j<(3*width)/6){
          depthImg.pixels[index] = color(255,255,0);
        }
        else if (j>=(3*width)/6 && j<(4*width)/6){
          depthImg.pixels[index] = color(0,185,0);
        }
        else if (j>=(4*width)/6 && j<(5*width)/6){
          depthImg.pixels[index] = color(0,92,192);
        }
        else if (j>=(5*width)/6 && j<width){
          depthImg.pixels[index] = color(134,0,192);
        }
      }
      else{
        depthImg.pixels[index] = color(0);
      }
    }
  }
  // Draw the thresholded image
  depthImg.updatePixels();
  image(depthImg, 0, 0);

  fill(0);
  text("TILT: " + angle, 10, 20);
  text("THRESHOLD: [" + minDepth + ", " + maxDepth + "]", 10, 36);
}

// Adjust the angle and the depth threshold min and max
void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      angle++;
    } else if (keyCode == DOWN) {
      angle--;
    }
    angle = constrain(angle, 0, 30);
    kinect.setTilt(angle);
  } else if (key == 'a') {
    minDepth = constrain(minDepth+10, 0, maxDepth);
  } else if (key == 's') {
    minDepth = constrain(minDepth-10, 0, maxDepth);
  } else if (key == 'z') {
    maxDepth = constrain(maxDepth+10, minDepth, 2047);
  } else if (key =='x') {
    maxDepth = constrain(maxDepth-10, minDepth, 2047);
  }
}
