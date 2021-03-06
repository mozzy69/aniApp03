class Frame{

  //Fields
  Bead[] fmBeads;
  int fmRows;
  int fmCols;
  int totalBeads;
  color beadColorFm;
  color[] storeBeadColor;
  boolean frameMousePos;
  
  //Constructor
  Frame(int tempFmRows, int tempFmCols, int tempTotalBeads){
    fmRows = tempFmRows;
    fmCols = tempFmCols;
    totalBeads = tempTotalBeads;
    fmBeads = new Bead[totalBeads];
    storeBeadColor = new color[totalBeads];
    
    int index=0;
    for(int y = 0; y < fmRows; y++){
      for(int x = 0; x < fmCols; x++){
        fmBeads[index++] = new Bead(x*BeadSize,y*BeadSize,BeadSize);
      }
    }  
 
  }
  
  //Methods
  //Main method for drawing a frame consisting of sets of beads
  color[] drawFrame(color beadColorFmNew, int HeaderHeightTemp){
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
  
  
    color[] drawFrameTrans(int HeaderHeightTemp){
  for(int i = 0; i < totalBeads; i++){
      if(headerState == "headerUp"){
        storeBeadColor[i] = fmBeads[i].drawBead(storeBeadColor[i], HeaderHeightTemp);
      }
   }//End loop
   noStroke();
   return storeBeadColor;
  }//End drawFrame()
  
  void fmDrawBead(int HeaderHeightTemp){
    for(int i = 0; i < totalBeads; i++){
      //beadColorFm = beadColorFmNew;
      fmBeads[i].drawBead(storeBeadColor[i], HeaderHeightTemp);
    }
  }
  
  boolean frameMouse(int headerHeightTemp){
     if(mouseX > BeadSize && mouseY > headerHeightTemp + BeadSize 
     && mouseX < BeadSize * (Columns+1) && mouseY < headerHeightTemp + BeadSize * (Rows+1)){
     frameMousePos = true;//Pass bead color from color picker to here
    }
    return frameMousePos;
  }
  
}//End Frame class definition/////////////////////////////////////////////////////////////////
