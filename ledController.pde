 import processing.serial.*;
 import java.awt.TextField;
 import arb.soundcipher.*;

  public static Serial arduino;
  public static SoundCipher sc;
  int rows = 16;
  int cols = 16;
  public static Cell[][] grid;
  public static byte[] gridArray;
  int toggledX;
  int toggledY;
  int checkTime;
  int currentTime;
  int placeholder;

void setup() {
  arduino = new Serial(this, "/dev/tty.usbmodem641", 115200);
  SoundCipher sc = new SoundCipher(this);
  size(608,608);
  grid = new Cell[rows][cols];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*38,j*38,38,38,0,0,0,0, sc);
      grid[i][j].display();
    }
  }
  sc.instrument(sc.BELL);
  CycleThread cycle = new CycleThread(100, "cycle", grid, sc);
  TransmitThread transmit = new TransmitThread(10, "transmit", grid);
  cycle.start();
  transmit.start();
  sc.playNote(60, 100, 1);
}

void draw() {
  

  
}

void mousePressed() {
  toggledX = round(mouseX/38);
  toggledY = round(mouseY/38);
  if (grid[toggledX][toggledY].toggled == 0) {
    grid[toggledX][toggledY].toggled = 1;
    grid[toggledX][toggledY].display();
  } else {
    grid[toggledX][toggledY].toggled = 0;
    grid[toggledX][toggledY].display();
    
  }
  println(toggledX + ", " + toggledY);
}

void keyPressed()
{
  if (key == 32)
  {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j].toggled = 0;
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
  SoundCipher sc;
  
  
 
  // Constructor, create the thread
  // It is not running by default
  CycleThread (int w, String s, ledController.Cell[][] theGrid, SoundCipher cs) {
    wait = w;
    running = false;
    id = s;
    count = 0;
    grid = theGrid;
    int[] formerR = new int[16];
    int[] formerG = new int[16];
    int[] formerB = new int[16];
    sc = cs;
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
        grid[i][j].onCycle = 1;
        grid[i][j].display();
        if (grid[i][j].toggled == 1)
        {
          sc.playNote(map(grid[i][j].y_loc/38, 1, 16, 55, 80), 100, .5);
        }
        }
    
      // Ok, let's wait for however long we should wait
      try {
        sleep((long)(wait));
      } catch (Exception e) {
      }
       for (int j = 0; j < rows; j++) 
       {
          grid[i][j].onCycle = 0;
          grid[i][j].display();
       }
      
    }
    }
    System.out.println(id + " thread is done!");  // The thread is done when we get to the end of run()
  }
  
  
}
    
class TransmitThread extends Thread {
  
  boolean running;           // Is the thread running?  Yes or no?
  int wait;                  // How many milliseconds should we wait in between executions?
  String id;                 // Thread name
  int count;                 // counter
  byte[] gridArray;          // grid of cells
  
 
  // Constructor, create the thread
  // It is not running by default
  TransmitThread (int w, String s, ledController.Cell[][] theGrid) {
    wait = w;
    running = false;
    id = s;
    count = 0;
    grid = theGrid;
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

    //Serial Transmission Routine
    int arrayPosition = 0;
    byte[] gridArray = new byte[16*16*3];
    for (int i = 0; i < cols; i++)
    {
      for (int j = 0; j < rows; j++)
      {
        gridArray[arrayPosition] = byte(grid[i][j].r);
        arrayPosition++;
        gridArray[arrayPosition] = byte(grid[i][j].g);
        arrayPosition++;
        gridArray[arrayPosition] = byte(grid[i][j].b);
        arrayPosition++;
      }
    }

    //arduino.write(gridArray);
    
      // Ok, let's wait for however long we should wait
      try {
        sleep((long)(wait));
      } catch (Exception e) {
      }

    
    }
    System.out.println(id + " thread is done!");  // The thread is done when we get to the end of run()
  }
  
  
}



