// Calculates ring tables for "Chainmail Spheres"
// by Les Hall
// Sun Nov 11 2018
// Wed Dec  5 2018
// Sat May  9 2020
//
//


// brinU in 2D GUI library
import org.gicentre.handy.*;

HandyRenderer h;

// initialize the user visible variables
float diameter = 5.0 * 25.4;  // sphere diameter
int ring = 1;  // ring geometry selection


// make tables of values for known ring types
// ring values
String maille[] = {
  "E8-2 TRL SXAB1438 * 2", 
  "E8-1 TRL SXAB1212"};
float ID[] = {3.0/8.0 * 25.4, 25.4/2+2*2.4 /*calculated value*/ };
float WD[] = {2.0, 2.4};
float horiz[] = {0.74, /*0.38*/ 0.42186};
float vert[] = {0.895, 0.7128};

// select from above tables for this run
String weave = maille[ring];  // weave type
float ringID = ID[ring];  // ring inside diameter
float kh = horiz[ring];  // horizontal proportionality constant
float kv = vert[ring];  // vertical proportionality constant

// GUI stuff
//
// colors
color bgColor = color(0, 0, 0);
color fgColor = color(0,255, 0);
color textColor = color(255,0, 0);
//
// Fonts
String fontName = "BradleyHandITCTT-Bold";
// 
// sizes
int TitleSize = 40;
int subTitlsSize = 30;


// initial
// size the hidden global variables
float d = diameter;
float di = ringID;
int textSize = 25;

// variables related to table contents
int n = 0;
int m = 0;
int[] mList = {};
int delta = 0;
int dList[] = {};
int total = 0;
int originX = 0;  // where to put text (what column)
int originY = 0;  // where to put text (what row)
int weightIndication = 2;
int dx = 300;
int dy = 30;
int offsetX = 0;
int offsetY = 110;
int offX = 0;
int offY = 160;
int cx;
int cy;
PFont f;
float touchX = 0.5;
float touchY =1.15; 
int buttonSize = 40;



void setup() {

  // graphics stuff
  size(420, 520);
  h = new HandyRenderer(this);



// select from above tables for this run
 weave = maille[ring];  // weave type
 ringID = ID[ring];  // ring inside diameter
 kh = horiz[ring];  // horizontal proportionality constant
 kv = vert[ring];  // vertical proportionality constant

// size the hidden global variables
 d = diameter;
 di = ringID;
 textSize = 25;

  // Create the font
  printArray(PFont.list());
  f = createFont("BradleyHandITCTT-Bold", 24);
  textFont(f);

  // set up rectangular locations
  rectMode(CENTER);
  cx = width/2 + offsetX;
  cy = height/2 + offsetY;

  // expand arrays
  expand(mList, 4*1024);
  expand(dList, 4*1024);

  // sret origin
  originX = 200;
  originY = 100;

  frameRate(4);

  //h.setOverrideFillColour(true);
  h.setOverrideStrokeColour(true);
  println(Version.getText());
  h.setBackgroundColour(bgColor);
  h.setStrokeColour(textColor); 
  h.setFillColour(textColor);
  stroke(textColor);
  strokeWeight(2);
}





void draw() {
  background(bgColor);
  stroke(0);
  
  weave = maille[ring];  // weave type
  diameter = (touchX * 15.0) * 25.4;
  d = diameter;
  // select from above tables for this run
  weave = maille[ring];  // weave type
  ringID = ID[ring];  // ring inside diameter
 kh = horiz[ring];  // horizontal proportionality constant
 kv = vert[ring];  // vertical proportionality constant

  
  
  
  // positions
  cx = width/2 + offsetX;
  cy = height/2 + offsetY;
  //fill(226, 76, 52);
  // 
  // scrollbar
  fill(0, 0, 255);  // king's maille color
  h.rect(cx , cy, dx, dy);  // the bar itself
  fill(255, 255, 255);  // slider color
  h.rect(touchX*(dx+60)+offsetX+60, cy, 2, 40);  // the slider
  // 
  // pushbutton
  if (ring == 0)
    fill(0, 255, 0);  // king's maille color
  if (ring == 1)
   fill(255, 0, 0);  // 8n1 color
  h.rect(width/2 + offX, height/2 + offY, 40, 40);
  fill(textColor);  // 8n1 text color
 
  // graphics stuff
  textAlign(CENTER, TOP);
  textSize(TitleSize);
  text("Sphere Table Generator", width/2, textSize*1/2);  
  textSize(subTitlsSize);
  //text("by Inventor & others", width/2, 2.5*textSize);  
  //text("in the chainmail community", width/2, 3.5*textSize);  
  text(nf(diameter / 25.4, 1, 2) + " in (" + nf(diameter, 1, 1) + " mm) diameter", width/2, 2.75*textSize);  
  text("kv = " + nf(kv, 1, 3) + "           kh = " + nf(kh, 1, 3), width/2, 16.5*textSize);  

  // text setings
  textAlign(RIGHT, TOP);


  // set variables
  n = 0;
  m = 0;           
  float r = diameter/2.0;
  total = 0;  // total number of rings

  do {

    // make calculations
    m =  int( round( (2*PI * r / (kh*di)) * cos( (kv*di/r) * n) ) );

    // prepare the list of ring per row and fill it also
    mList = append(mList, m);  // fill

    // save the deltas
    if (n > 0)
      delta = mList[n-1] - mList[n];
    if (n <= 1)
      delta = 0;
    dList = append(dList, (n<1 ? delta : 0) );

    // update origin of text placement
    textAlign(RIGHT, TOP);
    int row = n % 10 -1;
    int column = n / 10;

    originX = 80 + 195 * column;
    originY = 110 + 20 * row;
    // table header
    if ( row == 0 ) {
      text("row", originX + 7, originY-7);
      text("ring", originX + 82, originY-7);
      //text("del", originX + 100, originY-7);
    }
    if (n >= 0) {
      text(n, originX, originY + 40);
      text(m, originX + 50, originY + 40);
      //text(delta, originX + 90, originY + 40);
    }
    // update counters 
    n++;
    total += (m * (n == 0 ? 1 : 2) * (ring == 0 ? 1 : 2) );

    // end the do/while loop
  } while (m > 1);

  // print out the table summary
  textAlign(CENTER, BOTTOM);
  text(weave, width/2, height - 1.75*textSize);
  text("total:  " + int(total) + " rings", width/2, height -1.0/2.0*textSize);
}



// handle mouse actions
void mousePressed() {
  // h.rect(30,60,100,80);
  cx = width/2 + offsetX;
  cy = height/2 + offsetY;
  if ( (mouseX > (cx-dx/2)) && 
    (mouseY > (cy-dy/2)) && 
    (mouseX < (cx+dx/2)) && 
    (mouseY < (cy+dy/2)) ) {
      touchX = ((mouseX - 60.0)/360.0);
    }
 }
 
 
 // 
 void mouseClicked() {
//   h.rect(width/2 + offX, height/2 + offY, 40, 40);
 if ( (mouseX > (width/2+offX-20)) && 
    (mouseY > (height/2+offY-20)) && 
    (mouseX < (width/2+offX+20)) && 
    (mouseY < (height/2+offY+20)) ) {
      ring = (ring + 1) % 2;
    }
 }
