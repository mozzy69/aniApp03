class Frame{

  //Fields
  Bead[] fmBeads;
  int fmRows;
  int fmCols;
  int totalBeads;
  color beadColorFm;
  color[] storeBeadColor;
  
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
  color[] drawFrame(color beadColorFmNew){
  for(int i = 0; i < totalBeads; i++){
      if(mousePressed && 
      mouseX > fmBeads[i].xLocB + BeadSize && 
      mouseX < fmBeads[i].xLocB + BeadSize + fmBeads[i].sizeB && 
      mouseY > fmBeads[i].yLocB + BeadSize + HeaderHeight && 
      mouseY < fmBeads[i].yLocB + BeadSize + HeaderHeight + fmBeads[i].sizeB){
        beadColorFm = beadColorFmNew;
        storeBeadColor[i] = fmBeads[i].drawBead(beadColorFm);
      }else if(Initialize){
        beadColorFm = beadColorFmNew;        
        // fmBeads[i].drawBead(beadColorFm);
        storeBeadColor[i] = fmBeads[i].drawBead(beadColorFm);
      }//End conditional
   }//End loop
   Initialize = false;
   return storeBeadColor;
  }//End drawFrame()
  
  void fmDrawBead(color beadColorFmNew){
    for(int i = 0; i < totalBeads; i++){
      fmBeads[i].drawBead(beadColorFmNew);
    }
  }
  
}//End Frame class definition/////////////////////////////////////////////////////////////////
