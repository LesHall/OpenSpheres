// Calculates ring tables for "Kingsmaille Chainmail Spheres"
// by Les Hall
// Sun Nov 11 2018
// Wed Dec  5 2018
// Sun Aug 21 2022  stripped program down to Kingsmaille only
// Sat Sep 17 2022  modifiedd column formatting, added 7mm 14ga metric rings



// initialize the user visible variables
float diameter = 26;  // sphere diameter in millimeters
int ring = 2;  // ring type



// ring value arrays
float r = diameter/2;
float ID[] = {10.0, 5.83, 7};
float AR[] = {4.8, 4.8, 4.81};
float horiz[] = {.715, .417, .500/*change to measured value*/};
float vert[] = {.773, .451, .541/*change to measured value*/};
String[] ringDescription = {
  "14 gauge American - 3/8 inch ID", 
  "18 gauge American - 7/32 inch ID", 
  "14 gauge Metric - 7 mm ID"};



// select ring values
float ringID = ID[ring];  // ring inside diameter
float kh = horiz[ring];  // horizontal proportionality constant
float kv = vert[ring];  // vertical proportionality constant
String desc = ringDescription[ring];



// parameters
boolean debug = true;
color bgColor = color(0, 127, 127);
color fgColor = color(255);



// initialize the hidden global variables
float di = ringID;
int textSize = 25;
float total = 0;
//int tPos[] = {100, 210};  // table position (x, y)
//int tCol[] = {0, 80};  // table column offsets (horizontal)
float temp = 0;
float x = 0;
float y = 0;
float v = 0;



void setup()
{
  // graphics stuff
  size(600, 800);
}



void draw()
{
  
  // graphics stuff
  background(bgColor);
  
  fill(fgColor);
  stroke(fgColor);
 
  // title
  textAlign(CENTER, TOP);
  textSize(32);
  text("Chainmail Sphere Tables", width/2, 1*textSize);  
  text("Kingsmaille", width/2, 60);
  textSize(24);
  text("by Les Hall", width/2, 105);
  text(desc, width/2, 140);
  text(
    nf(diameter, 1, 1) + " mm (" + 
    nf(diameter/25.4, 1, 1) + " in) diameter", 
    300, 170);  
  
  // text setings
  textAlign(RIGHT, TOP);
  textSize(textSize);

  total = 0;  // total number of rings
  
  // declare sphere table variables
  int m = 0;
  int n = 0;
  
  // determine maximum row number
  int nMax = 0;
  int mMax = 0;
  do
  {
    // increment nMax
    nMax++;
    
    // make calculation
    mMax = round( (2*PI * r / (kh*di)) * cos( (kv*di/r) * nMax) );

  } while (mMax > 0);
  
  while (m >= 0)
  {
    // determine writing position
    int row = round(n%15);
    int offset = floor(nMax/15);
    int column = floor(n/15);
    int xPos = int(width/2 - 25 - 61*offset + 125*column);
    int yPos = 250 + 30*row;
    text("n", xPos, 210);
    text("m", xPos+50, 210);

    // make calculation
    m = round( (2*PI * r / (kh*di)) * cos( (kv*di/r) * n) );

    // update counters
    n++;
    total += round(m * (n == 0 ? 2 : 4));
  
    // print index and calculation
    if (m>0)
    {
      text(nf(round(n-1)), xPos, yPos);
      text(nf(round(m)), xPos+50, yPos);
    }
  } 

  // print out the table summary
  textAlign(CENTER);
  textSize(28);
  text("total:  " + nf(round(total), 0) +" rings", 
    width/2, height - 2*textSize);

  // quit running the program
  noLoop();
}
