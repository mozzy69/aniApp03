class Header{
  
  int headerHeight;
  int headerSansShad;
  PImage HeaderShadow;
  PImage Logo;
  PFont  HeaderFont;
  PFont creditFont;
  PFont interfaceFont;
  int boarder;
  boolean mouseColRowSliderPos;
  float mapColRowSlider;
  int mappedColRowSlider;
  float afterCreds;
  float credsBaseline;
  
//  Constructor

  Header(int headerHeightTemp, String HeaderShadowTemp, String logoTemp){
    headerHeight = int((headerHeightTemp/100)*10);//headerHeightTemp is height
    HeaderShadow = loadImage(HeaderShadowTemp);
    Logo = loadImage(logoTemp);
    headerSansShad = this.headerHeight - this.HeaderShadow.height;
    boarder = 5;
    //please revise these changes ->
    //creditFont = createFont("BPdotsUnicaseSquare.otf", this.headerSansShad/2 );
    //textFont(creditFont);
    credsBaseline = height/4 + (textAscent()+textDescent())*8;
    //6 is the number of elements to include line, col row text, 
    //col row number, slider, frame text, spinner
    afterCreds = (height - credsBaseline)/8;
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
    HeaderFont = createFont("3Dumb.ttf", (this.headerSansShad/2)-boarder );
    textFont(HeaderFont);
    fill(100);
    textAlign(CENTER);
    text("CREATIVE CODE", width/2, this.headerSansShad/2 - this.boarder);//-5 removes the shadow/border area around logo 
    text("MOBILE ANIMATOR", width/2, this.headerSansShad - this.boarder);  
  }
  
//Draw the hamburger button//////////////////////////////////////////////////  
  void drawHamBurger(){
    fill(255);
    rect(width - this.headerSansShad, boarder/2, this.headerSansShad - boarder, this.headerSansShad - boarder, this.boarder);
    fill(200);
    //Hamburger Graphic///////
    noStroke();
    rect(width - this.headerSansShad + boarder*0.5, this.headerSansShad - boarder *4, 
        this.headerSansShad - boarder *2, boarder *3, boarder); 
    rect(width - this.headerSansShad + boarder*0.5, ((boarder/2 + this.headerSansShad - boarder)/2)-boarder , 
        this.headerSansShad - boarder *2, boarder * 3, boarder);    
    rect(width - this.headerSansShad + boarder*0.5, boarder, 
        this.headerSansShad - boarder *2, boarder * 3, boarder);    
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
    this.drawHeaderCreds();
    this.drawColRowSlider();
    this.drawFrameSpinner();
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
          appState = "draw";
          //Initialize = true;
        }
  }
 //////////////////////////////////////////////////////////////////////////////////////// 
  
  //Draw Header Credits
  void drawHeaderCreds(){
    appState = "header";  
    textAlign(CENTER);
    fill(50);
    text("Creative Code", width/2, height/4);
    text("Mobile Animator", width/2, height/4 + textAscent()+textDescent());
  
    creditFont = createFont("BPdotsUnicaseSquare.otf", this.headerSansShad/2 );
    textFont(creditFont);
    text("By Lyndon Daniels", width/2, height/4 + (textAscent()+textDescent())*4);
    textSize((this.headerSansShad/2)/1.5);
    text("Based on \nMarion Walton's Animator App", width/2, height/4 + (textAscent()+textDescent())*8);
  }
  
  
  void drawColRowSlider(){
    //line to seperate creds from interface controls
    stroke(15);
    line(BeadSize, credsBaseline + afterCreds, width-BeadSize, credsBaseline + afterCreds);  
    interfaceFont = createFont("Amble-Regular.ttf", this.headerSansShad/2);
    textFont(interfaceFont);
    text("Columns and Rows", width/2, credsBaseline + afterCreds*2);
    text(this.mappedColRowSlider, width/2, credsBaseline + afterCreds*3);
    rect(BeadSize, credsBaseline + afterCreds*4, width-BeadSize*2, BeadSize, boarder );
    fill(100);
    rect(BeadSize, credsBaseline + afterCreds*4, BeadSize, BeadSize, boarder);
  }
  
  boolean mouseColRowSlider(){
    if (mouseX > BeadSize && mouseY > credsBaseline + afterCreds*4
    && mouseX < width - BeadSize*2 && mouseY < credsBaseline + afterCreds*4 + BeadSize){
      mouseColRowSliderPos = true;
    }else{
      mouseColRowSliderPos = false;
    }
    return mouseColRowSliderPos;
  }
  
  void moveColRowSlider(){
    fill(100);
    rect(mouseX, credsBaseline + afterCreds*4, BeadSize, BeadSize, boarder);
    mapColRowSlider = mouseX;
    mappedColRowSlider = int(map(this.mapColRowSlider, BeadSize, width-BeadSize*2, 2, 51));
  }
  
  void drawFrameSpinner(){
    fill(200);
    rect(width/2-50, credsBaseline + afterCreds*5, 100, 100, boarder); 
  }
  
  
//End Methods////////////////////////////////////////////////////////////////////////////
}//End Header Class
