class Controls{

  //Fields 
  String controlType;
  
  //Constructor

  Controls(String tempControlType){
    controlType = tempControlType;
  }
  
  //Methods
  void drawForwardControl(int HeaderHeightTemp){
    fill(125);
    rect(BeadSize*(Columns+1)-(BeadSize*Columns)/3, HeaderHeightTemp+BeadSize+(Rows*BeadSize), 
    (BeadSize*Columns)/3, HeaderHeightTemp);
  }
  
  void drawBackwardControl(int HeaderHeightTemp){
    fill(125);
    rect(BeadSize, HeaderHeightTemp+BeadSize+(Rows*BeadSize), 
    (BeadSize*Columns)/3, HeaderHeightTemp);
  }
  
  void drawPlayControl(){
  //Nothing yet
  }
  
  void drawHamburgerControl(){
  //Nothing Yet
  }
  
  void changeFrame(Frame[] tempFrame, int HeaderHeightTemp){
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
