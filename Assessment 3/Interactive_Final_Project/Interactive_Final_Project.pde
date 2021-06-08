// Assignment 3: Interactive Final Project 

import processing.sound.*;

// Key Press for Sound/Track Change 

// Slider for the Volume of the Music

WaterSystem ws;
WaterDrop w;

PFont font;

PImage img1, img2, img3, img4;

float rectBaseX, rectBaseY, rectBaseW, rectBaseH;
float arcBaseX, arcBaseY, arcBaseW, arcBaseH;
float column1_x, column1_y, column1_w, column1_h;
float bowl1_x, bowl1_y, bowl1_w, bowl1_h;
float column2_x, column2_y, column2_w, column2_h;

// Light Button Parameters 
color buttonColour;
color pressedColour;
color light1Colour; 
color light2Colour;
color light3Colour;
color lightRColour;

// Fountain Colours
color FountainColour;
color fountainColourD, fountainColourN;

// Other Colours 
color sparklerColour;
color musicTitleColour, musicTitleDColour, musicTitleNColour;
int circleWidth, circleHeight; // Size of play button 
color backgroundColour, background1Colour, background2Colour;

int opacity;

float cir_X, cir_Y; // circle position 
boolean circleOver = false;
boolean playOver = false;
boolean notRainbow = true;
boolean sparklerOn = false;
boolean YellowSpark = false;
boolean textDisplayed = false;
boolean playPressed = false;
boolean buttonPressed = false;

// Sound Files/Parameters
SoundFile fountainSound;
SoundFile music1;
SoundFile music2;
SoundFile music3;

Scrollbar slider;
float mappedSlider;

