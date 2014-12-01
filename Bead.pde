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
  
  color drawBead(color beadColor, int HeaderHeightTemp){
    fill(beadColor);
    rect(xLocB + BeadSize, yLocB + BeadSize + HeaderHeightTemp, sizeB, sizeB);
    return beadColor;
  }
  
}
