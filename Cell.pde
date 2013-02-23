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
  
  void display() {
     stroke(255);
     fill(r,g,b); 
     rect(x_loc,y_loc,w,h);
  }

}
