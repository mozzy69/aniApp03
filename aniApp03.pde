
//Globals
Frame[] mainFrame;
Header myHeader;
int BeadSize;
int Columns;
int Rows;
int TotalColRow;
int HeaderHeight;
boolean Initialize;

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
  Columns = 15;
  Rows = 15;
  

  
  //Set BeadSize based on Device Display
  TotalColRow = Columns * Rows;
  BeadSize = width/(Columns + 2);
  
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
  mainFrame = new Frame[2];
  mainFrame[0] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[1] = new Frame(Rows, Columns, TotalColRow);
}

//------------------------------------------------------------------------------------//

void draw(){
  
  if(mousePressed && mouseX > BeadSize*(Columns+1)-(BeadSize*Columns)/3 &&
  mouseX < BeadSize*(Columns+1) && mouseY > HeaderHeight+BeadSize+(Rows*BeadSize) && 
  mouseY < HeaderHeight+BeadSize+(Rows*BeadSize)+(height-(BeadSize*Rows)+HeaderHeight)/3){
  println("computers");
  }
  
  mainFrame[0].drawFrame();
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

void mousePressed(){
  int one = 1;
println("I'm "+ one++ + " depressed" );
//fill(100);
}

