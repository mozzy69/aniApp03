class Frame{

  //Fields
  Bead[] fmBeads;
  int fmRows;
  int fmCols;
  int totalBeads;
  color beadColorFm;
  
  //Constructor
  Frame(int tempFmRows, int tempFmCols, int tempTotalBeads){
    fmRows = tempFmRows;
    fmCols = tempFmCols;
    totalBeads = tempTotalBeads;
    fmBeads = new Bead[totalBeads];
    
    int index=0;
    for(int y = 0; y < fmRows; y++){
      for(int x = 0; x < fmCols; x++){
        fmBeads[index++] = new Bead(x*BeadSize,y*BeadSize,BeadSize);
      }
    }  
 
  }
  
  //Methods
  void drawFrame(){
  for(int i = 0; i < totalBeads; i++){
      if(mousePressed && 
      mouseX > fmBeads[i].xLocB + BeadSize && 
      mouseX < fmBeads[i].xLocB + BeadSize + fmBeads[i].sizeB && 
      mouseY > fmBeads[i].yLocB + HeaderHeight && 
      mouseY < fmBeads[i].yLocB + HeaderHeight + fmBeads[i].sizeB){
        fill(10);
        println("something");
        beadColorFm = color(255, 0, 0);
        fmBeads[i].drawBead(beadColorFm);
      }        
      //fmBeads[i].drawBead(beadColorFm);
     // println(fmBeads[i].xLocB);
   }
  }
  
}
