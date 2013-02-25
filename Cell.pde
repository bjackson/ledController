class Cell {
  int x_loc;
  int y_loc;
  int w, h;
  int r,g,b;
  int toggled;
  int onCycle;
  SoundCipher sc;


  Cell(int x, int y, int wid, int high, int roja, int verde, int azul, int initToggled, SoundCipher cs) {
    x_loc = x;
    y_loc = y;
    w = wid;
    h = high;
    r = roja;
    g = verde;
    b = azul;
    toggled = initToggled;
    sc = cs;
  }
  
  void display() {
     if (this.toggled == 1)
     {
        r = 255;
        g = 255;
        b = 255;
        
     } else if (this.toggled == 0 && onCycle == 1)
     {
        r = 97;
        g = 195;
        b = 237;
     } else if (this.toggled == 1 && onCycle == 1)
     {
        r = 255;
        g = 255;
        b = 255;
     } else if (this.toggled == 0)
     {
        r = 0;
        g = 0;
        b = 0;
     }
 
     
     stroke(255);
     fill(r,g,b); 
     rect(x_loc,y_loc,w,h);
  }

}
