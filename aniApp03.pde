//comments ending in ** are temps
//Globals
Frame[] mainFrame;
Header mainHeader;
PickColor colorPicker;
Controls mainControls;
//See BeadSize in setup()**
int BeadSize;
int Columns;
int Rows;
//columns and rows total accessible from main**
int TotalColRow;
//Title of app**
//int HeaderHeight;
//Set to draw grid at the beginning then set to false in drawFrame method**
boolean Initialize;
//Detect orientation use this for layout 
boolean VertOrient;
//Frame Index number of frame currently being accessed eg drawn to screen
int FmIndex;

String appState;

//PImage HeaderShadow;
//PImage Logo;

//PFont HeaderFont;

color activeColor;


//------------------------------------------------------------------------------------//
void setup(){
  size(displayWidth, displayHeight);
  smooth();
  background(235);
  stroke(255);
  
  //DeBug///////////////////////////
  println(width + " " + height);
  //////////////////////////////////
  
  Initialize = true;
  
  //This will be set through the interface
  //here for illustrative purposes
  Columns = 15;
  Rows = 15;
  
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

  
//  //Header stuff needs to go into header class/////////////////
  //HeaderHeight = int((height/100)*10);
  
  //Images
  /*
  HeaderShadow = loadImage("HeadShadow.png");
  //myHeader.drawHeader();
  for(int i = 0; i < width; i++){
      image(HeaderShadow, i, mainHeader.headerHeight - HeaderShadow.height);
    }
   */
  mainHeader = new Header(height, "HeadShadow.png", "logo.png"); 
   
  mainHeader.drawHeaderShadow(mainHeader.headerHeight);  
  
  //int HeaderSansShad = HeaderHeight - HeaderShadow.height;
  ///////////////////////////////////////////
  //Display Logo
  mainHeader.drawLogo();
  /*
  Logo = loadImage("logo.png");
  //Logo.resize(25, 0);
  image(Logo, 0, 0, HeaderSansShad, HeaderSansShad);
  */
  //Header Text
  mainHeader.drawHeaderText();
  /*
  HeaderFont = createFont("3Dumb.ttf", HeaderSansShad/2 );
  textFont(HeaderFont);
  fill(100);
  text("CREATIVE CODE", HeaderSansShad, HeaderSansShad/2 -5);//-5 removes the shadow/border area around logo 
  text("ANIMATOR APP", HeaderSansShad, HeaderSansShad - 5);
  */
  mainHeader.drawHamBurger();
  
  //Setup Frames will be through interface have a setup button or hamburger button in header for this
  //here for illustrative purposes
  mainFrame = new Frame[4];
  mainFrame[0] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[1] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[2] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[3] = new Frame(Rows, Columns, TotalColRow);
  
  colorPicker = new PickColor((BeadSize*Columns)/14);
  colorPicker.drawPickColor();
  
  //Draw Main Controls Forward, Backward..
  mainControls = new Controls("myControls");
  mainControls.drawBackwardControl(mainHeader.headerHeight);
  mainControls.drawForwardControl(mainHeader.headerHeight);
  
 //More temp setup to initialize beads
  for(int i = 0; i < TotalColRow; i++){
    mainFrame[FmIndex].drawFrame(mainFrame[FmIndex].storeBeadColor[i], mainHeader.headerHeight);
  }
}

//------------------------------------------------------------------------------------//

void draw(){
  //Nuthin//
}

void mouseReleased(){
  mainControls.changeFrame(mainFrame, mainHeader.headerHeight);
  activeColor = colorPicker.activateColor();
  mainHeader.headerMouse();
}

void mousePressed(){
//  for(int i = 0; i < TotalColRow; i++){
// mainFrame[FmIndex].drawFrame(mainFrame[FmIndex].storeBeadColor[i]);
  if(mainFrame[FmIndex].frameMouse(mainHeader.headerHeight)){
   mainFrame[FmIndex].drawFrame(activeColor, mainHeader.headerHeight);//Pass bead color from color picker to here
  }
//  }
}


void mouseDragged(){
//  for(int i = 0; i < TotalColRow; i++){
// mainFrame[FmIndex].drawFrame(mainFrame[FmIndex].storeBeadColor[i]);
//if(mouseX > BeadSize && mouseY > mainHeader.headerHeight + BeadSize && mouseX < BeadSize * (Columns+1) && mouseY < mainHeader.headerHeight + BeadSize * (Rows+1)){
// mainFrame[FmIndex].drawFrame(activeColor, mainHeader.headerHeight);//Pass bead color from color picker to here
//}//DRY see void mousePressed()
//  }
if(mainFrame[FmIndex].frameMouse(mainHeader.headerHeight)){
   mainFrame[FmIndex].drawFrame(activeColor, mainHeader.headerHeight);//Pass bead color from color picker to here
  }

}

