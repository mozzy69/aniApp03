class PickColor{
// Note functional yet
  //Fields 
  //float xLocB;
  //float yLocB;
  float sizeB;
  color bomvana, mnyama, mhlophe, reflection, 
  green, bomvu, lubhelu, luhlaza, ntsundu, orenji, 
  ngwevu, mfusa, ngqombela, zulu;
  color[] colorList = {
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
  
  color returnedColor;
  
//  Constructor

  PickColor(float tempSizeB){
    //xLocB = tempxLocB;
    //yLocB = tempyLocB;
    sizeB = tempSizeB;
  }
  
  void drawPickColor(){
    for(int i = 0; i < colorList.length; i++){
      fill(colorList[i]);
      rect((width/colorList.length)*i, height-(BeadSize+sizeB), sizeB, sizeB);
      //return colorList;
    }
  }
  
  color activateColor(){
   for(int i=0; i < colorList.length; i++){ 
    if(mouseX > (width/colorList.length)*i && mouseY > height-(BeadSize+sizeB)
    && mouseX < ((width/colorList.length)*i) + sizeB && mouseY < height-BeadSize){
      returnedColor = colorList[i];
    }
   }
   println(returnedColor);
   return returnedColor;
  }
  
  void renderHex(color tempActiveColor){
    fill(235);
    rect(width/2-textWidth("00000"), height-(BeadSize+sizeB)-(textAscent()+textDescent()), textWidth("0000000000"), textAscent()+textDescent());
    fill(100);
    text("#"+(hex(tempActiveColor)), width/2, height-(BeadSize+sizeB)-mainHeader.boarder);
  }
  
}
