// Calculates ring tables for "Chainmail Spheres"
// by Les Hall
// Sun Nov 11 2018
// Wed Dec  5 2018
// 


// initialize the user visible variables
float diameter = 5 * 25.4;  // sphere diameter
int ring = 1;  // ring geometry selection
boolean debug = true;

// make tables of values for known ring types
// ring values
String maille[] = {
  "E8-2 TRL SXAB1438 * 2",
  "E8-1 TRL SXAB1212"};
float ID[] = {3.0/8.0 * 25.4, 25.4/2+2*2.4 /*calculated value*/ };
float WD[] = {2.0, 2.4};
float horiz[] = {0.74, 0.418};
float vert[] = {0.4125 /*calculated value*/ , 0.487};

// select from above tables for this run
String weave = maille[ring];  // weave type
float ringID = ID[ring];  // ring inside diameter
float kh = horiz[ring];  // horizontal proportionality constant
float kv = vert[ring];  // vertical proportionality constant


// parameters
color bgColor = color(20, 00, 30);
color fgColor = color(20, 80, 20);
color textColor = color(0, 205, 0);


// initialize the hidden global variables
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


void setup() {
  
  // graphics stuff
  size(400, 800);
  rectMode(CENTER);
  
  // expand arrays
  expand(mList, 1024);
  expand(dList, 1024);
  
  // sret origin
  originX = 200;
  originY = 200;
}




void draw() {
  
  // graphics stuf f
  background(bgColor);

  // title
  fill(textColor);
  textAlign(CENTER, TOP);
  textSize(32);
  text("Sphere Table Generator", width/2, textSize*1/2);  
  textSize(22);
  text("by Les Hall and Friends", width/2, 2.5*textSize);  
  text(nf(diameter, 1, 1) + "mm (" + nf(diameter / 25.4, 1, 1) + "in) diameter", width/2, 4.5*textSize);  
  text("kv = " + nf(kv, 1, 3) + "    kh = " + nf(kh, 1, 3), width/2, 5.5*textSize);  
  
  // text setings
  textAlign(RIGHT, TOP);
  
  // table header
  textAlign(RIGHT, TOP);
  text("row", 107, 180);
  text("ring", 185 +10, 180);
  text("delta", 285, 180);

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
     
    // remember delta values
    if (n>0)
      delta = mList[n-1] - mList[n];
    else
      delta = 0;
    dList = append(dList, delta);
    
  
    // update origin of text placement
    int column = floor(n/10.0);
    originX = 100 + 50 * column;
    originY = 210 + 30 * (n % 10);
    // write the rings per row text
    // which is the main purpose of the program
    text(column, originX, originY);
    //text(m, originX, originY);

    // update counters
    n++;
    total += m * (n == 0 ? 1 : 2);
      
   // end the do/while loop
  } while (m >= 0);

  // print out the table summary
  textAlign(CENTER);
  textSize(30);
  text(weave, width/2, height - 7*textSize);
  text("total:  " + int(total), width/2, height -5.5*textSize);
}
