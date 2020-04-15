// Calculates ring tables for "Chainmail Spheres"
// by Les Hall
// Sun Nov 11 2018
// Wed Dec  5 2018
// 


// initialize the user visible variables
float diameter = 2.5 * 25.4;  // sphere diameter
int ring = 0;  // ring geometry selection


// ring values
String maille[] = {
  "E8-1 TRL SXAB1212"
};
float 6[] = {12.7};
float WD[] = {2.4};
float horiz[] = {0.4188};
float vert[] = {0.6692};
String weave = maille[ring];  // weave type
float ringID = ID[ring];  // ring inside diameter
float kh = horiz[ring];  // horizontal proportionality constant
float kv = vert[ring];  // vertical proportionality constant


// parameters
boolean debug = true;
color bgColor = color(0, 0, 0);
color fgColor = color(0, 128, 0);
color textColor = color(0, 2555, 0);


// initialize the hidden global variables
float d = diameter;
float di = ringID;
int textSize = 25;
float m = 0;
int mLen = 100;
float[] mList = {};
int n = 0;
float total = 0;
int tPos[] = {100, 210};  // table position (x, y)
int tCol[] = {0, 80};  // table column offsets (horizontal)
float temp = 0;
float x = 0;
float y = 0;
float v = 0;
int nMax[] = {0, 0};


void setup() {
  // graphics stuff
  size(400, 800);
  rectMode(CENTER);
  x = width*0.775;
  y = height-height/2;
  v = width*0.15;
  
    
  for (int i = 0; i < mLen; i++)
    mList = append(mList, -1);
}



void draw() {
  
  // graphics stuff
  background(bgColor);
  
 
  
  // title
  fill(textColor);
  textAlign(CENTER, TOP);
  textSize(40);
  text("Sphere Tables", width/2, 1*textSize);  
  textSize(30);
  text(nf(diameter, 1, 1) + "mm diameter", width/2, 3.5*textSize);  
  text("center to center", width/2, 5*textSize);  
  
  // text setings
  textAlign(RIGHT, TOP);
  textSize(textSize);

  total = 0;  // total number of rings
    // table header
    textAlign(RIGHT, TOP);
    text("n", tPos[0] + tCol[0], tPos[1]);
    text("m", tPos[0] + tCol[1], tPos[1]);
    
    // text setings    
    n = 0;
    m = 0;           
    float r = d/2.0;
    do {
      // make calculations
      m =  round( (2*PI * r / (kh*di)) * cos( (kv*di/r) * n) );
      mList[n] = m;
      
      // write the rings per row text
      // which is the main point of the program
      if ( (m > 0) && (n >= 0) ) {
        text(int(n), 
          tPos[0] + tCol[0], 
          tPos[1] + (n+3.0/2)*textSize);
        text(int(m), 
          tPos[0] + tCol[1], 
            tPos[1] + (n+3.0/2)*textSize);
      }

      // update counters
      n++;
      nMax[0] = n;
      total += m * (n == 0 ? 1/2 : 1);
    } while (m >= 0);
  
  

  // print out the table summary
  textAlign(CENTER);
  textSize(30);
  text(weave, width/2, height - 4*textSize);
  text("total:  " + int(total), width/2, height - 2*textSize);
}
