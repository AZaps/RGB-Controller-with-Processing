/*
 * Anthony Zaprzalka
 * 
 * RGB Light Controller using Processing
 * 
 * Processing takes a screenshot, and determines the average RGB values from that capture
 * 
 * Red -> 11
 * Green -> 9
 * Blue -> 10
 */

#include <Arduino.h>
#include <Wire.h>

const int redLight = 11;
const int greenLight = 9;
const int blueLight = 10;

int red = 0;
int green = 0;
int blue = 0;

void setup() {
  Serial.begin(9600);
  outputColor(0, 0, 0);
  delay(20);
  lightStart();
}

void loop() {
  // Read colors from processing
  if (Serial.available() >= 4) {
    if (Serial.read() == 0xff) {
      red = Serial.read();
      green = Serial.read();
      blue = Serial.read();
    }
  }

  // Output Colors
  outputColor(red, green, blue);
}

void outputColor(int r, int g, int b) {
  analogWrite(redLight, r);
  analogWrite(greenLight, g);
  analogWrite(blueLight, b);
}

void lightStart() {
  // Fade in white
  for (int i = 0; i < 256; i++) {
    outputColor(i, i, i);
    delay(10);
  }
  // Fade out white
  for (int i = 255; i > 50; i--) {
    outputColor(i, i, i);
    delay(10);
  }
  // Also check if correctly plugged in 
  outputColor(255, 0, 0);
  delay(1000);
  outputColor(0, 255, 0);
  delay(1000);
  outputColor(0, 0, 255);
  delay(1000);
  outputColor(0,0,0);
  delay(500);
}
