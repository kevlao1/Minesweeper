backgroundThing theBackground;
bottomSquareArray matrix2 = new bottomSquareArray(10, 10);
topSquare[][] matrixTop = new topSquare[10][10];
numberMaker[] mines = new numberMaker[3];
numberMaker[] timer = new numberMaker[3];
timeChecker clock;
public int facer, numFlagsLeft;
public boolean pressedIn;

void setup(){
 frameRate(60);
 size(750, 1000);
theBackground = new backgroundThing(); 
clock = new timeChecker(0);
for(int row = 0; row < 10; row++){
  for(int col = 0; col < 10; col++){
matrixTop[row][col] = new topSquare(col*70+25, row*70+275, 70);
matrixTop[row][col].show();
  }
}
facer = 0;
pressedIn = false;
numFlagsLeft = 10;
for(int i = 0; i < 3; i++){
mines[i] = new numberMaker(numFlagsLeft, 3-i, 30, 67+40*i, 180);
timer[i] = new numberMaker(0, 3-i, 30, 603+40*i, 180);
}
}

void draw(){
theBackground.show();
matrix2.squareDrawing();
clock.setNewNewTime(millis());
for(int i = 0; i < 3; i++){
mines[i].show();
timer[i].show();
if(numFlagsLeft >= 0) mines[i].modifyNum(numFlagsLeft);
if(clock.getTime() < 1000) timer[i].modifyNum(clock.getTime());
}
for(int row = 0; row < 10; row++){
  for(int col = 0; col < 10; col++){
if(matrixTop[row][col].getRemover() == false) matrixTop[row][col].show();
  }
  buttonMaker(facer, pressedIn);
}
theBackground.topTab();
}
  
class bottomSquareArray{
bottomSquare[][] matrix;
bottomSquareArray(int row, int col){
  matrix = new bottomSquare[row][col];
 for(int row2 = 0; row2 < row; row2++){
   for(int col2 = 0; col2 < col; col2++){
     matrix[row2][col2] = new bottomSquare(col2*70+25, row2*70+275, 70);
   }
 }
 reroll();
}

private void squareDrawing(){
 for(int row = 0; row < 10; row++){
   for(int col = 0; col < 10; col++){
  matrix[row][col].show(mineDetector(row, col));
   }
}
}

private void reroll(){
  for(int row = 0; row < 10; row++){
   for(int col = 0; col < 10; col++){
    matrix[row][col].setMined(false); 
   }
  }
  for(int roll = 0; roll < 10; roll++){
 int num1 = (int)(Math.random()*10);
 int num2 = (int)(Math.random()*10);
 if(matrix[num1][num2].getMined() == true){roll--;}
 else matrix[num1][num2].setMined(true);
 }
}

 private int mineDetector(int row, int col){
 int numMines = 0;
 for(int i = row-1; i < row+2; i++){
   for(int j = col-1; j < col+2; j++){
 if(rowChecker(i, j) == true){
  if(i == row && j == col){;}
  else if(matrix[i][j].getMined() == true){numMines++;}
 }
  }
 }
 return numMines;
}

public boolean rowChecker(int row, int col){
 if(row < 0 || row >= 10 || col < 0 || col >= 10){return false;}
 return true;
}

public boolean getMined(int row, int col){
if(rowChecker(row, col) == true){
 return matrix[row][col].getMined(); 
}
}

public boolean getExplodedIdiot(int row, int col){
if(rowChecker(row, col) == true){
 return matrix[row][col].getExplodedIdiot();
}
}
 
public void setExploded(int row, int col, boolean explosion){
if(rowChecker(row, col) == true){
matrix[row][col].setExploded(explosion); 
}
}
}  
  
class bottomSquare{
  protected int squareX, squareY, squareSize; 
  protected boolean mine, exploded;
  public int getSquareX(){return squareX;}
  public boolean getMined(){return mine;}
  public void setMined(boolean mined){mine = mined;}
  public boolean getExplodedIdiot(){return exploded;}
  public void setExploded(boolean explode){exploded = explode;}
 bottomSquare(){}
 bottomSquare(int x, int y, int size){
  squareX = x;
  squareY = y;
  squareSize = size;
  mine = false;
  exploded = false;
  }
  
