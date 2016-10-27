//class bubble needs function, methods, data)
class Bubble{
  
  //data variables
  float x, y, dia;
  float life = height;
  int posX, posY;
  
  //constructors
  Bubble(float tempX, float tempY, float tempZ)
  {
    x = tempX;
    y = tempY;
    dia = tempZ;
  }
  
  //function to display the ellipse
  void display()
  {
    posX = int(x);
    posY = int(y);
    color c = get(posX, posY);//getting the pixel color
    stroke(100);
    fill(c);
    ellipse(x, y, dia, dia*1.1);
    //drawing the small tail under the balloon
    stroke(100);
    line(x+sin(x)*1.0, y+dia/2, x+sin(x)*2.0, y+dia*2);
    
  }
  
  //function to move the ellipse upward. It actually also shakes a bit, to make it less static
  void floating(){
    float factor = random(1,2);
    y = y-factor;
    x = x+random(-0.5, 0.5);
  }
  
  //function to pop the bubble when top is reached
  void popTop(){
           
    if (y< (dia))
      {
        dia= dia +2;
      }
      if (y< (dia*0.5))
      {
        dia = dia -1;
      }
      if (y< (dia*0.4))
      {
        dia = 0;
      }
  }

  //this boolean checks when the top of the screen has been reached
  boolean finished() 
  {
    life--;
    if (life < 0) 
      {
        return true;
      } 
    else 
      {
        return false;
      }
  }
  
}//class end