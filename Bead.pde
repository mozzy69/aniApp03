class Bead{

  //Fields 
  float xLocB;
  float yLocB;
  float sizeB;
  boolean beadDown;
  
//  Constructor

  Bead(float tempxLocB, float tempyLocB, float tempSizeB){
    xLocB = tempxLocB;
    yLocB = tempyLocB;
    sizeB = tempSizeB;
  }
  
  void drawBead(color beadColor){
    fill(beadColor);
    rect(xLocB + BeadSize, yLocB + HeaderHeight, sizeB, sizeB);
  }
  
}