 private void show(int mineNum){
 strokeWeight(2);
 stroke(133);
 fill(191, 194, 184);
 rect(squareX, squareY, squareSize, squareSize);
 if(mine == true){
   if(exploded == true){
    fill(246, 1, 6);
    noStroke();
   rect(squareX+2, squareY+2, squareSize-3.5, squareSize-3.5);
 }
   fill(0);
   stroke(0);
   ellipse(squareX+(squareSize/2), squareY+(squareSize/2), 3*squareSize/5, 3*squareSize/5);
   strokeWeight(5);
   line(squareX+squareSize/4, squareY+squareSize/4, squareX+3*squareSize/4, squareY+3*squareSize/4);
   line(squareX+squareSize/4, squareY+3*squareSize/4, squareX+3*squareSize/4, squareY+squareSize/4);
   line(squareX+squareSize/8, squareY+squareSize/2, squareX+7*squareSize/8, squareY+squareSize/2);
   line(squareX+squareSize/2, squareY+squareSize/8, squareX+squareSize/2, squareY+7*squareSize/8);
   noStroke();
   fill(255);
   ellipse(squareX+(2*squareSize/5), squareY+(2*squareSize/5), squareSize/8, squareSize/8);
 }
 else{
 fill(0);
 textSize(69);
 textAlign(CENTER);
 if(mineNum != 0){
   if(mineNum == 1) fill(0, 0, 156);
   else if(mineNum == 2){fill(42, 111, 51);}
   else if(mineNum == 3){fill(200, 31, 29);}
   else if(mineNum == 4){fill(11, 11, 107);}
   else if(mineNum == 5){fill(141, 49, 49);}
   else if(mineNum == 6){fill(0, 125, 125);}
   else if(mineNum == 7){fill(12);}
   else if(mineNum == 8){fill(125);}
 text(mineNum, squareX+(squareSize/2), squareY+(7*squareSize/8));
 }
 }
}
}

class topSquare extends bottomSquare{
 private boolean remover, flagged, unopenable;
 public boolean getRemover(){return remover;}
 public void setRemover(boolean remove){remover = remove;}
 public boolean getFlagged(){return flagged;}
 public void setFlagged(boolean flag){flagged = flag;}
 public boolean getUnopenable(){return unopenable;}
 public void setUnopenable(boolean unopen){unopenable = unopen;}
 topSquare(int x, int y, int size){
  squareX = x;
  squareY = y;
  squareSize = size;
  remover = false;
  mine = false;
  flagged = false;
  }
 private void show(){
   if(remover == false){
 strokeWeight(6);
 noStroke();
 fill(192);
 rect(squareX, squareY, squareSize, squareSize); 
 stroke(243);
 line(squareX+3, squareY+3, squareX+squareSize-3, squareY+3);
 line(squareX+3, squareY+3, squareX+3, squareY+squareSize-3);
 stroke(129);
 line(squareX+squareSize-3, squareY+3, squareX+squareSize-3, squareY+squareSize-3);
 line(squareX+3, squareY+squareSize-3, squareX+squareSize-3, squareY+squareSize-3);
 noStroke();
 fill(243);
 triangle(squareX+squareSize-6,squareY+6, squareX+squareSize-6, squareY, squareX+squareSize, squareY);
 triangle(squareX, squareY+squareSize, squareX, squareY+squareSize-6, squareX+6, squareY+squareSize-6);
 fill(129);
 triangle(squareX+squareSize-6,squareY+6, squareX+squareSize, squareY+6, squareX+squareSize, squareY);
 triangle(squareX, squareY+squareSize, squareX+6, squareY+squareSize, squareX+6, squareY+squareSize-6);
  }
  if(flagged == true){
    fill(0);
    rect(squareX+squareSize/4, squareY+7*squareSize/10, squareSize/2, squareSize/8);
    rect(squareX+9*squareSize/25, squareY+13*squareSize/20, 7*squareSize/25, squareSize/10);
    rect(squareX+squareSize/2, squareY+squareSize/3, squareSize/12, squareSize/3); 
    fill(254, 0, 0);
    triangle(squareX+7*squareSize/12, squareY+squareSize/5, squareX+squareSize/4, squareY+7*squareSize/20, squareX+7*squareSize/12, squareY+squareSize/2);
}
 }
}

