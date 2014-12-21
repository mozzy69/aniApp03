package processing.test.aniapp03;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import select.files.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class aniApp03 extends PApplet {

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
int activeColor;
int numberOfFrames;

//------------------------------------------------------------------------------------//
public void setup(){
 
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

public void draw(){
 
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
public void mouseReleased(){
  if(appState == "draw"){
    mainControls.changeFrame(mainFrame, mainHeader.headerHeight);
    activeColor = colorPicker.activateColor();
    colorPicker.renderHex(activeColor);
    if(mainControls.saveControlMouse(mainHeader.headerHeight)){
       files.selectOutput("Save Image File To:", "fileSelectedSave");   
    }else if(mainControls.exportControlMouse(mainHeader.headerHeight)){
      files.selectOutput("Export Hex Color Values To:", "fileSelectedExport"); 
    }
    
  }
  if(appState == "header" && mainHeader.frameSpinnerMouseUp()){
    numberOfFrames++;
    mainHeader.drawFrameSpinner();
    println(numberOfFrames);
  }else if(appState == "header" && mainHeader.frameSpinnerMouseDown() && numberOfFrames > 1){
    numberOfFrames--;
    mainHeader.drawFrameSpinner();
    println(numberOfFrames);
  }
  headerState = mainHeader.headerMouse(headerState);
}

public void mousePressed(){

  if(mainFrame[FmIndex].frameMouse(mainHeader.headerHeight) && appState == "draw"){
   mainFrame[FmIndex].drawFrame(activeColor, mainHeader.headerHeight);//Pass bead color from color picker to here
  }
  
  if(appState == "header" && mainHeader.mouseColRowSlider()){
  mainHeader.moveColRowSlider();
  }
  
}


public void mouseDragged(){

if(mainFrame[FmIndex].frameMouse(mainHeader.headerHeight) && appState == "draw"){
   mainFrame[FmIndex].drawFrame(activeColor, mainHeader.headerHeight);//Pass bead color from color picker to here
  }
  
if(appState == "header" && mainHeader.mouseColRowSlider()){
  mainHeader.moveColRowSlider();
  }  

}

public void fileSelectedSave(File selection) {
    if (selection == null) {
        println("Window was closed or the user hit cancel.");
    }else{
        println("User selected " + selection.getAbsolutePath());
        save(selection.getAbsolutePath() + ".png");
    }
}

public void fileSelectedExport(File selection) {
    if (selection == null) {
        println("Window was closed or the user hit cancel.");
    }else{
        println("User selected " + selection.getAbsolutePath());
        String[] list = new String[TotalColRow];
        for(int i = 0; i < TotalColRow; i++){
          list[i] = hex(mainFrame[FmIndex].storeBeadColor[i]);
        }
        saveStrings(selection.getAbsolutePath() + ".txt", list);
    }
}

class Bead{

  //Fields 
  float xLocB;
  float yLocB;
  float sizeB;
  int tempBeadSize;
  boolean tempVertOrient;
  //boolean beadDown;
  
//  Constructor

  Bead(float tempxLocB, float tempyLocB, float tempSizeB){
    xLocB = tempxLocB;
    yLocB = tempyLocB;
    sizeB = tempSizeB;
  }
  
  
  //Methods//
  
  public int drawBead(int beadColor, int HeaderHeightTemp){
    fill(beadColor);
    rect(xLocB + BeadSize, yLocB + BeadSize + HeaderHeightTemp, sizeB, sizeB);
    return beadColor;
  }
  
  public int setBeadSize(int tempColumns, int tempRows){
   if (width<height){
      tempBeadSize = width/(tempColumns + 2);
    }else{
      tempBeadSize = height/(tempRows + 4);
    }
    return tempBeadSize;
  }
  
  public boolean setOrient(){
   if (width<height){
      tempVertOrient = true;
    }else{
      tempVertOrient = false;
    }
    return tempVertOrient;  
   }
  
}
class Controls{

  //Fields 
  String controlType;
  boolean saveControlMousePos;
  boolean exportControlMousePos;
  boolean ControlMousePos;
  //Constructor

  Controls(String tempControlType){
    controlType = tempControlType;
  }
  
  //Methods
  public void drawForwardControl(int HeaderHeightTemp){
    fill(125);
    rect(BeadSize*(Columns+1)-(BeadSize*Columns)/3, HeaderHeightTemp+BeadSize+(Rows*BeadSize), 
    (BeadSize*Columns)/3, HeaderHeightTemp);
  }
  
  public void drawBackwardControl(int HeaderHeightTemp){
    fill(125);
    rect(BeadSize, HeaderHeightTemp+BeadSize+(Rows*BeadSize), 
    (BeadSize*Columns)/3, HeaderHeightTemp);
  }
  
  public void drawPlayControl(){
  //Nothing yet
  }
  
  public void drawSaveControl(int HeaderHeightTemp){
    stroke(255);
    rect(BeadSize, HeaderHeightTemp+BeadSize+(Rows*BeadSize)+HeaderHeightTemp,
         (BeadSize*(Columns/2)), HeaderHeightTemp);
    noStroke();
  }
  
  public void drawExportControl(int HeaderHeightTemp){
    stroke(255);
    rect(BeadSize+(BeadSize*(Columns/2)), HeaderHeightTemp+BeadSize+(Rows*BeadSize)+HeaderHeightTemp,
         (BeadSize*(Columns/2)), HeaderHeightTemp);
    noStroke();
  }
  
  public boolean saveControlMouse(int HeaderHeightTemp){
    if(mouseX > BeadSize && mouseY > HeaderHeightTemp+BeadSize+(Rows*BeadSize)+HeaderHeightTemp &&
       mouseX < BeadSize + (BeadSize*(Columns/2)) && mouseY < HeaderHeightTemp+BeadSize+(Rows*BeadSize)+HeaderHeightTemp + HeaderHeightTemp){
         saveControlMousePos = true;
         println("Save Control");
       }else{
         saveControlMousePos = false;
       }
      return saveControlMousePos;
  }
  
  public boolean exportControlMouse(int HeaderHeightTemp){
    if(mouseX > BeadSize+(BeadSize*(Columns/2)) && mouseY > HeaderHeightTemp+BeadSize+(Rows*BeadSize)+HeaderHeightTemp &&
       mouseX < BeadSize + (BeadSize*(Columns/2))+(BeadSize*(Columns/2)) && mouseY < HeaderHeightTemp+BeadSize+(Rows*BeadSize)+HeaderHeightTemp + HeaderHeightTemp){
         exportControlMousePos = true;
         println("Export Control");
       }else{
         exportControlMousePos = false;
       }
      return exportControlMousePos;
  }
  
  public void changeFrame(Frame[] tempFrame, int HeaderHeightTemp){
   if(mouseX > BeadSize*(Columns+1)-(BeadSize*Columns)/3 &&
  mouseX < BeadSize*(Columns+1) && mouseY > HeaderHeightTemp+BeadSize+(Rows*BeadSize) && 
  mouseY < HeaderHeightTemp+BeadSize+(Rows*BeadSize)+HeaderHeightTemp){
    if(FmIndex < tempFrame.length-1){
      FmIndex++;
      println("this is index " + FmIndex);
      //for(int i = 0; i < TotalColRow; i++){ 
        tempFrame[FmIndex].fmDrawBead(HeaderHeightTemp);
        //println(tempFrame[FmIndex].storeBeadColor[i]); 
      //}
    }
  }else if(mouseX > BeadSize && mouseX < BeadSize + (BeadSize*Columns)/3 &&
  mouseY > HeaderHeightTemp+BeadSize+(Rows*BeadSize) && 
   mouseY < HeaderHeightTemp+BeadSize+(Rows*BeadSize)+HeaderHeightTemp){
    if(FmIndex > 0){
      FmIndex--;
      println("this is index " + FmIndex); 
      //for(int i = 0; i < TotalColRow; i ++){
        tempFrame[FmIndex].fmDrawBead(HeaderHeightTemp);
        //println(tempFrame[FmIndex].storeBeadColor[i]);
      //}
    }
   }
  }
}
class Frame{

  //Fields
  Bead[] fmBeads;
  int fmRows;
  int fmCols;
  int totalBeads;
  int beadColorFm;
  int[] storeBeadColor;
  boolean frameMousePos;
  
  //Constructor
  Frame(int tempFmRows, int tempFmCols, int tempTotalBeads){
    fmRows = tempFmRows;
    fmCols = tempFmCols;
    totalBeads = tempTotalBeads;
    fmBeads = new Bead[totalBeads];
    storeBeadColor = new int[totalBeads];
    
    int index=0;
    for(int y = 0; y < fmRows; y++){
      for(int x = 0; x < fmCols; x++){
        fmBeads[index++] = new Bead(x*BeadSize,y*BeadSize,BeadSize);
      }
    }  
 
  }
  
  //Methods
  //Main method for drawing a frame consisting of sets of beads
  public int[] drawFrame(int beadColorFmNew, int HeaderHeightTemp){
  for(int i = 0; i < totalBeads; i++){
      if(mousePressed && 
      mouseX > fmBeads[i].xLocB + BeadSize && 
      mouseX < fmBeads[i].xLocB + BeadSize + fmBeads[i].sizeB && 
      mouseY > fmBeads[i].yLocB + BeadSize + HeaderHeightTemp && 
      mouseY < fmBeads[i].yLocB + BeadSize + HeaderHeightTemp + fmBeads[i].sizeB){
        beadColorFm = beadColorFmNew;
        storeBeadColor[i] = fmBeads[i].drawBead(beadColorFm, HeaderHeightTemp);
      }else if(Initialize){
        beadColorFm = beadColorFmNew;        
        storeBeadColor[i] = fmBeads[i].drawBead(beadColorFm, HeaderHeightTemp);
      }//End conditional
   }//End loop
   Initialize = false;
   return storeBeadColor;
  }//End drawFrame()
  
  
    public int[] drawFrameTrans(int HeaderHeightTemp){
  for(int i = 0; i < totalBeads; i++){
      if(headerState == "headerUp"){
        storeBeadColor[i] = fmBeads[i].drawBead(storeBeadColor[i], HeaderHeightTemp);
      }
   }//End loop
   noStroke();
   return storeBeadColor;
  }//End drawFrame()
  
  public void fmDrawBead(int HeaderHeightTemp){
    for(int i = 0; i < totalBeads; i++){
      //beadColorFm = beadColorFmNew;
      fmBeads[i].drawBead(storeBeadColor[i], HeaderHeightTemp);
    }
  }
  
  public boolean frameMouse(int headerHeightTemp){
     if(mouseX > BeadSize && mouseY > headerHeightTemp + BeadSize 
     && mouseX < BeadSize * (Columns+1) && mouseY < headerHeightTemp + BeadSize * (Rows+1)){
     frameMousePos = true;//Pass bead color from color picker to here
    }
    return frameMousePos;
  }
  
}//End Frame class definition/////////////////////////////////////////////////////////////////
class Header{

//  Fields  
  int headerHeight;
  int headerSansShad;
  PImage HeaderShadow;
  PImage Logo;
  PFont  HeaderFont;
  PFont creditFont;
  PFont interfaceFont;
  int boarder;
  boolean mouseColRowSliderPos;
  float mapColRowSlider;
  int mappedColRowSlider;
  float afterCreds;
  float credsBaseline;
  boolean frameSpinnerMouseUpPos;
  boolean frameSpinnerMouseDownPos;

//  Constructor

  Header(int headerHeightTemp, String HeaderShadowTemp, String logoTemp){
    headerHeight = PApplet.parseInt((headerHeightTemp/100)*10);//headerHeightTemp is height
    HeaderShadow = loadImage(HeaderShadowTemp);
    Logo = loadImage(logoTemp);
    headerSansShad = this.headerHeight - this.HeaderShadow.height;
    boarder = 5;
    credsBaseline = height/4 + (textAscent()+textDescent())*8;
    //8 is the number of elements to include line, col row text, 
    //col row number, slider, frame text, spinner
    afterCreds = (height - credsBaseline)/8;
    //innitial Vale for number of cols and rows
    mappedColRowSlider = 10;
  }

//Methods

//Draw The Header's Shadow////////////////////////////////////////////////////
  public PImage drawHeaderShadow(int HeaderHeightTemp){
    //HeaderShadow = loadImage("HeadShadow.png");
    for(int i = 0; i < width; i++){
      image(this.HeaderShadow, i, HeaderHeightTemp - this.HeaderShadow.height);
    }
    return HeaderShadow;
  } 
  
//Draw the logo//////////////////////////////////////////////////////////////  
  public void drawLogo(){
    image(Logo, 0, 0, this.headerSansShad, this.headerSansShad);
  }

//Render the text////////////////////////////////////////////////////////////   
  public void drawHeaderText(){
    HeaderFont = createFont("3Dumb.ttf", (this.headerSansShad/2)-boarder );
    textFont(HeaderFont);
    fill(100);
    textAlign(CENTER);
    text("CREATIVE CODE", width/2, this.headerSansShad/2 - this.boarder);//-5 removes the shadow/border area around logo 
    text("MOBILE ANIMATOR", width/2, this.headerSansShad - this.boarder);  
  }
  
//Draw the hamburger button//////////////////////////////////////////////////  
  public void drawHamBurger(){
    fill(255);
    rect(width - this.headerSansShad, boarder/2, this.headerSansShad - boarder, this.headerSansShad - boarder, this.boarder);
    fill(200);
    //Hamburger Graphic///////
    noStroke();
    rect(width - this.headerSansShad + boarder*0.5f, this.headerSansShad - boarder *4, 
        this.headerSansShad - boarder *2, boarder *3, boarder); 
    rect(width - this.headerSansShad + boarder*0.5f, ((boarder/2 + this.headerSansShad - boarder)/2)-boarder , 
        this.headerSansShad - boarder *2, boarder * 3, boarder);    
    rect(width - this.headerSansShad + boarder*0.5f, boarder, 
        this.headerSansShad - boarder *2, boarder * 3, boarder);    
  }
  
//Determine the position of the mouse over hamburger or logo/////////////////  
  public String headerMouse(String tempAppState){
    if(mouseX > 0 && mouseY > 0 && mouseX < this.headerSansShad && mouseY < this.headerSansShad){
      if(tempAppState == "headerClose"){
        tempAppState = "headerDown";
      }else if (tempAppState == "headerOpen"){
        tempAppState = "headerUp";
      }
    }else if(mouseX > width - this.headerSansShad && mouseY > 0 && mouseX < width && mouseY < this.headerSansShad) {
      if(tempAppState == "headerClose"){
        tempAppState = "headerDown";
      }else if (tempAppState == "headerOpen"){
        tempAppState = "headerUp";
      }
    }
    return tempAppState;
  }
  
//Drop the header down (open it)/////////////////////////////////////////////  
  public void animateHeaderOpen(int tempHeight){
    if (tempHeight < height - this.HeaderShadow.height){
      noStroke();
      fill(235);
      rect(0, this.headerHeight - this.HeaderShadow.height, width, tempHeight);
      for(int i = 0; i < width; i++){
        image(this.HeaderShadow, i, (this.headerHeight - this.HeaderShadow.height)+tempHeight);
      } 
      println(tempHeight);
    }else if (tempHeight >= height - this.HeaderShadow.height){
    tempHeight = height - this.HeaderShadow.height;
     rect(0, this.headerHeight - this.HeaderShadow.height, width, tempHeight - this.HeaderShadow.height);
      for(int i = 0; i < width; i++){
        image(this.HeaderShadow, i, height - this.HeaderShadow.height);
        } 
    headerState = "headerOpen";
    this.drawHeaderCreds();
    this.drawColRowSlider();
    this.drawFrameSpinner();
    }
  }

//Raise the header up (close it)//////////////////////////////////////////////
    public void animateHeaderClose(int tempHeight){
      if (tempHeight > this.headerHeight){
      noStroke();
      fill(235);
      rect(0, this.headerHeight - this.HeaderShadow.height, width, tempHeight);
      for(int i = 0; i < width; i++){
        image(this.HeaderShadow, i, height - tempHeight);
        }
        this.drawLogo();
        this.drawHeaderText();
        this.drawHamBurger();
        colorPicker.drawPickColor();
        println("hello spencer");
      }else if (tempHeight <= this.headerHeight){
          tempHeight = this.headerHeight;
          for(int i = 0; i < width; i++){
            image(this.HeaderShadow, i, tempHeight);
          }
          this.drawLogo();
          this.drawHeaderText();
          this.drawHamBurger();
          colorPicker.drawPickColor();
          mainControls.drawBackwardControl(mainHeader.headerHeight);
          mainControls.drawForwardControl(mainHeader.headerHeight);
          mainControls.drawSaveControl(mainHeader.headerHeight);
          mainControls.drawExportControl(mainHeader.headerHeight);
          headerState = "headerClose";
          appState = "draw";
          //Initialize = true;
        }
  }
 //////////////////////////////////////////////////////////////////////////////////////// 
  
  //Draw Header Credits
  public void drawHeaderCreds(){
    appState = "header";  
    textAlign(CENTER);
    fill(50);
    text("Creative Code", width/2, height/4);
    text("Mobile Animator", width/2, height/4 + textAscent()+textDescent());
  
    creditFont = createFont("BPdotsUnicaseSquare.otf", this.headerSansShad/2 );
    textFont(creditFont);
    text("By Lyndon Daniels", width/2, height/4 + (textAscent()+textDescent())*4);
    textSize((this.headerSansShad/2)/1.5f);
    text("Based on \nMarion Walton's Animator App", width/2, height/4 + (textAscent()+textDescent())*8);
  }
  
  
  public void drawColRowSlider(){
    //line to seperate creds from interface controls
    stroke(15);
    line(BeadSize, credsBaseline + afterCreds, width-BeadSize, credsBaseline + afterCreds);
    //Font used for interface controls  
    interfaceFont = createFont("Amble-Regular.ttf", this.headerSansShad/2);
    textFont(interfaceFont);
    text("Columns and Rows" + " " +this.mappedColRowSlider, width/2, credsBaseline + afterCreds*2);
    //box around dynamic col row text to redraw number
    fill(235);
    rect(width/2 + textWidth("indRows"), credsBaseline + afterCreds*2-textWidth("000")/2, textWidth("000"), textWidth("00"));
    //Slider bar
    fill(50);
    rect(BeadSize, credsBaseline + afterCreds*3, width-BeadSize*2, headerHeight/2, boarder );
    //Slider Moving part
    fill(100);
    rect(BeadSize, credsBaseline + afterCreds*3, headerHeight/2, headerHeight/2, boarder);
    //Frames text is here because it does not need to update
    text("Frames", width/2+textWidth("F"), credsBaseline + afterCreds*4.5f);
  }
  
  public boolean mouseColRowSlider(){
    if (mouseX > BeadSize && mouseY > credsBaseline + afterCreds*3
    && mouseX < width - BeadSize*2 && mouseY < credsBaseline + afterCreds*3 + headerHeight/2){
      mouseColRowSliderPos = true;
    }else{
      mouseColRowSliderPos = false;
    }
    return mouseColRowSliderPos;
  }
  
  public void moveColRowSlider(){
    //interfaceFont = createFont("Amble-Regular.ttf", this.headerSansShad/2);
    //textFont(interfaceFont);
    fill(235);
    rect(width/2 + textWidth("indRows"), credsBaseline + afterCreds*2-textWidth("000")/2, textWidth("000"), textWidth("00"));
    fill(50);
    text(this.mappedColRowSlider, width/2 + textWidth("and Rows "), credsBaseline + afterCreds*2);
    rect(BeadSize, credsBaseline + afterCreds*3, width-BeadSize*2, headerHeight/2, boarder );
    fill(100);
    rect(mouseX, credsBaseline + afterCreds*3, headerHeight/2, headerHeight/2, boarder);
    mapColRowSlider = mouseX;
    mappedColRowSlider = PApplet.parseInt(map(this.mapColRowSlider, BeadSize, width-BeadSize*2, 2, 51));
  }
  
  public void drawFrameSpinner(){
    fill(200);
    rect(width/2-headerHeight/2, credsBaseline + afterCreds*5, headerHeight, headerHeight, boarder,0,0,boarder); 
    fill(125);
    
    rect(width/2+headerHeight/2, credsBaseline + afterCreds*5, headerHeight/2, headerHeight/2, boarder, boarder, 0,0);
    rect(width/2+headerHeight/2, credsBaseline + afterCreds*5+headerHeight/2, headerHeight/2, headerHeight/2, 0, 0, boarder, boarder);
    text(numberOfFrames, width/2, credsBaseline + afterCreds*5+headerHeight/2+textAscent()/2);
  }
  
  public boolean frameSpinnerMouseUp(){
    if(mouseX > width/2+headerHeight/2 && mouseY > credsBaseline + afterCreds*5 &&
        mouseX < width/2+headerHeight/2 + headerHeight/2 && mouseY < credsBaseline + afterCreds*5 + headerHeight/2){
        frameSpinnerMouseUpPos = true;
        //this.drawFrameSpinner();
        }else{
        frameSpinnerMouseUpPos = false;
        }
        return frameSpinnerMouseUpPos;
    }
  
  public boolean frameSpinnerMouseDown(){
    if(mouseX > width/2+headerHeight/2 && mouseY > credsBaseline + afterCreds*5+headerHeight/2 &&
       mouseX < width/2+headerHeight/2 + headerHeight/2 && mouseY < credsBaseline + afterCreds*5+headerHeight/2 + headerHeight/2){
        frameSpinnerMouseDownPos = true;
        //this.drawFrameSpinner();
       }else{
        frameSpinnerMouseDownPos = false;
       }
        return frameSpinnerMouseDownPos;
    }
  
  }//End Methods////////////////////////////////////////////////////////////////////////////
//}//End Header Class
class PickColor{
// Note functional yet
  //Fields 
  //float xLocB;
  //float yLocB;
  float sizeB;
  int bomvana, mnyama, mhlophe, reflection, 
  green, bomvu, lubhelu, luhlaza, ntsundu, orenji, 
  ngwevu, mfusa, ngqombela, zulu;
  int[] colorList = {
  mnyama = color(0), //black - s
  reflection = color(240), //f
  zulu = color(3, 255, 236), //azure z
  luhlaza = color(4, 2, 124), //blue/green l
  green=color(2, 175, 9), 
  lubhelu = color(213, 229, 0), //yellow -y
  orenji = color(255, 159, 3), //orange o
  bomvu = color(234, 2, 22), //red -r
  bomvana = color(255, 134, 241), //pink - a 
  mfusa = color(185, 0, 147), //purple m
  ngqombela = color(255, 3, 155), //crimson c
  ntsundu = color(142, 84, 21), //brown n
  ngwevu  = color(227), //grey g
  mhlophe = color(255), //white -d
  };
  
  int returnedColor;
  
//  Constructor

  PickColor(float tempSizeB){
    //xLocB = tempxLocB;
    //yLocB = tempyLocB;
    sizeB = tempSizeB;
  }
  
  public void drawPickColor(){
    for(int i = 0; i < colorList.length; i++){
      fill(colorList[i]);
      rect((width/colorList.length)*i, height-(BeadSize+sizeB), sizeB, sizeB);
      //return colorList;
    }
  }
  
  public int activateColor(){
   for(int i=0; i < colorList.length; i++){ 
    if(mouseX > (width/colorList.length)*i && mouseY > height-(BeadSize+sizeB)
    && mouseX < ((width/colorList.length)*i) + sizeB && mouseY < height-BeadSize){
      returnedColor = colorList[i];
    }
   }
   println(returnedColor);
   return returnedColor;
  }
  
  public void renderHex(int tempActiveColor){
    fill(235);
    rect(width/2-textWidth("00000"), height-(BeadSize+sizeB)-(textAscent()+textDescent()), textWidth("0000000000"), textAscent()+textDescent());
    fill(100);
    text("#"+(hex(tempActiveColor)), width/2, height-(BeadSize+sizeB)-mainHeader.boarder);
  }
  
}

  public int sketchWidth() { return displayWidth; }
  public int sketchHeight() { return displayHeight; }
}
