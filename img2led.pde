import processing.serial.*;
import java.awt.TextField;

  int rows = 8;
  int cols = 8;
  Cell[][] grid;
  int toggledX;
  int toggledY;

void setup() {
  size(400,400);
  grid = new Cell[rows][cols];
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      // Initialize each object
      grid[i][j] = new Cell(i*50,j*50,50,50,0,0,0,0);
    }
  }
  
}

void draw() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        grid[i][j].display();
      
    }
  }
}

void mousePressed() {
  toggledX = round(mouseX/50);
  toggledY = round(mouseY/50);
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
