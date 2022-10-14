int r;
int g;
int b;
void setup(){
  background(0);
  fullScreen();
  r = 0;
  g = 0;
  b = 0;
  strokeWeight(1);
}
void draw(){
  for (float i = height; i>0; i-=0.05)
  {
    stroke(r,255-i,b);
    line(i-(height*0.06),width,i-(height*0.06),0);

  }
  for (float i = 0; i<height; i+=0.05)
  {
    stroke(r,i,b);
    line(i+(1.32*height),width,i+(1.32*height), 0);

  }
}
