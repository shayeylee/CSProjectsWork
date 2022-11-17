import org.openkinect.freenect.*;
import org.openkinect.processing.*;

Kinect kinect;

// Depth image
PImage depthImg;

// Which pixels do we care about?
int minDepth =  60;
int maxDepth = 860;
color c;

// What is the kinect's angle

void setup() {
  size(640, 480);
  kinect = new Kinect(this);
  kinect.initDepth();
  depthImg = new PImage(kinect.width, kinect.height);
  c=color(255);

}
void draw() {
  int[] rawDepth = kinect.getRawDepth();
  for (int i=0; i < rawDepth.length; i++) {
    if (rawDepth[i] >= minDepth && rawDepth[i] <= maxDepth) {
      depthImg.pixels[i] = c;
    } else {
      depthImg.pixels[i] = 0;
    }
  }
  depthImg.updatePixels();
  image(depthImg, 0, 0);
}

void RedFilter()
{
  c = color(255,0,0);
}

void GreenFilter()
{
  c = color(0,150,0);
}

// Adjust the angle and the depth threshold min and max
void keyPressed() {
  switch(key){
    case 'r':
         RedFilter();
         break;

    case 'g':
         GreenFilter();
         break;
    case 'b':
         c = color(0,0,150);
         break;
    case 'p':
         c = color(150,0,150);
         break;
    case 'w':
         c = color(255);
         break;
    case 'o':
         c = color(245, 164, 66);
         break;
    case 'y':
         c = color(255, 246, 0);
         break;
    case 'x':
         c = color(252, 164, 248);
         break;
  }
}
