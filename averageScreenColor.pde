import java.awt.*;
import java.awt.image.*;
import processing.serial.*;

// Creates object from java library that lets us take screenshots
Robot bot;

// Create serial port object
Serial port;

// Match communication port to one being used on Arduino side
String comPort = "COM1";

// Width and height dimensions of screen
int width = 2560;
int height = 1440;

// Every 8 pixels will be sampled
int pixelDivisor = 8;

// Total amount of pixels in the screen capture
int totalPixels = (width/pixelDivisor) * (height/pixelDivisor);

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
  
  for (int i = 0; i < width; i = i + pixelDivisor) {
    for (int j = 0; j < height; j = j + pixelDivisor) {
      pixel = screenshot.getRGB(i, j);
      r = r + (int)(255 & (pixel >> 16));
      g = g + (int)(255 & (pixel >> 8));
      b = b + (int)(255 & (pixel));
    }
  }
  
  r = r / (totalPixels);
  g = g / (totalPixels);
  b = b / (totalPixels);
  
  print("red = "); println(r);
  print("green = "); println(g);
  print("blue = "); println(b);
  
  port.write(0xff);
  port.write((byte)(r));
  port.write((byte)(g));
  port.write((byte)(b));
  
  delay(10);
}