public void canOpener(int row, int col){
  if(matrixTop[row][col].getRemover() == true || matrixTop[row][col].getFlagged() == true || matrixTop[row][col].getUnopenable() == true){return;}
  if(matrix2.getMined(row, col) == false && matrixTop[row][col].getFlagged() == false &&  matrixTop[row][col].getUnopenable() == false){
  matrixTop[row][col].setRemover(true);
  if(matrix2.mineDetector(row, col) == 0){
  for(int row1 = row-1; row1 < row+2; row1++){
  for(int col1 = col-1; col1 < col+2; col1++){
  if(matrix2.rowChecker(row1, col1) == true && matrix2.getMined(row1, col1) == false){
    if(row1 == row && col1 == col);
  else canOpener(row1, col1);
  }
  }
  }
}
  }
}

class backgroundThing{
  backgroundThing(){
  }
 
  public void show(){
  background(192);
  //beige-ish? top 
  noStroke();
  fill(238, 231, 221);
  rect(0, 50, 750, 50);
  //white lines
  strokeWeight(10);
  stroke(255);
  line(0, 100, 750, 100);
  line(5, 100, 5, 1000);
  //blue edges
  noFill();
  stroke(31, 81 ,190);
  strokeWeight(10);
  rect(0, 0, 750, 1000);
  //top gray square
  strokeWeight(5);
  stroke(118);
  line(20, 120, 730, 120);
  line(20, 120, 20, 240);
  stroke(248, 247, 244);
  line(20, 240, 730, 240);
  line(730, 120, 730, 240);
  noStroke();
  fill(248, 247, 244);
  triangle(728, 122, 732, 122, 732, 118);
  triangle(18, 242, 22, 242, 22, 238);
  fill(118);
  triangle(728, 122, 728, 118, 732, 118);
  triangle(18, 242, 18, 238, 22, 238);
  //left indicator (mines)
  strokeWeight(2);
  stroke(214, 208, 204);
  fill(9, 7, 3);
  rect(40, 135, 135, 90); 
  //right indicator (timer)
  strokeWeight(2);
  stroke(214, 208, 204);
  fill(9, 7, 3);
  rect(575, 135, 135, 90); 
  //bottom square
  strokeWeight(15);
  stroke(248, 247, 244);
  line(725, 275, 725, 975);
  line(25, 975, 725, 975);
  stroke(118);
  line(25, 275, 25, 975);
  line(25, 275, 725, 275);
  noStroke();
  fill(248, 247, 244);
  triangle(700, 300, 733, 300, 733, 268);
  triangle(18, 983, 51, 983, 51, 950); 
  rect(725, 975, 8, 8);
  fill(118);
  triangle(700, 300, 700, 268, 733, 268);
  triangle(18, 983, 18, 950, 51, 950); 
  rect(18, 268, 8, 8);
  //blue top
  fill(31, 81, 190);
  noStroke();
  rect(0, 0, 750, 55);
  //Minesweeper bomb logo
  fill(100, 100, 185);
  stroke(66, 66, 161);
  strokeWeight(2);
  ellipse(20, 14, 10, 10);
  ellipse(44, 14, 10, 10);
  ellipse(20, 36, 10, 10);
  ellipse(44, 36, 10, 10);
  fill(105, 105, 190);
  ellipse(32, 25, 30, 30);
  ellipse(32, 25, 10, 10);
  fill(100, 100, 185);
  ellipse(32, 10, 10, 10);
  ellipse(32, 40, 10, 10);
  ellipse(17, 25, 10, 10);
  ellipse(47, 25, 10, 10);
  //Minesweeper text
  textAlign(LEFT);
  textSize(35);
  fill(255);
  text("Minesweeper", 60, 37);
}
public void topTab(){
  //beige text;
  stroke(0);
  fill(0);
  textSize(25);
  textAlign(CENTER);
  text("Game", 50, 85);
  text("Help", 130, 85);
}
} 

