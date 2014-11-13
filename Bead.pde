class Bead{

  //Fields 
  color cB;
  float xLocB;
  float yLocB;
  float widthB;
  float heightB;
  boolean beadDown;
  
//  Constructor

  Bead(color tempcB, float tempxLocB, float tempyLocB, float tempWidthB, float tempHeightB){
    cB = tempcB;
    xLocB = tempxLocB;
    yLocB = tempyLocB;
    widthB = tempWidthB;
    heightB = tempHeightB; 
  }
  
  void drawBead(){
  rect(xLocB, yLocB, widthB, heightB);
  }
  
}
