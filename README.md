# RGB-Controller-with-Processing
Couples an Arduino controller for outputting colors taken from Processing.

Processing will take screenshots of the current window and determine a color average to send to the Arduino program. The Arduino program will output this determined color to the light controller.

The light controller I am using only has the ability to deal with one color at a time, so only an average single color from the screen is required.
