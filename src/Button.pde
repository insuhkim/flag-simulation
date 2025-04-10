class Button {
  int x, y;      
  int sizeX, sizeY;
  float Size = 90;    
  color defaultColor;
  color overColor;
  color clickedColor;
  boolean over = false;
  boolean state = false;
  String text = "click";
  
  
  Button(int x, int y, int sizeX, int sizeY) {
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.defaultColor = color(0);
    this.overColor = color(51);
    this.clickedColor = color(#990000);
    this.x = x;
    this.y = y;
  }

  void update() { 
    overEvent();
  }

  void display() {
    if (over) {
      fill(overColor);
      //cursor(HAND);
    } else {
      fill(defaultColor);
      //cursor(ARROW);
    }

    strokeWeight(2);
    stroke(20);
    rect(x, y, Size, Size, 7);
    
    textAlign(CENTER, CENTER);
    textSize(40);
    fill(255);
    text(text, x+sizeX/2, y+sizeY/2);
  }

  void run() {
    update();
    display();
  }
  
  boolean isOver() {
    return (mouseX >= x && mouseX <= x+Size && mouseY >= y && mouseY <= y+Size);
  }
  void overEvent() {
    over = isOver();
  }
  
  
  Button setText(String s) {
    this.text = s;
    return this;
  }
  
  void toggleState() {
    state = !state;
  }
  
  boolean getState() {
    return state;
  }
}
