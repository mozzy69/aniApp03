class Bead{

  //Fields 
  float xLocB;
  float yLocB;
  float sizeB;
  int tempBeadSize;
  boolean tempVertOrient;
  //boolean beadDown;
  
//  Constructor

  Bead(float tempxLocB, float tempyLocB, float tempSizeB){
    xLocB = tempxLocB;
    yLocB = tempyLocB;
    sizeB = tempSizeB;
  }
  
  
  //Methods//
  
  color drawBead(color beadColor, int HeaderHeightTemp){
    fill(beadColor);
    rect(xLocB + BeadSize, yLocB + BeadSize + HeaderHeightTemp, sizeB, sizeB);
    return beadColor;
  }
  
  int setBeadSize(int tempColumns, int tempRows){
   if (width<height){
      tempBeadSize = width/(tempColumns + 2);
    }else{
      tempBeadSize = height/(tempRows + 4);
    }
    return tempBeadSize;
  }
  
  boolean setOrient(){
   if (width<height){
      tempVertOrient = true;
    }else{
      tempVertOrient = false;
    }
    return tempVertOrient;  
   }
  
}
