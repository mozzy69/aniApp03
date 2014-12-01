class Header{
  
  int headerHeight;
  int headerSansShad;
  PImage HeaderShadow;
  PImage Logo;
  PFont  HeaderFont;
  int boarder;
  String headerMousePos;
  
//  Constructor

  Header(int headerHeightTemp, String HeaderShadowTemp, String logoTemp){
    headerHeight = int((headerHeightTemp/100)*10);//headerHeightTemp is height
    HeaderShadow = loadImage(HeaderShadowTemp);
    Logo = loadImage(logoTemp);
    headerSansShad = this.headerHeight - this.HeaderShadow.height;
    boarder = 5;
  }

//Methods

  PImage drawHeaderShadow(int HeaderHeightTemp){
    //HeaderShadow = loadImage("HeadShadow.png");
    for(int i = 0; i < width; i++){
      image(this.HeaderShadow, i, HeaderHeightTemp - this.HeaderShadow.height);
    }
    return HeaderShadow;
  } 
  
  void drawLogo(){
    image(Logo, 0, 0, this.headerSansShad, this.headerSansShad);
  }
   
  void drawHeaderText(){
    HeaderFont = createFont("3Dumb.ttf", this.headerSansShad/2 );
    textFont(HeaderFont);
    fill(100);
    text("CREATIVE CODE", this.headerSansShad, this.headerSansShad/2 - this.boarder);//-5 removes the shadow/border area around logo 
    text("ANIMATOR APP", this.headerSansShad, this.headerSansShad - this.boarder);  
  }
  
  void drawHamBurger(){
    fill(115);
    rect(width - this.headerSansShad, 0, this.headerSansShad, this.headerSansShad, this.boarder);
  }
  
  String headerMouse(){
    if(mouseX > 0 && mouseY > 0 && mouseX < this.headerSansShad && mouseY < this.headerSansShad){
      headerMousePos = "logo";
    }else if(mouseX > width - this.headerSansShad && mouseY > 0 && mouseX < width && mouseY < this.headerSansShad) {
      headerMousePos = "hamburger";
    }
    //println(headerMousePos);
    return headerMousePos;
  }

}
