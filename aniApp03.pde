Bead[] myBead;

void setup(){
  size(displayWidth, displayHeight);
  println(width + " " + height);
  int rows = 3;
  int cols = 4;
  myBead = new Bead[rows*cols];
  
  int index=0;
  for(int y = 0; y < 3; y++){
    for(int x = 0; x < 4; x++){
      myBead[index++] = new Bead(20,x*20,y*20,20,20);
    }
  }  
 
}

void draw(){
   /*rect(50, 50, 24, 24, 5, 4, 5, 3);
   rect(50+24, 50+24, 24, 24, 5, 4, 5, 3);*/
   for(int i = 0; i < 12; i++){
     myBead[i].drawBead();
   }
}
