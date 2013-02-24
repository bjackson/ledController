import processing.serial.*;
import java.awt.TextField;

  int rows = 16;
  int cols = 16;
  public static Cell[][] grid;
  int toggledX;
  int toggledY;
  int checkTime;
  int currentTime;
  int placeholder;

void setup() {
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

void draw() {
  //thread("storeColor");
  
  
}

void mousePressed() {
  toggledX = round(mouseX/38);
  toggledY = round(mouseY/38);
  if (grid[toggledX][toggledY].r == 0) {
    grid[toggledX][toggledY].r = 255;
    grid[toggledX][toggledY].g = 255;
    grid[toggledX][toggledY].b = 255;
  } else {
    grid[toggledX][toggledY].r = 0;
    grid[toggledX][toggledY].g = 0;
    grid[toggledX][toggledY].b = 0;
    
  }
  print(grid);
}


//void storeColor() {
//  for (int i = 0; i < cols; i++) {
//    for (int j = 0; j < rows; j++) {
//      formerR[j] = grid[i][j].r;
//      formerG[j] = grid[i][j].g;
//      formerB[j] = grid[i][j].b;
//      grid[i][j].r = 200;
//      grid[i][j].g = 150;
//      grid[i][j].b = 245;
//    }
//    
//    checkTime = millis();
//    while (checkTime + 100 > currentTime)
//    {
//      for (int j = 0; j < rows; j++) 
//      {
//        grid[i][j].display();       
//      }
//      currentTime = millis();
//    }
//    
//    for (int j = 0; j < rows; j++) {
//        grid[i][j].r = formerR[j];
//        grid[i][j].g = formerG[j];
//        grid[i][j].b = formerB[j];
//    }
//    
//    checkTime = millis();
//    while (checkTime + 100 > currentTime)
//    {
//      for (int j = 0; j < rows; j++) 
//      {
//        grid[i][j].display();       
//      }
//      currentTime = millis();
//    }
//    
//  }
//}

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
  void start () {
    // Set running equal to true
    running = true;
    // Print messages
    // Do whatever start does in Thread, don't forget this!
    super.start();
  }
  
     // We must implement run, this gets triggered by start()
  void run () {
    while (running) {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        formerR[j] = grid[i][j].r;
        formerG[j] = grid[i][j].g;
        formerB[j] = grid[i][j].b;
        if (grid[i][j].r != 255)
        {
          grid[i][j].r = 200;
          grid[i][j].g = 150;
          grid[i][j].b = 245;
        
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
    



