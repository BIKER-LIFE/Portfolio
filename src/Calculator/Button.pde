class Button {
  //Member Variables
  float x, y, w, h;
  color c1, c2;
  String face;

  //Constructor
  Button(float x, float y, float w, float h, String face, color c1, color c2) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.face = face;
    this.c1 = c1;
    this.c2 = c2;
  }

  //Member Methods
  void display() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    if (this.w > this.h) {
      textSize(this.h*5/6);
    } else {
      textSize(this.w*5/6);
    }

    if (hover()) {
      fill(this.c2);
    } else {
      fill(this.c1);
    }
    rect(this.x, this.y, this.w, this.h, 5);
    fill(255);
    text(this.face, this.x, this.y-5);
  }

  boolean hover() {
    if (mouseX > this.x-this.w/2 && mouseX < this.x+this.w/2 && mouseY > this.y-this.h/2 && mouseY < this.y+this.h/2) {
      return true;
    } else {
      return false;
    }
  }
}