class numberMaker{
  private int digitHeight, digitLength, digitOfOutput, originalNum, digitX, digitY;
  numberMaker(int givenNum, int digitShown, int digitSize, int digitPosX, int digitPosY){
    digitLength = digitSize;
    digitHeight = digitSize*2;
    originalNum = givenNum;
    digitOfOutput = digitShown;
    digitX = digitPosX;
    digitY = digitPosY;
  }
  
  public void modifyNum(int num){originalNum = num;}
  
  public void show(){
    //yes i know that != exists but it wasn't working for this function for some reason so i had to brute force it :[
    strokeWeight(digitLength/6);
    stroke(62, 11, 17);
    //vert line left top
    if(numShown(originalNum, digitOfOutput) == 0 || numShown(originalNum, digitOfOutput) == 4 || numShown(originalNum, digitOfOutput) == 5 || numShown(originalNum, digitOfOutput) == 6 || 
    numShown(originalNum, digitOfOutput) == 8 || numShown(originalNum, digitOfOutput) == 9){stroke(255, 0, 0);}
    else stroke(62, 11, 17);
    line(digitX-digitLength/2, digitY-(digitHeight/2), digitX-digitLength/2, digitY-digitLength/6);
    //vert line left bottom
    if(numShown(originalNum, digitOfOutput) == 0 || numShown(originalNum, digitOfOutput) == 2 || numShown(originalNum, digitOfOutput) == 6 || numShown(originalNum, digitOfOutput) == 8){stroke(255, 0, 0);}
    else stroke(62, 11, 17);
    line(digitX-(digitLength/2), digitY+digitLength/8, digitX-digitLength/2, digitY+digitHeight/2);
    //vert line right top
    if(numShown(originalNum, digitOfOutput) != 5 && numShown(originalNum, digitOfOutput) != 6){stroke(255, 0, 0);}
    else stroke(62, 11, 17);
    line(digitX+digitLength/2, digitY-(digitHeight/2), digitX+digitLength/2, digitY-digitLength/6);
    //vert line right bottom
    if(numShown(originalNum, digitOfOutput) != 2){stroke(255, 0, 0);}
    else stroke(62, 11, 17);
    line(digitX+(digitLength/2), digitY+digitLength/8, digitX+digitLength/2, digitY+digitHeight/2);
    //horiz line bottom
   if(numShown(originalNum, digitOfOutput) == 0 || numShown(originalNum, digitOfOutput) == 2 || numShown(originalNum, digitOfOutput) == 3 || numShown(originalNum, digitOfOutput) == 5 || 
    numShown(originalNum, digitOfOutput) == 6 || numShown(originalNum, digitOfOutput) == 8 || numShown(originalNum, digitOfOutput) == 9){stroke(255, 0, 0);}
    else stroke(62, 11, 17);
    line(digitX-(3*digitLength/8), digitY+(9*digitHeight/16), digitX+(3*digitLength/8), digitY+(9*digitHeight/16));
    //horiz line middle
    if(numShown(originalNum, digitOfOutput) == 2 || numShown(originalNum, digitOfOutput) == 3 || numShown(originalNum, digitOfOutput) == 4 || 
    numShown(originalNum, digitOfOutput) == 5 || numShown(originalNum, digitOfOutput) == 6 || numShown(originalNum, digitOfOutput) == 8 || numShown(originalNum, digitOfOutput) == 9){stroke(255, 0, 0);}
    else stroke(62, 11, 17);
    line(digitX-(3*digitLength/8), digitY, digitX+(3*digitLength/8), digitY);
    //horiz line top
    if(numShown(originalNum, digitOfOutput) != 1 && numShown(originalNum, digitOfOutput) != 4){stroke(255, 0, 0);}
    else stroke(62, 11, 17);
    line(digitX-(3*digitLength/8), digitY-(9*digitHeight/16), digitX+(3*digitLength/8), digitY-(9*digitHeight/16));
  }
  
  public int numShown(int givenNumber, int digitsPlace){
    if(digitsPlace == 1) return givenNumber%10;
    else return numShown(givenNumber/10, digitsPlace - 1);
  }
}

