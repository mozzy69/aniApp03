class Header{
  
  int headerHeight;
  int headerSansShad;
  PImage HeaderShadow;
  PImage Logo;
  PFont  HeaderFont;
  int boarder;
  
//  Constructor

  Header(int headerHeightTemp, String HeaderShadowTemp, String logoTemp){
    headerHeight = int((headerHeightTemp/100)*10);//headerHeightTemp is height
    HeaderShadow = loadImage(HeaderShadowTemp);
    Logo = loadImage(logoTemp);
    headerSansShad = this.headerHeight - this.HeaderShadow.height;
    boarder = 5;
  }

//Methods
//Draw The Header's Shadow////////////////////////////////////////////////////
  PImage drawHeaderShadow(int HeaderHeightTemp){
    //HeaderShadow = loadImage("HeadShadow.png");
    for(int i = 0; i < width; i++){
      image(this.HeaderShadow, i, HeaderHeightTemp - this.HeaderShadow.height);
    }
    return HeaderShadow;
  } 
  
//Draw the logo//////////////////////////////////////////////////////////////  
  void drawLogo(){
    image(Logo, 0, 0, this.headerSansShad, this.headerSansShad);
  }

//Render the text////////////////////////////////////////////////////////////   
  void drawHeaderText(){
    HeaderFont = createFont("3Dumb.ttf", this.headerSansShad/2 );
    textFont(HeaderFont);
    fill(100);
    text("CREATIVE CODE", this.headerSansShad, this.headerSansShad/2 - this.boarder);//-5 removes the shadow/border area around logo 
    text("ANIMATOR APP", this.headerSansShad, this.headerSansShad - this.boarder);  
  }
  
//Draw the hamburger button//////////////////////////////////////////////////  
  void drawHamBurger(){
    fill(115);
    rect(width - this.headerSansShad, 0, this.headerSansShad, this.headerSansShad, this.boarder);
  }
  
//Determine the position of the mouse over hamburger or logo/////////////////  
  String headerMouse(String tempAppState){
    if(mouseX > 0 && mouseY > 0 && mouseX < this.headerSansShad && mouseY < this.headerSansShad){
      if(tempAppState == "headerClose"){
        tempAppState = "headerDown";
      }else if (tempAppState == "headerOpen"){
        tempAppState = "headerUp";
      }
    }else if(mouseX > width - this.headerSansShad && mouseY > 0 && mouseX < width && mouseY < this.headerSansShad) {
      if(tempAppState == "headerClose"){
        tempAppState = "headerDown";
      }else if (tempAppState == "headerOpen"){
        tempAppState = "headerUp";
      }
    }
    return tempAppState;
  }
  
//Drop the header down (open it)/////////////////////////////////////////////  
  void animateHeaderOpen(int tempHeight){
    if (tempHeight < height - this.HeaderShadow.height){
      noStroke();
      fill(235);
      rect(0, this.headerHeight - this.HeaderShadow.height, width, tempHeight);
      for(int i = 0; i < width; i++){
        image(this.HeaderShadow, i, (this.headerHeight - this.HeaderShadow.height)+tempHeight);
      } 
      println(tempHeight);
    }else if (tempHeight >= height - this.HeaderShadow.height){
    tempHeight = height - this.HeaderShadow.height;
     rect(0, this.headerHeight - this.HeaderShadow.height, width, tempHeight - this.HeaderShadow.height);
      for(int i = 0; i < width; i++){
        image(this.HeaderShadow, i, height - this.HeaderShadow.height);
        } 
    headerState = "headerOpen";
    }
  }

//Raise the header up (close it)//////////////////////////////////////////////
    void animateHeaderClose(int tempHeight){
      if (tempHeight > this.headerHeight){
      noStroke();
      fill(235);
      rect(0, this.headerHeight - this.HeaderShadow.height, width, tempHeight);
      for(int i = 0; i < width; i++){
        image(this.HeaderShadow, i, height - tempHeight);
        }
        this.drawLogo();
        this.drawHeaderText();
        this.drawHamBurger();
        colorPicker.drawPickColor();
        println("hello spencer");
      }else if (tempHeight <= this.headerHeight){
          tempHeight = this.headerHeight;
          for(int i = 0; i < width; i++){
            image(this.HeaderShadow, i, tempHeight);
          }
          this.drawLogo();
          this.drawHeaderText();
          this.drawHamBurger();
          colorPicker.drawPickColor();
          headerState = "headerClose";
          //Initialize = true;
        }
  }
//End Methods////////////////////////////////////////////////////////////////////////////
}//End Header Class
