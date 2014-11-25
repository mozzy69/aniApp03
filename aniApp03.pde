//comments ending in ** are temps
//Globals
Frame[] mainFrame;
Header myHeader;
PickColor colorPicker;
//See BeadSize in setup()**
int BeadSize;
int Columns;
int Rows;
//columns and rows total accessible from main**
int TotalColRow;
//Title of app**
int HeaderHeight;
//Set to draw grid at the beginning then set to false in drawFrame method**
boolean Initialize;
//Detect orientation use this for layout 
boolean VertOrient;
//Frame Index number of frame currently being accessed eg drawn to screen
int FmIndex;

PImage HeaderShadow;
PImage Logo;

PFont HeaderFont;


/*Currently the method for drawing to the frame is needed to be addressed
the values for each beads color are being stored in Frame.storeBeadColor() 
a color picker needs to be implemented
beads need to be redrawn to the screen with the correct colors
drawFrame method in draw() was changed to return a color
this can be changed back to original, which without the returned data will draw
to the canvas as expected*/

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
  Columns = 3;
  Rows = 3;
  
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
  HeaderFont = createFont("BPdotsUnicase.otf", HeaderSansShad/2 );
  textFont(HeaderFont);
  fill(100);
  text("Creative Code", HeaderSansShad, HeaderSansShad/2 -5);//-5 removes the shadow/border area around logo 
  text("Animator App", HeaderSansShad, HeaderSansShad - 5);
  
  //Setup Frames will be through interface have a setup button or hamburger button in header for this
  //here for illustrative purposes
  mainFrame = new Frame[4];
  mainFrame[0] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[1] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[2] = new Frame(Rows, Columns, TotalColRow);
  mainFrame[3] = new Frame(Rows, Columns, TotalColRow);
  
  colorPicker = new PickColor(BeadSize, height-50, (BeadSize*Columns)/14);
  colorPicker.drawPickColor();
  
  
  
  //Temp Setup for buttons forwards and backward
   rect(BeadSize, HeaderHeight+BeadSize+(Rows*BeadSize), 
 (BeadSize*Columns)/3, (height-(BeadSize*Rows)+HeaderHeight)/3);
 
 rect(BeadSize*(Columns+1)-(BeadSize*Columns)/3, HeaderHeight+BeadSize+(Rows*BeadSize), 
 (BeadSize*Columns)/3, (height-(BeadSize*Rows)+HeaderHeight)/3);
 
 //More temp setup to initialize beads
  for(int i = 0; i < TotalColRow; i++){
    mainFrame[FmIndex].drawFrame(mainFrame[FmIndex].storeBeadColor[i]);
  }
}

//------------------------------------------------------------------------------------//

void draw(){
  
 
  //drawFrame returns an array of color values
  //remove from array and remove return data type and color argument eg
  //mainFrame[FmIndex].drawFrame() // to revert to original
 
  /*
  if(mouseX>0 && mouseX<width/4){
    mainFrame[0].drawFrame();
    println("left");
  }else if(mouseX<width&& mouseX>width/2){
    mainFrame[1].drawFrame();
    println("right");
  }
 */ 
 //two temp buttons at the bottom of the window
 // these buttons need to move to the controls objects to be made

}

void mouseReleased(){
  //This is a debug to test the forward and previous buttons below the canvas
  //FmIndex will cause the program to crash if it exceeds mainFrame[] element access
  //move this out of main
  if(mouseX > BeadSize*(Columns+1)-(BeadSize*Columns)/3 &&
  mouseX < BeadSize*(Columns+1) && mouseY > HeaderHeight+BeadSize+(Rows*BeadSize) && 
  mouseY < HeaderHeight+BeadSize+(Rows*BeadSize)+(height-(BeadSize*Rows)+HeaderHeight)/3){
    if(FmIndex < mainFrame.length-1){
      println("computers");
      FmIndex++;
      println(FmIndex);
      for(int i = 0; i < TotalColRow; i ++){
        //this looks redundant pls check 
        mainFrame[FmIndex].fmDrawBead(mainFrame[FmIndex].storeBeadColor[i]);
        println(mainFrame[FmIndex].storeBeadColor[i]); 
      }
    }
  }else if(mouseX > BeadSize && mouseX < BeadSize + (BeadSize*Columns)/3 &&
  mouseY > HeaderHeight+BeadSize+(Rows*BeadSize) && 
   mouseY < HeaderHeight+BeadSize+(Rows*BeadSize)+(height-(BeadSize*Rows)+HeaderHeight)/3){
    if(FmIndex > 0){
      println("more compies");
      FmIndex--;
      println(FmIndex); 
      for(int i = 0; i < TotalColRow; i ++){
        mainFrame[FmIndex].fmDrawBead(mainFrame[FmIndex].storeBeadColor[i]);
        println(mainFrame[FmIndex].storeBeadColor[i]);
      }
    }
   }
}

void mousePressed(){
//  for(int i = 0; i < TotalColRow; i++){
// mainFrame[FmIndex].drawFrame(mainFrame[FmIndex].storeBeadColor[i]);
  if(mouseX > BeadSize && mouseY > HeaderHeight + BeadSize && mouseX < BeadSize * (Columns+1) && mouseY < HeaderHeight + BeadSize * (Rows+1)){
   mainFrame[FmIndex].drawFrame(color(234,125,12));//Pass bead color from color picker to here
  }
//  }
}


void mouseDragged(){
//  for(int i = 0; i < TotalColRow; i++){
// mainFrame[FmIndex].drawFrame(mainFrame[FmIndex].storeBeadColor[i]);
if(mouseX > BeadSize && mouseY > HeaderHeight + BeadSize && mouseX < BeadSize * (Columns+1) && mouseY < HeaderHeight + BeadSize * (Rows+1)){
 mainFrame[FmIndex].drawFrame(color(234,125,12));//Pass bead color from color picker to here
}//DRY see void mousePressed()
//  }
}

