//Liam Stoll | Calculator | Sept 25 2025

import java.text.DecimalFormat;

Button[] buttons = new Button[13];
Button[] numButtons = new Button[10];
String text = "0";
String calcType = "";
float num1 = 0;
float num2 = 0;
boolean not = true;
float ans = 0;
DecimalFormat df = new DecimalFormat("0.000E00");

int themeNum = 0;
color backgroundColor = 78;
color displayColor = 100;

void setup() {
  size(285, 450);
  background(78);

  buttons[0] = new Button(30, 120, 30, 30, "C", color(255, 128, 0), color(255, 0, 0));
  buttons[1] = new Button(75, 120, 30, 30, "±", 120, color(0, 128, 0));
  buttons[2] = new Button(232.5, 202.5, 45, 105, "=", 120, color(0, 128, 0));
  buttons[3] = new Button(120, 120, 30, 30, "×", 120, color(0, 128, 0));
  buttons[4] = new Button(165, 120, 30, 30, "÷", 120, color(0, 128, 0));
  buttons[5] = new Button(210, 120, 30, 30, "+", 120, color(0, 128, 0));
  buttons[6] = new Button(255, 120, 30, 30, "-", 120, color(0, 128, 0));
  buttons[7] = new Button(width/2-95, 352.5, 35, 35, "^", 120, color(0, 128, 0));
  buttons[8] = new Button(width/2+50, 352.5, 35, 35, "√", 120, color(0, 128, 0));
  buttons[9] = new Button(width/2-50, 352.5, 35, 35, "π", 120, color(0, 128, 0));
  buttons[10] = new Button(width/2+95, 352.5, 35, 35, "x^2", 120, color(0, 128, 0));
  buttons[11] = new Button(232.5, 292.5, 45, 45, "·", 120, color(0, 128, 0));

  numButtons[7] = new Button(52.5, 172.5, 45, 45, "7", 120, color(0, 128, 0));
  numButtons[8] = new Button(112.5, 172.5, 45, 45, "8", 120, color(0, 128, 0));
  numButtons[9] = new Button(172.5, 172.5, 45, 45, "9", 120, color(0, 128, 0));
  numButtons[4] = new Button(52.5, 232.5, 45, 45, "4", 120, color(0, 128, 0));
  numButtons[5] = new Button(112.5, 232.5, 45, 45, "5", 120, color(0, 128, 0));
  numButtons[6] = new Button(172.5, 232.5, 45, 45, "6", 120, color(0, 128, 0));
  numButtons[1] = new Button(52.5, 292.5, 45, 45, "1", 120, color(0, 128, 0));
  numButtons[2] = new Button(112.5, 292.5, 45, 45, "2", 120, color(0, 128, 0));
  numButtons[3] = new Button(172.5, 292.5, 45, 45, "3", 120, color(0, 128, 0));
  numButtons[0] = new Button(width/2, 352.5, 45, 45, "0", 120, color(0, 128, 0));

  buttons[12] = new Button(width/2, 412.5, 70, 45, "TM", 120, color(0, 128, 0));
}

void draw() {
  background(backgroundColor);
  for (int i = 0; i < buttons.length; i++) {
    buttons[i].display();
  }

  for (int i = 0; i < numButtons.length; i++) {
    numButtons[i].display();
  }

  updateDisplay();
}

void mousePressed() {
  for (int i = 0; i < buttons.length; i++) {
    if (buttons[i].hover()) {
      if (i==0) {
        text = "0";
        calcType = "";
        num1 = 0;
        num2 = 0;
        ans = 0;
        not = true;
      } else if (i==1) {
        if (text.charAt(0) == '-') {
          text = text.substring(1);
        } else {
          text = "-" + text;
        }
      } else if (i==11) {
        if (!text.contains(".")) {
          text += ".";
        }
      } else if (i>=3 && i<=7) {
        num1 = num2;
        num2 = float(text);
        performCalculation();
        calcType = buttons[i].face;
      } else if (i==8) {
        num1 = num2;
        num2 = float(text);
        num2 = sqrt(num2);
        text = str(num2);
      } else if (i==10) {
        num1 = num2;
        num2 = float(text);
        num2 = num2*num2;
        println(num1);
        text = str(num2);
      } else if (i==2) {
        if (num1 == 0) {
          num1 = num2;
          num2 = float(text);
        }
        performCalculation();
        calcType = "";
      } else if (i==9) {
        text = "3.1415927";
      } else if (i == 12) {
        changeTheme();
      }
    }
  }

  for (int i = 0; i < numButtons.length; i++) {
    if (numButtons[i].hover()) {
      if (not) {
        text = numButtons[i].face;
        not = false;
      } else {
        text += numButtons[i].face;
      }
    }
  }
}

void updateDisplay() {
  fill(displayColor);
  rectMode(CORNER);
  rect(15, 15, 255, 75, 5);
  fill(255);
  textAlign(RIGHT);
  textSize(60);
  text(text, 15, 15, 255, 90);
}

void performCalculation() {
  not = true;
  println("type "+calcType);
  println("num1 "+num1);
  println("num2 "+num2);
  if (calcType.equals("+")) {
    ans = num1 + num2;
  } else if (calcType.equals("-")) {
    ans = num1 - num2;
  } else if (calcType.equals("×")) {
    ans = num1*num2;
  } else if (calcType.equals("÷")) {
    ans = num1/num2;
  } else if (calcType.equals("^")) {
    ans = pow(num1, num2);
  }
  num2 = ans;
  if (calcType.equals("")) {
    num2 = float(text);
    ans = 0;
  }

  if (ans == Float.POSITIVE_INFINITY || ans == Float.NEGATIVE_INFINITY) {
    text = "ERROR";
  } else {
    if (ans > 99999999) {
      text = df.format(ans);
    } else {
      if (int(ans) == ans) {
        text = str(int(ans));
      } else {
        text = str(ans);
      }
      println("ans "+ans);
    }
  }
}

void changeTheme() {
  themeNum++;
  themeNum %= 3; // Cycle through 3 themes (0, 1, 2)

  if (themeNum == 0) {
    backgroundColor = color(78);      // Default dark gray
    displayColor = color(100);        // Medium gray
  } else if (themeNum == 1) {
    backgroundColor = color(240, 240, 240); // Light theme
    displayColor = color(200);              // Light gray
  } else if (themeNum == 2) {
    backgroundColor = color(0, 0, 128);     // Deep blue
    displayColor = color(255, 255, 0);      // Bright yellow
  }
}
