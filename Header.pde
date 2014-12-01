class Header{
  
  int headerHeight;
  int headerSansShad;
  PImage HeaderShadow;
  PImage Logo;
  PFont  HeaderFont;
  
//  Constructor

  Header(int headerHeightTemp, String HeaderShadowTemp, String logoTemp){
    headerHeight = int((headerHeightTemp/100)*10);
    HeaderShadow = loadImage(HeaderShadowTemp);
    Logo = loadImage(logoTemp);
    headerSansShad = this.headerHeight - this.HeaderShadow.height;
  }

//  int headerSansShad(int HeaderHeightTemp, PImage HeaderShadowTemp){
//     HeaderSansShadTemp = HeaderHeightTemp - HeaderShadowTemp.height;
//     return HeaderSansShadTemp;
//  }

  PImage drawHeaderShadow(int HeaderHeightTemp){
    //HeaderShadow = loadImage("HeadShadow.png");
    for(int i = 0; i < width; i++){
      image(HeaderShadow, i, HeaderHeightTemp - HeaderShadow.height);
    }
    return HeaderShadow;
  } 
  
  void drawLogo(int HeaderSansShadTemp){
    
    //Logo.resize(25, 0);
    image(Logo, 0, 0, HeaderSansShadTemp, HeaderSansShadTemp);
  }
   
  void drawHeaderText(int HeaderSansShadTemp){
    HeaderFont = createFont("3Dumb.ttf", HeaderSansShadTemp/2 );
    textFont(HeaderFont);
    fill(100);
    text("CREATIVE CODE", HeaderSansShadTemp, HeaderSansShadTemp/2 -5);//-5 removes the shadow/border area around logo 
    text("ANIMATOR APP", HeaderSansShadTemp, HeaderSansShadTemp - 5);  
  }

}
