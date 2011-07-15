svgMapInterface myMap;

void setup(){
  size(900, 500, JAVA2D);
  smooth();
  int mWidth = 900;
  int mHeight = 450;
  myMap = new svgMapInterface(this, width/2 - mWidth/2, height/2 - mHeight/2, mWidth, mHeight);
}

void draw(){
  myMap.draw();
}

void mouseClicked(){
  if(myMap.mouseOver()){
    myMap.mouseClicked();
  }
}




