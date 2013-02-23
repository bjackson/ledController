import processing.serial.*;
import java.awt.TextField;

  int rows = 16;
  int cols = 16;
  Cell[][] grid;
  int toggledX;
  int toggledY;
  int[] formerR = new int[rows];
  int[] formerG = new int[rows];
  int[] formerB = new int[rows];
  int time;
  int placeholder;

void setup() {
  size(608,608);
  grid = new Cell[rows][cols];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*38,j*38,38,38,0,0,0,0);
    }
  }
  
}

void draw() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j].display();
      
    }
  }
  playMusic();
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
     
}

void playMusic() {
  time = millis();
  for (int i = 0; i < cols; i++) {
    time = millis();
    for (int j = 0; j < rows; j++) {
      formerR[j] = grid[i][j].r;
      formerG[j] = grid[i][j].g;
      formerB[j] = grid[i][j].b;
    }
    
    for (int j = 0; j < rows; j++) {
      grid[i][j].r = formerR[j];
      grid[i][j].g = formerG[j];
      grid[i][j].b = formerB[j];
    }
}
}
