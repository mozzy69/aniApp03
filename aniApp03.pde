/*******************************************************************************
The MIT License (MIT)

Copyright (c) 2014 Lyndon Daniels

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

**********************************************************************************/
//Includes/////////////////////////////////////////////////////////////////////
import select.files.*;
SelectLibrary files;

//Globals//////////////////////////////////////////////////////////////////////

//Objects
Bead mainBead;
Frame[] mainFrame;
Header mainHeader;
PickColor colorPicker;
Controls mainControls;

//Globally Influential Variables
int BeadSize;
int Columns;
int Rows;
int TotalColRow;
boolean Initialize;
//Detect orientation use this for layout 
boolean VertOrient;
//Frame Index. Number of frame currently being accessed i.e. drawn to screen
int FmIndex;
String headerState;
String appState;
boolean appTransition;
int aniSpeed = 200;
color activeColor;
int numberOfFrames;

//------------------------------------------------------------------------------------//
void setup(){
  size(displayWidth, displayHeight);
  smooth();
  background(235);
  stroke(255);

  Initialize = true;
  //Innitial Values for columns and rows, values are dynamic
  Columns = Rows = 10;
  TotalColRow = Columns * Rows;
   
  //Set BeadSize and Screen Orientation
  mainBead = new Bead(0,0,0);
  BeadSize = mainBead.setBeadSize(Columns, Rows);
  VertOrient = mainBead.setOrient();

//Draw the apps main screen so that the user knows where to click
//these calls are not updated in draw(){} unless animation is required
//dynamic updates of the display are preffered through mouse events
//****see end****//

  //Set Properties for the main header
  mainHeader = new Header(height, "HeadShadow.png", "logo.png"); 
  mainHeader.drawHeaderShadow(mainHeader.headerHeight);  
  mainHeader.drawLogo();
  mainHeader.drawHeaderText();
  mainHeader.drawHamBurger();
  
  //Initial Values for number of frames, these values are dynamic
  numberOfFrames = 4;
  mainFrame = new Frame[numberOfFrames];
  for(int i = 0; i < numberOfFrames; i++ ){
    mainFrame[i] = new Frame(Rows, Columns, TotalColRow);
  }
  
  //Color Picker
  colorPicker = new PickColor((BeadSize*Columns)/7);
  colorPicker.drawPickColor();
  
  //Draw Main Controls Forward, Backward..
  mainControls = new Controls("myControls");
  mainControls.drawBackwardControl(mainHeader.headerHeight);
  mainControls.drawForwardControl(mainHeader.headerHeight);
  mainControls.drawSaveControl(mainHeader.headerHeight);
  mainControls.drawExportControl(mainHeader.headerHeight);
  
  //File Output
  files = new SelectLibrary(this);
  
 //Draw the beads to the screen as a reference for user clicks
  for(int i = 0; i < TotalColRow; i++){
    mainFrame[FmIndex].drawFrame(mainFrame[FmIndex].storeBeadColor[i], mainHeader.headerHeight);
  }
  //****ends here****//
  
  //set the status of the applications features
  headerState = "headerClose";
  appState = "draw";
}

//------------------------------------------------------------------------------------//

void draw(){
 
  if (headerState == "headerDown"){
    mainHeader.animateHeaderOpen(aniSpeed);
    aniSpeed+=aniSpeed;
  }
  
  if(headerState == "headerUp"){ 
  ////////////////change cols and rows through menu////////   
    Columns = Rows = mainHeader.mappedColRowSlider;
    TotalColRow = Columns * Rows;
    BeadSize = mainBead.setBeadSize(Columns, Rows);

    mainFrame = new Frame[numberOfFrames];
    for(int i = 0; i < numberOfFrames; i++ ){
      mainFrame[i] = new Frame(Rows, Columns, TotalColRow);
    }  
  //////////////////////////////////////////////////////////
    background(235);
    //stroke(255);//add this again if you want stroke to appear on headerclose
    mainFrame[FmIndex].drawFrameTrans(mainHeader.headerHeight);
    mainHeader.animateHeaderClose(aniSpeed);
    aniSpeed-=aniSpeed/2;
  }
  
}
//---------------------------------------------------------------------------------------//
void mouseReleased(){
  if(appState == "draw"){
    mainControls.changeFrame(mainFrame, mainHeader.headerHeight);
    activeColor = colorPicker.activateColor();
    colorPicker.renderHex(activeColor);
    if(mainControls.saveControlMouse(mainHeader.headerHeight)){
       files.selectOutput("Select a file to write to:", "fileSelected");
    }
    
  }
  if(appState == "header" && mainHeader.frameSpinnerMouseUp()){
    numberOfFrames++;
    println(numberOfFrames);
  }else if(appState == "header" && mainHeader.frameSpinnerMouseDown() && numberOfFrames > 1){
    numberOfFrames--;
    println(numberOfFrames);
  }
  headerState = mainHeader.headerMouse(headerState);
}

void mousePressed(){

  if(mainFrame[FmIndex].frameMouse(mainHeader.headerHeight) && appState == "draw"){
   mainFrame[FmIndex].drawFrame(activeColor, mainHeader.headerHeight);//Pass bead color from color picker to here
  }
  
  if(appState == "header" && mainHeader.mouseColRowSlider()){
  mainHeader.moveColRowSlider();
  }
  
}


void mouseDragged(){

if(mainFrame[FmIndex].frameMouse(mainHeader.headerHeight) && appState == "draw"){
   mainFrame[FmIndex].drawFrame(activeColor, mainHeader.headerHeight);//Pass bead color from color picker to here
  }
  
if(appState == "header" && mainHeader.mouseColRowSlider()){
  mainHeader.moveColRowSlider();
  }  

}

void fileSelected(File selection) {
    if (selection == null) {
        println("Window was closed or the user hit cancel.");
    }else{
        println("User selected " + selection.getAbsolutePath());
        save(selection.getAbsolutePath() + ".png");
    }
}

