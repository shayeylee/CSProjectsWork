//main.js

function setup()
{
  createCanvas(700,700);
  x= 10;
  y = 700-x
  r = 0;
}

function draw()
{
  background(0);
  fill(r,120,x);
  ellipse(x, 350, 100, x);
  fill(0,x,120);
  ellipse(y, 350, 100, x);
  y=y-2;
  x=x+2;
  if (x>800){
    x=0;
    y = 690;
  }
  addEventListener('click', (event) => {
    if (r==0){
      r=255;
    }
    else {r=0}
  });
}
