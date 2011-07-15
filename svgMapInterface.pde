  import geomerative.*;

class svgMapInterface{

int x, y, width, height;
RShape mapShape;
PFont font;
PApplet parent;
String selectedCountry;
String mouseOverText;
float scaleFactor;

String [][] countries = {
  {"th","Thailand"},{"sa","Saudi Arabia"}, {"ve", "Venezuela"}, {"ir","Iran"}, {"lb", "Lebanon"},
 { "pk","Pakistan"}, {"ke", "Kenya"}, {"sy", "Syria"}, {"tr", "Turkey"}, {"ye", "Yemen"}, {"co", "Colombia"}};
  
svgMapInterface(PApplet parent, int x, int y, int width, int height){
  this.parent = parent;
  this.x = x;
  this.y = y;
  this.width = width;
  this.height = height;
  
  scaleFactor = width/900.0;
  
  RG.init(parent);
  RG.setPolygonizer(RG.ADAPTATIVE);
  mapShape = RG.loadShape("BlankMap-World6.svg");
  RG.ignoreStyles();
  mapShape = RG.centerIn(mapShape, g);
  mapShape.polygonize();
  font = createFont("MyriadWebPro", 22 * scaleFactor);
  //scale the shape here?
  mapShape.scale(scaleFactor, height/500.0);
}
  
void setup(){
  //size(900, 500, JAVA2D);
  //smooth();
 
}

void draw(){
  noFill();
  stroke(255);  
  strokeWeight(0.5);
  //actually draw it
  drawOcean();
  drawCountries();
  drawCountriesWithData();
  drawSelectedCountry();
  drawMouseOverText();
}

void drawCountriesWithData(){
  boolean drawText = false;

  RShape toDraw;
  RPoint p = new RPoint(mouseX - x - width/2, mouseY - y - height/2);
  for(int i = 0; i < countries.length; i++){
    fill(203,144,88);
    toDraw = mapShape.getChild(countries[i][0]);
    if(toDraw.contains(p)){
        fill(0xFFE01E00);
        drawText = true;
        mouseOverText = countries[i][1];
    }
    RG.shape(toDraw, x + width/2, y + height/2);     
  }
       //draw mouseover text if required
  if(!drawText){
    mouseOverText = null;
  }
}

void drawMouseOverText(){
  if(mouseOverText != null){
    fill(0);
    textFont(font, 22 * scaleFactor);
    textAlign(LEFT, BOTTOM);
    text(mouseOverText, mouseX, mouseY);
  }
}

boolean mouseOver(){
  return (mouseX > x && mouseX < (x+width) && mouseY > y && mouseY < (y+height));
}

void mouseClicked(){
  //select a country if we're over one
    RShape toDraw;
   RPoint p = new RPoint(mouseX - x - width/2, mouseY - y - height/2);
  for(int i = 0; i < countries.length; i++){
    toDraw = mapShape.getChild(countries[i][0]);
    if(toDraw.contains(p)){
      selectedCountry = toDraw.name;
    }
  }
}

void drawSelectedCountry(){
 RShape toDraw = mapShape.getChild(selectedCountry);
 if(toDraw != null){
 fill(0xFF3D00C4);
 RG.shape(toDraw, x + width/2, y + height/2);   
 }
 //also draw name?
 
}

void drawOcean(){
  RShape toDraw = mapShape.getChild("ocean");
  fill(0xffb3e6ef);
  stroke(0);
  strokeWeight(2);
    RG.shape(toDraw, x + width/2, y + height/2);   
}

void drawCountries(){
  RShape toDraw;
  for(int i = 0; i < mapShape.children.length; i++){
    stroke(255);
    strokeWeight(0.5);
    fill(#DAC8B7);
    toDraw = mapShape.children[i];
    //no ocean!
    if(!toDraw.name.equals("ocean")){
        RG.shape(toDraw, x + width/2, y + height/2);   
    }
  }
}
}
