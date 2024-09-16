class Player //creats a class called player to be called in main
{
  PImage character;
  float x, y, w, h; //variables for character position and width and height
  float xdirect, ydirect;
  float player_speed; //Controls the speed of the player
  int direction; //Controls the direction player is facing
  
  
  boolean moveLeft, moveRight, moveUp;
  
  boolean player_grounded;
  float ground;
    
  Player(float player_x, float player_y) //Creates the player with position, width, height and sprite used
  {
    x = player_x;
    y = player_y;
    w = 50;
    h = 50;
    character = loadImage("character.png"); //Image from: https://www.pngwing.com/en/free-png-nehup/download  
    //assign values to varialbes
    direction = 1;
    xdirect = 8;
    player_speed = 0;
    
    player_grounded = false;
    ground = 0.6;
  }
  
  void display()    //displays player
  {
    pushMatrix();
    translate(x, y);
    scale(direction, 1);
    image(character, 0, 0, w, h);
    popMatrix();
  }
  
  void update()          //function to change direction of player
  {
    x += player_speed;
    
    if (moveRight)
    {
      player_speed = xdirect;
      direction = 1;
    }
    
    if (moveLeft)
    {
      player_speed = -xdirect;
      direction = -1;
    }
  
    if (moveUp && player_grounded)
    {
      ydirect = -15;
      player_grounded = false;
    }
    
    if (!player_grounded)
    {
      ydirect += ground;
    }
    
    y += ydirect;
    
    player_speed *= 0.6;
    
  }
  
  void playerGround(float y2, float h2) //makes the player grounded on platforms
  {
    ydirect = 0;
    player_grounded = true;
    y = y2-h2/2-h/2;
  }
  
  boolean playerMove(char i, boolean j)//creates a boolean variable to find which key is pressed
  {
    switch(i)
    {
      case 'a': //move left with 'a' key
        return moveLeft = j;
      case 'd': //move right with 'd' key
        return moveRight = j;
      case ' ': //jump with spacebar
        return moveUp = j;
      default:
        return j;
    }
  }
}