void setup() {
  
  size(900,800);
  background(#C9EAED);
  
  // Text 
  font = createFont("Arial", 28);
  textFont(font);
  
  println("Inspiration: Simple Particle System by Daniel Shiffman");
  println("This is used to get the water flow for the fountain");
  println("Inspiration: Smoke Particle System by Daniel Shiffman");
  println("This is used to control the water flow, however no arrow at the top");
  println("Image for Sparkle by Nikki Samaras");
  //println();
  
  img1 = loadImage("White Sparkle.png");
  img2 = loadImage("Yellow Sparkle.png");
  img3 = loadImage("Play_Button1.png");
  img4 = loadImage("Play_Button2.png");
  
  slider = new Scrollbar(width/2, height/1.12+50, 400, 30, 16);
  
  // Sound Setup
  fountainSound = new SoundFile(this, "/fountainSound.wav");
  music1 = new SoundFile(this, "/Music1.wav");
  music2 = new SoundFile(this, "/Music2.wav");
  music3 = new SoundFile(this, "/Music3.wav");
  fountainSound.loop();
  
  ws = new WaterSystem(0, new PVector(width/2-20, 240));

  FountainColour = color(#FAEDED); 
  fountainColourD = color(#FAEDED); 
  fountainColourN = color(#C4BEBE);
  sparklerColour = color(#FCF7C9);

  buttonColour = color(#F03C3C);
  pressedColour = color(#585555);

  light1Colour = color(255, 255, 255); 
  light2Colour = color(0, random(255), random(10,255));
  light3Colour = color(random(10,255), 0, random(255));
  
  musicTitleDColour = color(0);
  musicTitleNColour = color(255, 255, 255);
  
  backgroundColour = color(#C9EAED);
  background1Colour = color(#C9EAED);
  background2Colour = color(#454D4D);
  
  //opacity = 200;

  // Fountain Parameters
  rectBaseX = width/5;
  rectBaseY = height/1.3;
  rectBaseW = width/1.8;
  rectBaseH = height/9;

  arcBaseX = rectBaseX + 250;
  arcBaseY = rectBaseY - 50;
  arcBaseW = rectBaseW + 50;
  arcBaseH = height/8 * 1.5;

  column1_x = rectBaseX*2.2;
  column1_y = rectBaseY/1.3;
  column1_w = rectBaseH/1.5;
  column1_h = rectBaseW/3;

  bowl1_x = column1_x+30;
  bowl1_y = column1_y-60;
  bowl1_w = rectBaseW/1.2;
  bowl1_h = rectBaseH*1.7;

  column2_x = column1_x+7.5;
  column2_y = column1_y-170;
  column2_w = rectBaseH/2;
  column2_h = column1_h;

  // Button Sizing 
  circleWidth = width/13; 
  circleHeight = height/12;
  cir_X = width/1.1+10; 
  cir_Y = height/8-10; 
  
}

// Toggle Button for Lights also change background colour to dim 
void drawLightButton() {
  update(mouseX, mouseY);
  noStroke();
  fill(buttonColour);
  ellipse(cir_X, cir_Y, circleWidth, circleHeight);
}

// Function for button being pressed
void mousePressed() {
  
  if (circleOver && buttonColour == #F03C3C && buttonPressed == false) {
    buttonColour = pressedColour;
    backgroundColour = background2Colour;
    background(backgroundColour);
    FountainColour = fountainColourN;
    musicTitleColour = musicTitleNColour;
    buttonPressed = true;
  }
  else if (circleOver && buttonColour == pressedColour && buttonPressed){
    buttonColour = #F03C3C;
    backgroundColour = background1Colour;
    background(backgroundColour);
    FountainColour = fountainColourD;
    musicTitleColour = musicTitleDColour;
    buttonPressed = false;
  }
  
  else if (playOver && !music1.isPlaying() && !music2.isPlaying()) {
    //image(img4, cir_X-40, cir_Y+55);
    music1.loop();
    playPressed = true;
  }
  else if (music2.isPlaying() && playPressed && playOver) {
    music2.stop();
    music1.stop();
  }
  else if (playOver){
    //image(img3, cir_X-40, cir_Y+55);
    music1.stop();
    music2.stop();
    playPressed = false;
  }

}

void mouseDragged() {
  //filter(POSTERIZE, 6);
 //ws = new WaterSystem(new PVector(mouseX, mouseY)); 
 
 if (backgroundColour == background2Colour && sparklerOn == false) {
   //fill(sparklerColour, 50);
   //ellipse(mouseX, mouseY, 10, 15);
   sparklerOn = true;
 }
}

void mouseReleased() {
  //ws = new WaterSystem(new PVector(width/2-20, 250));
  if (backgroundColour == background2Colour && sparklerOn) {
    background(#454D4D);
    sparklerOn = false;
  }
}

// Function for Key Pressed to change the colour of the lights 
void keyPressed() {
  
  if ((key == 'a')){
    light1Colour = light2Colour;
    notRainbow = false;
  }
  
  if ((key == 'b')) {
    light1Colour = light3Colour;
    notRainbow = false;
  }
  
  if ((key == 'c')) {
    light1Colour = color(255, 255, 255);
    notRainbow = false;
  }
  if ((key == 'r')) {
    notRainbow = true;
  }
  
  if (key == 'w'){
    YellowSpark = false;
    sparkEffect();
  }
  
  if (key == 'y'){
    YellowSpark = true;
    sparkEffect();
  }
  if (key == '1'){
    music2.stop();
    music1.loop();
    
  }
  if (key == '2' && music1.isPlaying()){
    music1.stop();
    music2.loop();
    
  }
}

// Updating the pixels for when the cursor is on/off button
void update(int x, int y) {
  if ( overCircle(cir_X, cir_Y, circleWidth) ) {
    circleOver = true;
    playOver = false;
  } else if (overPlayBtn(cir_X-40, cir_Y+55, 70, 70)){
    circleOver = false;
    playOver = true;
  }
  else {
    circleOver = playOver = false;
  }
  
}

boolean overPlayBtn(float x, float y, float width, float height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

// Boolean Function 
boolean overCircle(float x, float y, float diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

void draw() {
  
  // Foot Path
  drawFootPath();
  
  // Slider 
  sliderVolume();
  
  //println(mappedSlider);
  
  // Play Button 
  drawPlayButton();
  
  // Fountain
  drawFountain();
  
  // Water Flow
  //if (mouseX > 100 && mouseX < 800) {
    float dx = map(mouseX, 0, width, -0.04, 0.04);
    PVector wind = new PVector(dx, 0.05);
    ws.applyForce(wind);
  //ws.addWaterDrops();
    ws.run();
    for (int i = 0; i < 2; i++) {
      ws.addWaterDrops();
    }
   
  // Light Button
  drawLightButton();
  
  // Sparklers
  sparkEffect();
  
  // Add the Lights
  drawLights();
  
  
  // Music Title
  MusicLabel();
  
}
 
void drawPlayButton(){
  //update(mouseX, mouseY);
  if (!music1.isPlaying() && !music2.isPlaying()) {
    image(img3, cir_X-40, cir_Y+55);
    //music1.loop();
  }
  else if (playPressed && music1.isPlaying()){
    image(img4, cir_X-40, cir_Y+55);
    //music1.stop();
  }
  else if (music2.isPlaying()){
    image(img4, cir_X-40, cir_Y+55);
    //music1.stop();
  }
  else if (music2.isPlaying()) {
    image(img4, cir_X-40, cir_Y+55);
  }
}


void MusicLabel() {
  textAlign(LEFT);
  fill(musicTitleColour);
  text("Track 1: Music Box", 10, 50);
  text("Track 2: Dramatic Symphony", 10, 90);
  
  if (music1.isPlaying()) {
    //text("Track 1: Music Box", 10, 50);
    textDisplayed = true;
    triangle(270, 35, 260, 40, 270, 45); 
  }
  else if (music2.isPlaying() && !music1.isPlaying()) {
    //text("Track 2: Drama", 10, 50);
    textDisplayed = true;
    triangle(390, 80, 380, 85, 390, 90); 
  }
  else if (textDisplayed){
    background(backgroundColour);
    text("", 10, 50);
    textDisplayed = false;
  } 
  else {
   text("", 10, 50);
    textDisplayed = false; 
  }

}

// Scrollbar class
class Scrollbar {
  int sWidth, sHeight;             // width & height of the bar
  float sliderX, sliderY;          // x & y position of the bar
  float sliderPos, sliderNewPos;   // x position of slider
  float sliderMin, sliderMax;      // min/max values of slider
  int loose;    // loose/heaviness
  boolean over; // is the mouse over the slider?
  boolean locked;
  float ratio;
  float mappedSlider;
  

  
  Scrollbar (float xp, float yp, int sw, int sh, int l) {
    sWidth = sw;
    sHeight = sh;
    int widthToHeight = sw - sh;
    ratio = (float)sw / (float)widthToHeight;
    sliderX = xp;
    sliderY = yp-sHeight/2;
    sliderPos = sliderX + sWidth/2 - sHeight/2;
    sliderNewPos = sliderPos;
    sliderMin = sliderX;
    sliderMax = sliderX + sWidth - sHeight;
    loose = l;
   

  }
  
  void update() {
    if (overEvent()) {
      over = true;
    } else {
      over = false;
    }
    if (mousePressed && over) {
      locked = true;
    }
    if (!mousePressed) {
      locked = false;
    }
    if (locked) {
      sliderNewPos = constrain(mouseX-sHeight/2, sliderMin, sliderMax);
    }
    if (abs(sliderNewPos - sliderPos) > 1) {
      sliderPos = sliderPos + (sliderNewPos - sliderPos)/loose;
    }
   mappedSlider = map(sliderPos, sliderMin, sliderMax, 0, 100);
  }
  
  float constrain(float val, float minVal, float maxVal) {
    return min(max(val, minVal), maxVal);
  }
  
  boolean overEvent() {
    if (mouseX > sliderX && mouseX < sliderX+sWidth &&
        mouseY > sliderY && mouseY < sliderY+sHeight) {
          //setupDrops();
        return true;
        }
    else {
      return false;
    }
  }
  
  void display() {
    noStroke();
    fill(#74DEC4);
    rect(sliderX, sliderY, sWidth, sHeight);
    if (over || locked) {
      fill(0);
    } else {
      fill(102, 102, 102);
    }
    rect(sliderPos, sliderY, sHeight, sHeight);
  }
  
  float getPos() {
    return sliderPos * ratio;
  }
};

void sliderVolume() {
  //slider.update();
  slider.display();
  if (!music1.isPlaying() && !music2.isPlaying()) {
    //mappedSlider = 50;
    
  }
  
  if (music1.isPlaying() && !music2.isPlaying()) {
    slider.update();
    mappedSlider = slider.sliderPos;
    float volume = map(mappedSlider, slider.sliderMin, slider.sliderMax, 0, 1);
    music1.amp(volume);
    
  }
  else if (!music1.isPlaying() && music2.isPlaying()) {
    slider.update();
    mappedSlider = slider.sliderPos;
    float volume = map(mappedSlider, slider.sliderMin, slider.sliderMax, 0, 1);
    music2.amp(volume);
  }
  
 //if (!music1.isPlaying() && music2.isPlaying()){
   //float sliderVolume = map(mappedSlider, );
 //}

}

void drawLights() {
  // Add/Draw Lights
  if (buttonColour == pressedColour && !notRainbow) {
    fill(light1Colour);
    // Top Row
    circle(bowl1_x*0.75, bowl1_y, 20);
    circle(bowl1_x, bowl1_y, 20);
    circle(bowl1_x*1.25, bowl1_y, 20);
  
    // Bottom Row
    circle(arcBaseX/2, arcBaseY, 20); // 0.5
    circle(arcBaseX*0.75, arcBaseY, 20); // 0.75
    circle(arcBaseX, arcBaseY, 20); // 1
    circle(arcBaseX*1.25, arcBaseY, 20); // 1.25
    circle(arcBaseX*1.5, arcBaseY, 20); // 1.5  
  }

  if (notRainbow && buttonColour == pressedColour) {
    lightRColour = color(random(255), random(255), random(255));
    fill(lightRColour);
    // Top Row
    circle(bowl1_x*0.75, bowl1_y, 20);
    circle(bowl1_x, bowl1_y, 20);
    circle(bowl1_x*1.25, bowl1_y, 20);
  
    // Bottom Row
    circle(arcBaseX/2, arcBaseY, 20); // 0.5
    circle(arcBaseX*0.75, arcBaseY, 20); // 0.75
    circle(arcBaseX, arcBaseY, 20); // 1
    circle(arcBaseX*1.25, arcBaseY, 20); // 1.25
    circle(arcBaseX*1.5, arcBaseY, 20); // 1.5  
  }
}

void sparkEffect() {
    if (buttonColour == pressedColour && sparklerOn){
    //pushMatrix();
    //filter(BLUR, 1); 
    //translate(mouseX,mouseY);
    //fill(sparklerColour, opacity);
    //img.filter(BLUR, 1);
    //image(img1, mouseX, mouseY);
    //popMatrix();
    
    if (YellowSpark) {
      filter(BLUR, 1); 
      image(img2, mouseX, mouseY);
    }
    else {
      filter(BLUR,1);
      image(img1, mouseX, mouseY);
    }
  } 
}

void drawFootPath(){
  strokeWeight(1);
  stroke(0);
  fill(#677C86);
  rect(0, height*0.85, rectBaseW*1.8, rectBaseH*1.5);
  noFill();
  line(20, height*0.85, 20, height);
  line(120, height*0.85, 120, height);
  line(220, height*0.85, 220, height);
  line(320, height*0.85, 320, height);
  line(420, height*0.85, 420, height);
  line(520, height*0.85, 520, height);
  line(620, height*0.85, 620, height);
  line(720, height*0.85, 720, height);
  line(820, height*0.85, 820, height);
  line(920, height*0.85, 920, height);
  
  //point(width-10, height*0.85);
  
  beginShape(QUAD_STRIP);
  fill(#8698A0,100);
  vertex(0, height*0.85+30);
  vertex(900, height*0.85+30);
  vertex(0, height*0.85+60);
  vertex(900, height*0.85+60);
  vertex(0, height*0.85+90);
  vertex(900, height*0.85+90);
  endShape();
  
}

void drawFountain() {
  // Draw Unique Fountain Base
  stroke(0);
  strokeWeight(1);
  fill(FountainColour);

  // First Column
  rect(column1_x, column1_y, column1_w, column1_h);
  rect(column1_x-12, column1_y, column1_h/2, column1_w/2);

  // Base of the Fountain 
  arc(arcBaseX, arcBaseY, arcBaseW, arcBaseH, 0, PI, CHORD);
  strokeWeight(1.2);
  rect(rectBaseX, rectBaseY, rectBaseW, rectBaseH);

  // Second Column 
  strokeWeight(1);
  rect(column2_x, column2_y, column2_w, column2_h);
  
  // First Bowl 
  arc(bowl1_x, bowl1_y, bowl1_w, bowl1_h, 0, PI, CHORD); 

  // Testing Points  
  strokeWeight(4);
  //fill(0);
  //point(270, 35);
  //point(260, 40);
  //point(270, 45);
  // for Water Point 
  //point(column2_x+column2_w/2, column2_y-40);
  // for custom centre piece 
  //point(column2_x, column2_y+10); // 1
  //point(column2_x+column2_w, column2_y+10); // 2
  //point(column2_x-column2_w/2, column2_y-20); // 3
  //point(column2_x+column2_w*1.5, column2_y-20); // 4
  //point(column2_x-10, column2_y-40); // 5
  //point(column2_x+column2_w+10, column2_y-40); // 6

  // for lights 
  //point(arcBaseX/2, arcBaseY); // 0.5
  //point(arcBaseX*0.75, arcBaseY); // 0.75
  //point(arcBaseX, arcBaseY); // 1
  //point(arcBaseX*1.25, arcBaseY); // 1.25
  //point(arcBaseX*1.5, arcBaseY); // 1.5

  //point(bowl1_x*0.75, bowl1_y);
  //point(bowl1_x, bowl1_y);
  //point(bowl1_x*1.25, bowl1_y);

  // Centre Piece
  strokeWeight(1);
  beginShape();
  fill(FountainColour);
  // Connect 5 to 6 to 4 to 2 to 1 to 3 to 5
  vertex(column2_x-10, column2_y-40); // 5
  vertex(column2_x+column2_w+10, column2_y-40); // 6
  vertex(column2_x+column2_w*1.5, column2_y-20); // 4
  vertex(column2_x+column2_w, column2_y+10); // 2
  vertex(column2_x, column2_y+10); // 1
  vertex(column2_x-column2_w/2, column2_y-20); // 3
  endShape(CLOSE);
}
