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
int maxDepth = 800;
int index;
int d;

int count;
color b;

// What is the kinect's angle
float angle;

void setup() {
  size(640, 480);
  
  b = (0);

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
      if (d>=minDepth && d<=maxDepth){//checks to see if there is something in the frame/changes depth color
        if (j>width/2){//if it passes the line change color to red
          depthImg.pixels[index] = color(150,0,0);
          count++;
        }
        else{//if the object/photo is on the other side of line, keep it white
            depthImg.pixels[index] = color(255, 255, 255);
        }
      }//if the pixel is not a color aka if the pixel has no depth
      else{
     
          if (j>width/2){
            depthImg.pixels[index] = color(b);
          }
          else{
            depthImg.pixels[index] = color(0);
          }
      }
    }
  }
  // Draw the thresholded image
  depthImg.updatePixels();
  image(depthImg, 0, 0);

  fill(0);
  text("TILT: " + angle, 10, 20);
  text("THRESHOLD: [" + minDepth + ", " + maxDepth + "]", 10, 36);
  if(count>5){
    b = color(0,150,0);
  }
  else{
    b = color(0);
  }
  count =0;
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
