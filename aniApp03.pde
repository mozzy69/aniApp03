
//Globals
Frame[] mainFrame;
Header myHeader;
int BeadSize;
int Columns;
int Rows;
int TotalColRow;
int HeaderHeight;
boolean Initialize;
boolean VertOrient;
int FmIndex;

PImage HeaderShadow;
PImage Logo;

PFont HeaderFont;
//------------------------------------------------------------------------------------//
void setup(){
  size(displayWidth, displayHeight);
  smooth();
  background(255);
  stroke(255);
  
  //DeBug///////////////////////////
  println(width + " " + height);
  //////////////////////////////////
  
  Initialize = true;
  
  //This will be set through the interface
  //here for illustrative purposes
  Columns = 20;
  Rows = 20;
  
  FmIndex = 0;
  //Set BeadSize based on Device Display
  TotalColRow = Columns * Rows;
  //Set BeadSize and Determine Display Orientation
  if (width<height){
    BeadSize = width/(Columns + 2);
    VertOrient = true;
  }else{
    BeadSize = height/(Rows + 4);
    VertOrient = false;
  }
  
  //Header stuff needs to go into header class/////////////////
  HeaderHeight = int((height/100)*10);
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
  fill(0);
  text("Creative Code \n Animator App", HeaderSansShad, 0);
  
  //Setup Frames will be through interface
  //here for illustrative purposes
  mainFrame = new Frame[4];
  mainFrame[0] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[1] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[2] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[3] = new Frame(Rows, Columns, TotalColRow);
}

//------------------------------------------------------------------------------------//

void draw(){
  
 
  
  mainFrame[FmIndex].drawFrame();
  /*
  if(mouseX>0 && mouseX<width/4){
    mainFrame[0].drawFrame();
    println("left");
  }else if(mouseX<width&& mouseX>width/2){
    mainFrame[1].drawFrame();
    println("right");
  }
 */ 
 
 rect(BeadSize, HeaderHeight+BeadSize+(Rows*BeadSize), 
 (BeadSize*Columns)/3, (height-(BeadSize*Rows)+HeaderHeight)/3);
 
 rect(BeadSize*(Columns+1)-(BeadSize*Columns)/3, HeaderHeight+BeadSize+(Rows*BeadSize), 
 (BeadSize*Columns)/3, (height-(BeadSize*Rows)+HeaderHeight)/3);
}

void mouseReleased(){
  //This is a debug to test the forward and previous buttons below the canvas
  //FmIndex will cause the program to crash if it exceeds mainFrame[] element access
  if(mouseX > BeadSize*(Columns+1)-(BeadSize*Columns)/3 &&
  mouseX < BeadSize*(Columns+1) && mouseY > HeaderHeight+BeadSize+(Rows*BeadSize) && 
  mouseY < HeaderHeight+BeadSize+(Rows*BeadSize)+(height-(BeadSize*Rows)+HeaderHeight)/3){
    println("computers");
    FmIndex++;
    println(FmIndex);
  }else if(mouseX > BeadSize && mouseX < BeadSize + (BeadSize*Columns)/3 &&
  mouseY > HeaderHeight+BeadSize+(Rows*BeadSize) && 
   mouseY < HeaderHeight+BeadSize+(Rows*BeadSize)+(height-(BeadSize*Rows)+HeaderHeight)/3){
    println("more compies");
    FmIndex--;
    println(FmIndex);  
   }
}

