class Controls{

  //Fields 
  String controlType;
  
  //Constructor

  Controls(String tempControlType){
    controlType = tempControlType;
  }
  
  //Methods
  void drawForwardControl(){
    fill(125);
    rect(BeadSize*(Columns+1)-(BeadSize*Columns)/3, HeaderHeight+BeadSize+(Rows*BeadSize), 
    (BeadSize*Columns)/3, HeaderHeight);
  }
  
  void drawBackwardControl(){
    fill(125);
    rect(BeadSize, HeaderHeight+BeadSize+(Rows*BeadSize), 
    (BeadSize*Columns)/3, HeaderHeight);
  }
  
  void drawPlayControl(){
  //Nothing yet
  }
  
  void drawHamburgerControl(){
  //Nothing Yet
  }
  
  void changeFrame(Frame[] tempFrame){
   if(mouseX > BeadSize*(Columns+1)-(BeadSize*Columns)/3 &&
  mouseX < BeadSize*(Columns+1) && mouseY > HeaderHeight+BeadSize+(Rows*BeadSize) && 
  mouseY < HeaderHeight+BeadSize+(Rows*BeadSize)+HeaderHeight){
    if(FmIndex < tempFrame.length-1){
      FmIndex++;
      println("this is index " + FmIndex);
      for(int i = 0; i < TotalColRow; i++){
        //this looks redundant pls check 
        tempFrame[FmIndex].fmDrawBead();
        println(tempFrame[FmIndex].storeBeadColor[i]); 
      }
    }
  }else if(mouseX > BeadSize && mouseX < BeadSize + (BeadSize*Columns)/3 &&
  mouseY > HeaderHeight+BeadSize+(Rows*BeadSize) && 
   mouseY < HeaderHeight+BeadSize+(Rows*BeadSize)+HeaderHeight){
    if(FmIndex > 0){
      FmIndex--;
      println("this is index " + FmIndex); 
      for(int i = 0; i < TotalColRow; i ++){
        tempFrame[FmIndex].fmDrawBead();
        println(tempFrame[FmIndex].storeBeadColor[i]);
      }
    }
   }
  }
}
