class Bead{

  //Fields 
  color cB;
  float xLocB;
  float yLocB;
  float sizeB;
  boolean beadDown;
  
//  Constructor

  Bead(color tempcB, float tempxLocB, float tempyLocB, float tempSizeB){
    cB = tempcB;
    xLocB = tempxLocB;
    yLocB = tempyLocB;
    sizeB = tempSizeB;
  }
  
  void drawBead(){
  rect(xLocB + BeadSize, yLocB, sizeB, sizeB);
  }
  
}
