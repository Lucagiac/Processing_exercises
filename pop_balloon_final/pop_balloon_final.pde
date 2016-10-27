// LICENCE
// Luca Giacolini
// www.lucagiacolini.com
// University College of London, Interactive Architecture Lab
// Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

// INTRODUCTION
//This game consists of a canvas, which is any picture contained in the "data" folder with dimensions 1000x600px
//When pressing CONTROL ballons get released onto the image. If you click on the ballon they explode. If they reach the top, they still pop.


//arraylist declaration
ArrayList<Bubble> bubbles;
int ballWidth = 25;
//picture
PImage img;

  
void setup() {
  size(1000, 600);
  noStroke();
  bubbles = new ArrayList<Bubble>();
  
  //loading the image
  img = loadImage("pic.jpg");
  smooth();

}

void draw() {  
  
  //setting the image as a background
  image(img, 0, 0);
   
  //this loop repeats all the functions of the class Bubble for each element in the arraylist
  for (int i = bubbles.size()-1; i >= 0; i--) 
  {
    
    Bubble bubble = bubbles.get(i); 
    bubble.floating();
    bubble.display();
    bubble.popTop();
    //if the ball leaves the screen, then eliminate it from the list
    if (bubble.finished()) 
      {
        bubbles.remove(i);
      }
  }  
  
  //check whether the mouse is pressed on a bubble
  check_mouse();
}

//creating new objects when CONTROL is pressed
void keyPressed() 
  {
    if (key == CODED) 
      {
        if (keyCode == CONTROL)
          {  
            //generate a random amount of bubbles each time, with a variable size
            float amount = random(5, 25);
            for(int i=0; i < amount; i++){
            bubbles.add(new Bubble(random(25, width-25), (height-random(0, 80)), random(25, 40)));
            }
          }
      }
  }


//running the mousePressed function always
void mousePressed()
{
}

//if mouse is pressed, check whether it is in the area of a balloon, then remove it
void check_mouse()
{
  if (mousePressed)
  {
    float distance;
    for (int i=0; i<bubbles.size(); i++)
    {
      distance=sqrt(pow((mouseX-bubbles.get(i).x), 2) + pow((mouseY-bubbles.get(i).y), 2) );
      if (distance<30)
      {
        fill(220);
        ellipse(bubbles.get(i).x, bubbles.get(i).y, 80, 80);
        bubbles.remove(i);
        i--;
      }
    }
  }
}