import java.awt.*;
import java.awt.image.*;
import processing.serial.*;

// Creates object from java library that lets us take screenshots
Robot bot;

// Create serial port object
Serial port;

// Match communication port to one being used on Arduino side
String comPort = "COM3";

// Width and height dimensions of screen
int width = 2560;
int height = 1440;

void setup() {
  port = new Serial(this, comPort, 9600);
  
  // Robot class error check
  try {
    bot = new Robot();
    println("OK");
  }
  catch (AWTException e) {
    println("Problems detected.");
    println(e);
    exit();
  }
}

void draw() {
  int pixel;
  
  float r = 0;
  float g = 0;
  float b = 0;
  
  BufferedImage screenshot = bot.createScreenCapture(new Rectangle(new Dimension(width, height)));
  
  for (int i = 0; i < 2560; i = i + 8) {
    for (int j = 0; j < 1440; j = j + 8) {
      pixel = screenshot.getRGB(i, j);
      r = r + (int)(255 & (pixel >> 16));
      g = g + (int)(255 & (pixel >> 8));
      b = b + (int)(255 & (pixel));
    }
  }
  
  r = r / (57600);
  g = g / (57600);
  b = b / (57600);
  
  print("red = "); println(r);
  print("green = "); println(g);
  print("blue = "); println(b);
  
  port.write(0xff);
  port.write((byte)(r));
  port.write((byte)(g));
  port.write((byte)(b));
  
  delay(10);
}