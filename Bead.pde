class Bead{

  //Fields 
  float xLocB;
  float yLocB;
  float sizeB;
  //boolean beadDown;
  
//  Constructor

  Bead(float tempxLocB, float tempyLocB, float tempSizeB){
    xLocB = tempxLocB;
    yLocB = tempyLocB;
    sizeB = tempSizeB;
  }
  
  color drawBead(color beadColor){
    fill(beadColor);
    rect(xLocB + BeadSize, yLocB + BeadSize + HeaderHeight, sizeB, sizeB);
    return beadColor;
  }
  
}
