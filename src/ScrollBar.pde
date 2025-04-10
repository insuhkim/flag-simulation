
class ScrollBar {
  float x;
  float y;
  float swidth;
  float radius = 10;
  float minval = 1;
  float maxval = 20;
  float val;
  float cur;
  boolean over = false;
  boolean lock = false;
  float alpha = 0.2;
  String text = "Value";

  ScrollBar(float x, float y, float swidth, float initVal, float minval, float maxval) {
    this.val = initVal;
    this.minval = minval;
    this.maxval = maxval;
    this.x = x;
    this.y = y;
    this.swidth = swidth;
    this.cur = constrain(map(val, minval, maxval, x, x+swidth), x, x+swidth);
  }


  void update() {
    overEvent();
    if (lock && mousePressed) {
      if (abs(cur-mouseX) > 1) {
        cur =  constrain(cur+(mouseX-cur)*alpha, x, x+swidth);
      }
    }
    val = map(cur, x, x+swidth, minval, maxval);
  }

  void display() {
    strokeWeight(3);
    stroke(0);
    line(x, y, x+swidth, y);
    if (over || lock) {
      fill(50);
    } else {
      fill(127);
    }
    circle(cur, y, 2*radius);

    fill(0);
    textAlign(CENTER);
    textSize(30);
    text(val, x+swidth/2, y+40);
    text(text, x+swidth/2, y+70);
  }

  void run() {
    update();
    display();
  }

  void overEvent() {
    over = isOver();
  }
  
  boolean isOver() {
    return (mouseX > x && mouseX < x+swidth && mouseY > y-radius && mouseY < y+radius);
  }

  float getVal() {
    return val;
  }
  
  ScrollBar setString(String s) {
    this.text = s;
    return this;
  }
}
