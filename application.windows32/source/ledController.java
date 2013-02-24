import processing.core.*; 
import processing.data.*; 
import processing.opengl.*; 

import processing.serial.*; 
import java.awt.TextField; 

import java.applet.*; 
import java.awt.Dimension; 
import java.awt.Frame; 
import java.awt.event.MouseEvent; 
import java.awt.event.KeyEvent; 
import java.awt.event.FocusEvent; 
import java.awt.Image; 
import java.io.*; 
import java.net.*; 
import java.text.*; 
import java.util.*; 
import java.util.zip.*; 
import java.util.regex.*; 

public class ledController extends PApplet {




  int rows = 16;
  int cols = 16;
  public static Cell[][] grid;
  int toggledX;
  int toggledY;
  int checkTime;
  int currentTime;
  int placeholder;

public void setup() {
  size(608,608);
  grid = new Cell[rows][cols];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*38,j*38,38,38,0,0,0,0);
      grid[i][j].display();
    }
  }
  CycleThread thread1 = new CycleThread(100, "cat", grid);
  thread1.start();
}

public void draw() {

  
}

public void mousePressed() {
  toggledX = round(mouseX/38);
  toggledY = round(mouseY/38);
  if (grid[toggledX][toggledY].r == 0) {
    grid[toggledX][toggledY].r = 255;
    grid[toggledX][toggledY].g = 255;
    grid[toggledX][toggledY].b = 255;
    grid[toggledX][toggledY].display();
  } else {
    grid[toggledX][toggledY].r = 0;
    grid[toggledX][toggledY].g = 0;
    grid[toggledX][toggledY].b = 0;
    grid[toggledX][toggledY].display();
    
  }
  println(toggledX + ", " + toggledY);
}

public void keyPressed()
{
  if (key == 32)
  {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j].r = 0;
        grid[i][j].g = 0;
        grid[i][j].b = 0;
        grid[i][j].display();
      }
    }
  }
  
}

class CycleThread extends Thread {
  
  boolean running;           // Is the thread running?  Yes or no?
  int wait;                  // How many milliseconds should we wait in between executions?
  String id;                 // Thread name
  int count;                 // counter
  Cell[][] grid;          // grid of cells
  int[] formerR = new int[16];
  int[] formerG = new int[16];
  int[] formerB = new int[16];
  
 
  // Constructor, create the thread
  // It is not running by default
  CycleThread (int w, String s, ledController.Cell[][] theGrid) {
    wait = w;
    running = false;
    id = s;
    count = 0;
    grid = theGrid;
    int[] formerR = new int[16];
    int[] formerG = new int[16];
    int[] formerB = new int[16];
  }
  
  // Overriding "start()"
  public void start () {
    // Set running equal to true
    running = true;
    // Print messages
    // Do whatever start does in Thread, don't forget this!
    super.start();
  }
  
     // We must implement run, this gets triggered by start()
  public void run () {
    while (running) {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        formerR[j] = grid[i][j].r;
        formerG[j] = grid[i][j].g;
        formerB[j] = grid[i][j].b;
        if (grid[i][j].r == 0)
        {
          grid[i][j].r = 97;
          grid[i][j].g = 195;
          grid[i][j].b = 237;
        
          grid[i][j].display();
        }
        }
    
      // Ok, let's wait for however long we should wait
      try {
        sleep((long)(wait));
      } catch (Exception e) {
      }
        for (int j = 0; j < rows; j++) {
          grid[i][j].r = formerR[j];
          grid[i][j].g = formerG[j];
          grid[i][j].b = formerB[j];
          grid[i][j].display();
    }
    }
    }
    System.out.println(id + " thread is done!");  // The thread is done when we get to the end of run()
  }
  
  
}
    



class Cell {
  int x_loc;
  int y_loc;
  int w, h;
  int r,g,b;
  int toggled;


  Cell(int x, int y, int wid, int high, int roja, int verde, int azul, int initToggled) {
    x_loc = x;
    y_loc = y;
    w = wid;
    h = high;
    r = roja;
    g = verde;
    b = azul;
    toggled = initToggled; 
  }
  
  public void display() {
     stroke(255);
     fill(r,g,b); 
     rect(x_loc,y_loc,w,h);
  }

}

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "ledController" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
