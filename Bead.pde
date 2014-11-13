class Bead{

  //   Fields 
// declare variables used in the Button class here
  color cB;
  float xLocB;
  float yLocB;
  float widthB;
  float heightB;
  //String nameB;
  //boolean myButtonOver;
  boolean myButtonPressed;
  
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
