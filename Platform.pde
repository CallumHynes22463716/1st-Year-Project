class Platform //creates a class called platform to be called in main
{
  float x,y,w,h;
  
  Platform(float pos_x, float pos_y, int w_size) //Creates varibles for the position and the dimensions of a platform
  {
    x = pos_x;
    y = pos_y;
    w = w_size;
    h = 40;
  }
  void display() //displays the platform on screen
  {
    fill(16, 120, 12); //Makes platforms green colour
    rect(x,y,w,h); //draws rectanglular platform
  }
}
