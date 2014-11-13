
//Globals
Frame[] mainFrame;
Header myHeader;
int BeadSize;
int Columns;
int Rows;
int TotalColRow;
int HeaderHeight;

PImage HeaderShadow;
PImage Logo;

PFont HeaderFont;

void setup(){
  size(displayWidth, displayHeight);
  
  //DeBug///////////////////////////
  println(width + " " + height);
  //////////////////////////////////
  
  //This will be set through the interface
  //here for illustrative purposes
  Columns = 4;
  Rows = 4;
  
  HeaderHeight = int((height/100)*10);
  
  //Set BeadSize based on Device Display
  TotalColRow = Columns * Rows;
  BeadSize = width/(Columns + 2);
  
  //Images
  HeaderShadow = loadImage("HeadShadow.png");
  //myHeader.drawHeader();
  for(int i = 0; i < width; i++){
      image(HeaderShadow, i, HeaderHeight - HeaderShadow.height);
    }
  
  int HeaderSansShad = HeaderHeight - HeaderShadow.height;
  ///////////////////////////////////////////
  //Display Logo
  Logo = loadImage("logo.png");
  //Logo.resize(25, 0);
  image(Logo, 0, 0, HeaderSansShad, HeaderSansShad);
  
  //Header Text
  HeaderFont = createFont("3Dumb.ttf", HeaderSansShad/2 );
  textFont(HeaderFont);
  text("Creative Code \n Animator App", HeaderSansShad, 0);
  
  //Setup Frames will be through interface
  //here for illustrative purposes
  mainFrame = new Frame[2];
  mainFrame[0] = new Frame(Rows, Columns, TotalColRow);
}

void draw(){
  smooth();
  mainFrame[0].drawFrame();
  
}

void mousePressed(){
  int one = 1;
println("I'm "+ one++ + " depressed" );
//fill(100);
}

