// Calculates ring tables for "Chainmail Spheres"
// by Les Hall
// Sun Nov 11 2018
// Wed Dec  5 2018
// 


// initialize the user visible variables
float diameter = 6.9 * 25.4;  // sphere diameter
int ring = 1;  // ring geometry selection


boolean debug = true;
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


// parameters
color bgColor = color(20, 00, 30);
color fgColor = color(20, 80, 20);
color textColor = color(0, 205, 0);


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


void setup() {
  
  // graphics stuff
  size(420, 600);
  rectMode(CENTER);
  
  // expand arrays
  expand(mList, 4*1024);
  expand(dList, 4*1024);
  
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
  //text("by Inventor & others", width/2, 2.5*textSize);  
  //text("in the chainmail community", width/2, 3.5*textSize);  
  text(nf(diameter, 1, 1) + "mm (" + nf(diameter / 25.4, 1, 2) + "in) diameter", width/2, 3.35*textSize);  
  text("kv = " + nf(kv, 1, 3) + "    kh = " + nf(kh, 1, 3), width/2, 5.75*textSize);  
  
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
    dList = append(dList, (n>1 ? delta : 0) );
    
    // update origin of text placement
    textAlign(RIGHT, TOP);
    int row = n % 10 -1;
    int column = n / 10;

    originX = 80 + 195 * column;
    originY = 200 + 20 * row;
    // table header
    if ( row == 0 ) {
      text("row", originX, originY-7);
      text("ring", originX + 60, originY-7);
      text("d", originX + 90, originY-7);
    }
    text(n, originX, originY + 40);
    text(m, originX + 50, originY + 40);
    text(delta, originX + 90, originY + 40);

    // update counters 
    n++;
    total += (m * (n == 0 ? 1 : 2) * (ring == 0 ? 2 : 1) );
      
   // end the do/while loop
  } while (m > 1);

  // print out the table summary
  textAlign(CENTER, BOTTOM);
  text(weave, width/2, height - 1.75*textSize);
  text("total:  " + int(total) + " rings", width/2, height -1.0/2.0*textSize);
}
