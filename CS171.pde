//CS161 Project
//Student Number: 22463716
//Platforming game
//Declaring variables
PImage forest;
PImage trashbag;
float trash_x,trash_y;
int trash_counter = 0;

Player sprite; //Calling Player function
Platform platform; //Calling Platform function

Platform multiple_platforms[] = {}; //Creates an array to store the platform dimensions

void setup()
{
  size(800,700); //Creates window
  forest = loadImage("forest.png");   //Image from: http://spritefx.blogspot.com/2013/07/sprite-background-plants.html
  trashbag = loadImage("trashbag.png");     //Image from: https://www.pngwing.com/en/free-png-ncyck/download
  imageMode(CENTER);
  rectMode(CENTER);
  sprite = new Player(150,400); //Creates variable for player

  trash_x = 200 + (int)random(500);
  trash_y =200;
  
  multiple_platforms = (Platform[]) append(multiple_platforms, new Platform(400,700,800)); //Adds new platform to the platforms array
  multiple_platforms = (Platform[]) append(multiple_platforms, new Platform(200,600,250)); //Adds new platform to the platforms array
  multiple_platforms = (Platform[]) append(multiple_platforms, new Platform(400,450,150)); //Adds new platform to the platforms array
  multiple_platforms = (Platform[]) append(multiple_platforms, new Platform(600,600,150)); //Adds new platform to the platforms array
}

void draw()
{
  background(forest);         //Creates plain background
  rectMode(CENTER);
  sprite.display(); //displays player
  sprite.update(); //updates player position
  
  platformPrint(); //displays platform
  
  player_PlatformCollision(); //Adds platform collision
  
  pushMatrix();                //Display the trash bag
  translate(trash_x, trash_y);
  scale(1, 1);
  image(trashbag, 0, 0, 50,50);
  popMatrix();
    
  trash_y +=2;            //Moves bag downwards
    
  if(trash_y>625)                    //If leaf hits bottom of map
  {
    trash_x = 200+(int)random(500);
    trash_y = 50;
  }
  
  if(spriteTrashIntersection(sprite,trash_x,trash_y)) //If the player and trash are colliding (if boolean true)
  {
    trash_counter++;          //Increase score by 1
    trash_x = 200 + (int)random(500); //Reset posiiton
    trash_y=50;
  }
    textSize(20);                  // Display score information on the screen
    fill(255);
    text("Score:"+trash_counter, 540, 20); 
    
}

boolean spriteTrashIntersection(Player t1, float t_x, float t_y) //Create a boolean function to check the interseciton between the player and trashbag
{
  float x_distance = abs(t1.x - t_x); //finds the distance between both x values
  float y_distance = abs(t1.y - t_y); //finds the distance between both y values
  
  float halfW = t1.w/8 + t_x/8; //finds the combined 1/8 width of both
  float halfH = t1.h/8 + t_y/8; //finds the combined 1/8 height of both 
  
  if((x_distance < halfW) & (y_distance < halfH)) //if the distance x is less than 1/8 width and y distance is less than half height 
  {
    return true;
  }
  return false;
}

boolean playerPlatformIntersection(Player t1, Platform t2) //Create a boolean function to check the interseciton between the player and platform
{
  float x_distance = abs(t1.x - t2.x); //finds the distance between both x values
  float y_distance = abs(t1.y - t2.y); //finds the distance between both y values
  
  float halfW = t1.w/2 + t2.w/2; //finds the combined half width of both
  float halfH = t1.h/2 + t2.h/2; //finds the combined half height of both 
  
  if((x_distance < halfW) & (y_distance < halfH)) //if the distance x is less than half width and y distance is less than half height 
  {
    return true;
  }
  return false;
}

void platformPrint() //takes in the dimensions from platform array and displays them
{
  for(int sum = 0; sum < multiple_platforms.length; sum++)
  {
    multiple_platforms[sum].display();
  }
}
void player_PlatformCollision() //checks if the player is colliding with the platforms (taken from video: https://www.youtube.com/watch?v=l8pzu9n2TvU&t=20s)
{
  for(int sum = 0; sum < multiple_platforms.length; sum++)    //Goes through every platform in the array
  {
    if(playerPlatformIntersection(sprite,multiple_platforms[sum]))
    {
      sprite.playerGround(multiple_platforms[sum].y,multiple_platforms[sum].h); //calls the function to ground the player
      break;
    }
    else
    {
      sprite.player_grounded = false;
    }
  }
}
void keyPressed() //Moves character designated key is pressed
{  
  sprite.playerMove(key, true);
}

void keyReleased() //Stops the player when key is released
{
  sprite.playerMove(key,false);
}