class timeChecker{
  private int startTime, newTime;
  private boolean stopCounting;
  public void setStopCounting(boolean yesOrNo){stopCounting = yesOrNo;}
  timeChecker(int newerTime){
    newTime = newerTime;
    stopCounting = true;
  }
  
  public void setNewStartTime(int imLosingMyMind){
   startTime = imLosingMyMind; 
  }
  
  public void setNewNewTime(int newestTime){
    if(stopCounting == false)
   newTime = newestTime; 
  }
  
  public int getTime(){
  return (newTime-startTime)/1000;
  }
}

public boolean canChecker(){
 for(int row = 0; row < 10; row++){
   for(int col = 0; col < 10; col++){
     if(matrixTop[row][col].getRemover() == true){return false;}
   }
 }
 return true;
}

 public void checkForReroll(int row, int col){
 if(matrix2.getMined(row, col) == false && matrix2.mineDetector(row, col) == 0){
   clock.setStopCounting(false);
   clock.setNewStartTime(millis());
 }
 else{
  matrix2.reroll();
  checkForReroll(row, col);
 }
}


 public void deathScreen(){
   facer = 2;
   clock.setStopCounting(true);
   for(int row = 0; row < 10; row++){
    for(int col = 0; col < 10; col++){
      matrixTop[row][col].setFlagged(false);
      matrixTop[row][col].setUnopenable(true); 
      if(matrix2.getMined(row, col) == true){matrixTop[row][col].setRemover(true);}
    }
   }
 }
 
public void buttonMaker(int facer, boolean pressed){
  int face = facer;
  boolean pressedIn = pressed;
  fill(230);
  stroke(0);
  if(pressedIn == false){
  strokeWeight(8); 
  stroke(118); 
  line(330, 225, 418, 225); 
  line(420, 135, 420, 223); 
  stroke(248, 247, 244);}
  else{
  strokeWeight(1); 
  stroke(118); 
  line(333, 227, 423, 227); 
  line(422, 138, 422, 228); 
  strokeWeight(8);
}
  line(330, 135, 418, 135);
  line(330, 135, 330, 223);
  if(pressedIn == false){
  noStroke();
  fill(118);
  triangle(416, 140, 424, 140, 424, 131);
  triangle(326, 229, 335, 229, 335, 221);
  fill(248, 247, 244);
  triangle(416, 140, 416, 131, 424, 131);
  triangle(326, 229, 326, 221, 335, 221);
  }
  
  if(face == 0){
    stroke(0);
    strokeWeight(2);
    fill(241, 245, 56);
    if(pressed == false){
    ellipse(375, 180, 65, 65);
    fill(0);
    noStroke();
    ellipse(363, 173, 10, 10);
    ellipse(387, 173, 10, 10);
    arc(375, 190, 40, 25, 0, PI);
    fill(241, 245, 56);
    arc(375, 190, 30, 17, 0, PI);
    }
    else{
    ellipse(380, 185, 65, 65);
    fill(0);
    noStroke();
    ellipse(368, 178, 10, 10);
    ellipse(392, 178, 10, 10);
    arc(380, 195, 40, 25, 0, PI);
    fill(241, 245, 56);
    arc(380, 195, 30, 17, 0, PI);
    }
  }
  else if(face == 1){
    stroke(0);
    strokeWeight(2);
    fill(241, 245, 56);
    ellipse(375, 180, 65, 65);
    fill(0);
    noStroke();
    ellipse(363, 173, 12, 12);
    ellipse(387, 173, 12, 12);
    fill(241, 245, 56);
    strokeWeight(4);
    stroke(0);
    ellipse(375, 193, 15, 17);
  }
  else if(face == 2){
    stroke(0);
    strokeWeight(2);
    fill(241, 245, 56);
    ellipse(375, 180, 65, 65);
    fill(0);
    strokeWeight(4);
    stroke(0);
    line(355, 165, 370, 180);
    line(370, 165, 355, 180);
    line(380, 165, 395, 180);
    line(395, 165, 380, 180);
    noStroke();
    arc(375, 200, 40, 25, PI, 2*PI);
    fill(241, 245, 56);
    arc(375, 200, 30, 17, PI, 2*PI);
  }
  else if(face == 3){
    stroke(0);
    strokeWeight(2);
    fill(241, 245, 56);
    ellipse(375, 180, 65, 65);
    fill(0);
    strokeWeight(3);
    line(342, 180, 353, 170); 
    line(354, 167, 395, 166);
    line(396, 170, 407, 180);
    noStroke();
    arc(363, 166, 20, 30, 0, PI);
    arc(387, 166, 20, 30, 0, PI);
    arc(375, 190, 40, 25, 0, PI);
    fill(241, 245, 56);
    arc(375, 190, 30, 17, 0, PI);
  }
}

