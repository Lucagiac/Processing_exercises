// LICENCE
// Luca Giacolini
// www.lucagiacolini.com
// University College of London, Interactive Architecture Lab
// Attribution-ShareAlike 4.0 International (CC BY-SA 4.0)

// INTRODUCTION
//Eat the bites, move using arrow keys



int pacRadius = 25;
int direction = 1;
int direction1 = 0;
 
float x = 150;
float y = height/2;
 
ArrayList<Particle>  bite= new ArrayList();

PImage img;
 
void setup() {
  size(1000, 600);
  ellipseMode(RADIUS);
  //at start, draw a bite in a random place
  Particle P = new Particle(100, 100);
  bite.add(P);
    
  frameRate(30);
  
  img = loadImage("pac.jpg");
  smooth();
  
  

}
 
void draw() {
  
  background(0);
  
  image(img, 250, 200);
  
  frameDraw();
  
  fill (255, 255, 10);
  smooth();
  noStroke(); 
  render();
 
  for (int i=0;i<bite.size();i++) 
    {
      //show the bite
      Particle Pn = (Particle) bite.get(i);
      Pn.display();
      //if pacman goes over the bite, delete that one bite and create a new one in random location
      if (dist(x, y, Pn.x, Pn.y)<pacRadius*0.8)
        {
          bite.remove(i);
          //uncomment if you wanna pacman to grow in size
          //pacRadius=pacRadius+3;
          
          glow();
          
          //this is a quite not efficient random generator for the particles
          int num1 = (int)random(60, height-60);
          if(num1 > 1*height/5-60 && num1 < 4*height/5+60)
          {
            if(num1%2 == 0){
            num1 = (int)random(4*height/5+60, height-60);}
            else{
              num1 = (int)random(60, 1*height/5-60);
            }
          }
          Particle P = new Particle((int)random(60, width-60), num1);
          bite.add(P);
        }
    }
}
 
 
//controller of the pacman. If the direction keys are pressed it changes direction
void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {
      x = x - 0.002;
      direction = -1;
      direction1 = 0;
    }
    else if (keyCode == RIGHT) {  
      x = x + 0.002;
      direction = 1;
      direction1 = 0;
    }
    else if (keyCode == UP) {
      y = y - 0.002;
      direction = 0;
      direction1 = -1;
    }
    else if (keyCode == DOWN) { 
      y = y + 0.002;
      direction = 0;
      direction1 = 1;
    }
  }
}
 
//render the pacman, according to its direction that varies from -1 to 1
void render() {
  for ( int i=-1; i < 2; i++)
    {
      for ( int j=-1; j < 2; j++) 
        {
          pushMatrix();
          y = (y+direction1)%height;
          x = (x+direction)%width;
          //make the pacman actually move and reappear when out of screen
          translate(x + (i*width), y + (j*height));
          //according to the direction, rotate the circle
          if (direction == -1) 
            { 
              rotate(PI);
            }
          if (direction1 == 1)
            { 
              rotate(HALF_PI);
            }
          if (direction1 == -1)
            { 
              rotate( PI + HALF_PI );
            }
     
          //conditions to stick to top and bottom
          if (y < 48){y = 48;}
          if (y > height-48){y = height - 48;}
          
          //conditions to stick to the central block top and bottom
          if(y > 1*height/5-30 && y < height/2)
            {
              if (x > 1*width/7 && x < 6*width/7)
                {
                  y = 1*height/5-30;
                }
            }
          
          else if(y > height/2 && y < 4*height/5+30)
            {
              if (x > 1*width/7 && x < 6*width/7)
                {
                  y = 4*height/5+30;
                }
            }
          
          //conditions to stick to the central block left and right
          if(x > 1*width/7-30 && x < width/2){
            if (y > 1*height/5 && y < 4*height/5)
            
            {
              x = 1*width/7-30;
            }
          }   
          else if(x > width/2 && x < 6*width/7+30)
          {
          if (y > 1*height/5 && y < 4*height/5)
            
           {
             x = 6*width/7+30;
           }
          }
          
          //conditions on the left and right sides
          if (y > ((2*height/5)+20) && y < ((3*height/5)-20))         
            { 
              //reappear from other side if pacman moves through the hole
              if (x > width){x = 0;}
              if (x < 0){x = width;}  
            }
          
          else
            {
              //stick to side
              if (x < 48){x = 48;}
              if (x > width-48){x = width-48;}
            }

          //drawing the mouth opening, over time
          arc(0, 0, pacRadius, pacRadius, map((millis() % 500), 0, 500, 0, 0.52), map((millis() % 500), 0, 500, TWO_PI, 5.76) );
          popMatrix();
        }
        

    }
    
 
}

//drawing all the blue frames in the playfield
void frameDraw(){
  
  noFill();
  strokeWeight(2);
  stroke(0, 0, 255);
  
  //upper block
  beginShape();
  vertex(10, 2*height/5);
  vertex(10, 10);
  vertex(width-10, 10);
  vertex(width-10, 2*height/5);
  vertex(width-18, 2*height/5);
  vertex(width-18, 18);
  vertex(18, 18);
  vertex(18, 2*height/5);
  endShape(CLOSE);
  
  //lower block
  beginShape();
  vertex(10, 3*height/5);
  vertex(10, height-10);
  vertex(width-10, height-10);
  vertex(width-10, 3*height/5);
  vertex(width-18, 3*height/5);
  vertex(width-18, height-18);
  vertex(18, height-18);
  vertex(18, 3*height/5);
  endShape(CLOSE);

  //central block
  beginShape();
  vertex(1*width/7, 1*height/5);
  vertex(6*width/7, 1*height/5);
  vertex(6*width/7, 4*height/5);
  vertex(1*width/7, 4*height/5);
  endShape(CLOSE);
  beginShape();
  vertex(1*width/7+8, 1*height/5+8);
  vertex(6*width/7-8, 1*height/5+8);
  vertex(6*width/7-8, 4*height/5-8);
  vertex(1*width/7+8, 4*height/5-8);
  endShape(CLOSE);

}

class Particle {
  int x, y;  
  //constructors
  Particle(int x, int y) 
    {
      this.x = x;
      this.y = y;
    }
  //displaying the bite
  void display() {
    noStroke();
    fill(255, 255, 182);
    ellipse(x, y, 8, 8);
  }
}

void glow(){
  
  fill(255, 255, 10, 80);
  ellipse (x,y,35,35);
}