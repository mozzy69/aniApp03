class Frame{

  //   Fields
  Bead[] fmBeads;
  int fmRows;
  int fmCols;
  int totalBeads;
  
//  Constructor

  Frame(int tempFmRows, int tempFmCols, int tempTotalBeads){
    fmRows = tempFmRows;
    fmCols = tempFmCols;
    totalBeads = tempTotalBeads;
    fmBeads = new Bead[totalBeads];
    
    int index=0;
    for(int y = 0; y < fmRows; y++){
      for(int x = 0; x < fmCols; x++){
        fmBeads[index++] = new Bead(20,x*20,y*20,20,20);
      }
    }  
 
  }
  
  void drawFrame(){
  for(int i = 0; i < totalBeads; i++){
     fmBeads[i].drawBead();
   }
  }
  
}