public void resetter(){
  numFlagsLeft = 10;
  facer = 0;
  matrix2.reroll();
 for(int row = 0; row < 10; row++){
   for(int col = 0; col < 10; col++){
     matrixTop[row][col].setRemover(false);
     matrixTop[row][col].setFlagged(false);
     matrixTop[row][col].setUnopenable(false);
     matrix2.setExploded(row, col, false);
   }
 }
clock.setNewStartTime(0);
clock.setStopCounting(false);
clock.setNewNewTime(0);
clock.setStopCounting(true);
}

public boolean checkForWinCondition(){
 for(int row = 0; row < 10; row++){
  for(int col = 0; col < 10; col++){
    if(matrix2.getMined(row, col) == false && matrixTop[row][col].getRemover() == false){return false;}
 }
 }
 return true;
}

public void winnerWinnerChickenDinner(){
  facer = 3;
  clock.setStopCounting(true);
  for(int row = 0; row < 10; row++){
   for(int col = 0; col < 10; col++){
     matrixTop[row][col].setUnopenable(true); 
   }
 }
}

public void mousePressed(){
  if(mouseButton == LEFT && mouseX >= 25 && mouseX<=725 && mouseY >= 275 && mouseY <= 975){
    if(matrixTop[(int)((mouseY-275)/70)][(int)((mouseX-25)/70)].getUnopenable() == false){
    facer = 1;
    if(canChecker() == true){checkForReroll((int)((mouseY-275)/70), (int)((mouseX-25)/70));}
    canOpener((int)((mouseY-275)/70), (int)((mouseX-25)/70));
    if(matrixTop[(int)((mouseY-275)/70)][(int)((mouseX-25)/70)].getFlagged() == false) matrixTop[(int)((mouseY-275)/70)][(int)((mouseX-25)/70)].setRemover(true);
    if(matrix2.getMined((int)((mouseY-275)/70), (int)((mouseX-25)/70)) == true){
    matrix2.setExploded((int)((mouseY-275)/70), (int)((mouseX-25)/70), true);
    deathScreen();
  }
    if(checkForWinCondition() == true) winnerWinnerChickenDinner();
     }
  }
  if(mouseButton == LEFT && mouseX >= 330 && mouseX<= 420 && mouseY >= 135 && mouseY <= 225){
    resetter(); 
    pressedIn = true;
}
  if(mouseButton == RIGHT && mouseX >= 25 && mouseX<=725 && mouseY >= 275 && mouseY <= 975){
    if(matrixTop[(int)((mouseY-275)/70)][(int)((mouseX-25)/70)].getUnopenable() == false){
    if(matrixTop[(int)((mouseY-275)/70)][(int)((mouseX-25)/70)].getRemover() == false){ 
      if(matrixTop[(int)((mouseY-275)/70)][(int)((mouseX-25)/70)].getFlagged() == true) {matrixTop[(int)((mouseY-275)/70)][(int)((mouseX-25)/70)].setFlagged(false); 
    numFlagsLeft++;
  }
      else{
        matrixTop[(int)((mouseY-275)/70)][(int)((mouseX-25)/70)].setFlagged(true);
        numFlagsLeft--;
      }
    }
    }
}
}

public void mouseReleased(){
  if(mouseButton == LEFT && mouseX >= 25 && mouseX<=725 && mouseY >= 275 && mouseY <= 975){
 if(matrixTop[(int)((mouseY-275)/70)][(int)((mouseX-25)/70)].getUnopenable() == false){
       facer = 0;
 }
 }
 if(mouseButton == LEFT && mouseX >= 330 && mouseX<= 420 && mouseY >= 135 && mouseY <= 225){pressedIn = false;}
}
