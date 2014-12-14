
//Globals
Bead mainBead;
Frame[] mainFrame;
Header mainHeader;
PickColor colorPicker;
Controls mainControls;

//Global Var
int BeadSize;
int Columns;
int Rows;
//TotalColRow = Columns * Rows
int TotalColRow;
//Set to draw grid at the beginning then set to false in drawFrame method**
boolean Initialize;
//Detect orientation use this for layout 
boolean VertOrient;
//Frame Index number of frame currently being accessed eg drawn to screen
int FmIndex;
//State of App draw, logo, hamburger
String headerState;
String appState;
boolean appTransition;
int aniSpeed = 200;
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
  Columns = 10;
  Rows = 10;
  
  FmIndex = 0;
  //Set BeadSize based on Device Display
  TotalColRow = Columns * Rows;
  
  //set BeadSize and Screen Orientation
  mainBead = new Bead(0,0,0);
  BeadSize = mainBead.setBeadSize(Columns, Rows);
  VertOrient = mainBead.setOrient();


  //Set Properties for the main header
  mainHeader = new Header(height, "HeadShadow.png", "logo.png"); 
  mainHeader.drawHeaderShadow(mainHeader.headerHeight);  
  mainHeader.drawLogo();
  mainHeader.drawHeaderText();
  mainHeader.drawHamBurger();
  
  //Setup Frames will be through interface have a setup button or hamburger button in header for this
  //here for illustrative purposes
  mainFrame = new Frame[4];
  mainFrame[0] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[1] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[2] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[3] = new Frame(Rows, Columns, TotalColRow);
  
  //Color Picker
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
  
  headerState = "headerClose";
  appState = "draw";
}

//------------------------------------------------------------------------------------//

void draw(){
  //Nuthin//
 
 
 
  if (headerState == "headerDown"){
    //background(235);
    //Initialize = true;
    //stroke(255);
    //mainFrame[FmIndex].drawFrameTrans(mainHeader.headerHeight);
    mainHeader.animateHeaderOpen(aniSpeed);
    aniSpeed+=aniSpeed;
  }
  
  if(headerState == "headerUp"){
    background(235);
    //Initialize = true;
    stroke(255);
    mainFrame[FmIndex].drawFrameTrans(mainHeader.headerHeight);
    mainHeader.animateHeaderClose(aniSpeed);
    aniSpeed-=aniSpeed/2;
  }
}
//---------------------------------------------------------------------------------------//
void mouseReleased(){
    mainControls.changeFrame(mainFrame, mainHeader.headerHeight);
    activeColor = colorPicker.activateColor();
    headerState = mainHeader.headerMouse(headerState);
}

void mousePressed(){

  if(mainFrame[FmIndex].frameMouse(mainHeader.headerHeight) && appState == "draw"){
   mainFrame[FmIndex].drawFrame(activeColor, mainHeader.headerHeight);//Pass bead color from color picker to here
  }
  
}


void mouseDragged(){

if(mainFrame[FmIndex].frameMouse(mainHeader.headerHeight) && appState == "draw"){
   mainFrame[FmIndex].drawFrame(activeColor, mainHeader.headerHeight);//Pass bead color from color picker to here
  }

}

