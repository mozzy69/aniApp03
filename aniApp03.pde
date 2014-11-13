
//Globals
Frame[] myFrame;
int BeadSize;
int Columns;
int Rows;
int TotalColRow;
int Header;

void setup(){
  size(displayWidth, displayHeight);
  
  //DeBug///////////////////////////
  println(width + " " + height);
  //////////////////////////////////
  //This will be set through the interface
  //here for illustrative purposes
  Columns = 4;
  Rows = 4;
  
  //Set BeadSize based on Device Display
  TotalColRow = Columns * Rows;
  BeadSize = width/(Columns + 2);
  
  //Setup Frames will be through interface
  //here for illustrative purposes
  myFrame = new Frame[2];
  myFrame[0] = new Frame(Rows, Columns, TotalColRow);
}

void draw(){
  myFrame[0].drawFrame();
}
