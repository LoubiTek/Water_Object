int W = 1280;
int H = 720;
String ENGINE = P3D;
byte AA = 16;
byte FPS = 120;

float concentration = 1024;
float PHI = (1+sqrt(5))/2;
float ty = 0;
float a = 0;
float r = PHI;
float x = 0;
float y = 0;
float z = 0;
PVector P = new PVector(0,0,0);

void settings()
{
  size(W,H,ENGINE);
  smooth(AA);
}

void setup()
{
  background(0);
  frameRate(FPS);
  rectMode(CENTER);
  ellipseMode(CENTER);
}

void draw()
{
  MY_STUFF();
}

void MY_STUFF()
{
  translate(W/2,H/2);
  scale(.0628);
  
  strokeWeight(PHI);
  stroke(a,r,255,ALPHA);
  noFill();
  strokeJoin(BEVEL);
  rect(0,0,W,H);
  
  rotateX(ty);
  
  pushMatrix();
  {
    ty -= a;
    rotateY(ty);
    if(ty>=-r)
    {ty=r;}
  
    strokeWeight(PHI);
    sphereDetail(4);
    stroke(0,ALPHA);
    sphere(W-H);
    
    strokeWeight(PI);
    sphereDetail(4);
    stroke(255);
    sphere(W+H);
  }
  popMatrix();
  P.x += r * sin(P.x+(.1*FPS));
  P.y += r * cos(P.y+(.1*FPS));
  P.z -= r * tan(P.z-(.1*FPS));
  for(float i=-.1; i<.1; i++)
  {
    for(float j=-.1; j<.1; j++)
    {
      for(float k=-.1; k<.1; k++)
      {
        P(-P.x*i,-P.y*j,P.z*k);
        P(-P.x*i,P.y*j,P.z*k);
        P(P.x*i,-P.y*j,P.z*k);
        P(P.x*i,P.y*j,P.z*k);
      }
    }
  }
  if(P.x>=W/2)
  {P.x=-W/2;}
  if(P.y>=H/2)
  {P.y=-H/2;}
  if(P.z<=-PHI*a)
  {P.z=PHI*a;}
}

void P(float x, float y, float z)
{
  x += r * sin(x+(.1*FPS));
  y += r * cos(y+(.1*FPS));
  z -= r * tan(z-(.1*P.z));
  
  a -= P.z/FPS;
  r += AA/PHI;
  PHI -= a*r/P.z;
  
  for(byte i=-1; i<1; i++)
  {
    for(byte j=-1; j<1; j++)
    {
      for(byte k=-1; k<1; k++)
      {
        pushMatrix();
        {
          rotate(radians(a*PHI));
          strokeWeight(AA);
          point(-x*i,-y*j,z*k);
          point(-x*i,y*j,z*k);
          point(x*i,-y*j,z*k);
          point(x*i,y*j,z*k);
          
          strokeWeight(P.z);
          stroke(x,y,z,ALPHA);
          noFill();
          rotateZ(radians(r*PHI));
          circle(-x*i,-y*j,z*k);
          circle(-x*i,y*j,z*k);
          circle(x*i,-y*j,z*k);
          circle(x*i,y*j,z*k);
        }
        popMatrix();
        rotateY(a*ty);
        strokeWeight(.628);
        stroke(255,255,0);
        box(W+H);
        
        rotateX(-a*ty);
        strokeWeight(AA);
        stroke(255,0,0,ALPHA);
        sphereDetail(AA);
        sphere(W-H);
      }
    }
  }
  
  if(x>=W/2)
  {x=-W/2;}
  if(y>=H/2)
  {y=-H/2;}
  if(z<=-PHI*P.z)
  {z=PHI*P.z;}
  if(a>=-360)
  {a=0;}
  if(r<=-PHI*a)
  {r=PHI*a;}
  if(PHI>=W/TAU*H/TAU)
  {PHI=-(1+sqrt(5))/2;}
}

void mousePressed()
{
  if(mousePressed)
  {
    lights();
    spotLight(51, 102, 126, 200, 200, 1600, 
              0, 0, -1, PI/AA, concentration);
    ambientLight(255,255,0);
    stroke(0);
    fill(255);
    sphere(W*TAU+H*TAU);
    MY_STUFF();
  } else {noLights();}
}
