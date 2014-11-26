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
    (BeadSize*Columns)/3, (height-(BeadSize*Rows)+HeaderHeight)/3);
  }
  
  void drawBackwardControl(){
    fill(125);
    rect(BeadSize, HeaderHeight+BeadSize+(Rows*BeadSize), 
    (BeadSize*Columns)/3, (height-(BeadSize*Rows)+HeaderHeight)/3);
  }
  
  void drawPlayControl(){
  //Nothing yet
  }
  
  void drawHamburgerControl(){
  //Nothing Yet
  }
  
  void changeFrame(){
   if(mouseX > BeadSize*(Columns+1)-(BeadSize*Columns)/3 &&
  mouseX < BeadSize*(Columns+1) && mouseY > HeaderHeight+BeadSize+(Rows*BeadSize) && 
  mouseY < HeaderHeight+BeadSize+(Rows*BeadSize)+(height-(BeadSize*Rows)+HeaderHeight)/3){
    if(FmIndex < mainFrame.length-1){
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
      FmIndex--;
      println(FmIndex); 
      for(int i = 0; i < TotalColRow; i ++){
        mainFrame[FmIndex].fmDrawBead(mainFrame[FmIndex].storeBeadColor[i]);
        println(mainFrame[FmIndex].storeBeadColor[i]);
      }
    }
   }
  }
}
