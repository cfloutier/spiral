 //<>// //<>//
class DrawingGenerator
{
     DrawingData data;
      
      PVector center = new PVector(400,400);
      
      void drawPolarLine(float radius1, float angle1, float radius2, float angle2)
      {
        line(center.x+radius1*cos(radians(angle1)), center.y+radius1*sin(radians(angle1)), center.x+radius2*cos(radians(angle2)), center.y+radius2*sin(radians(angle2)));   
      }
      
      
      void drawOneLine(int steps, float angle, float deltaRot)
      {
          float weight = 0.5;
          float radius = data.Radius;
          for (int i = 0 ; i < steps; i++)
            {
                strokeWeight(weight);
                  
                float angle2 = angle + deltaRot;
                float radius2 = radius * data.RatioRadius;
      
                drawPolarLine(radius, angle, radius2, angle2);
                
                angle = angle2;
                radius = radius2;
                //weight = weight * data.RatioWeight;
            }
      }

    void draw()
    {
      int steps = data.NbSteps * data.NbStepsMultiplier;
       
      if (steps < 2)
          steps = 2;
        
      if (data.NbLines < 1)
          data.NbSteps = 1;


        float angle = 0;
        float deltaAngle = 360.0 / data.NbLines;
        float rotation =  data.Rotation *  data.RotationMultiplier + data.Rotation * data.RotationTwitch/100;
      
        for (int line = 0 ; line < data.NbLines; line ++)
        {        
              angle = deltaAngle*line + data.StartAngle;
              drawOneLine(steps, angle, rotation);
        }
        
        if (data.Mirror)
        {
              
              rotation = - rotation;
              for (int line = 0 ; line < data.NbLines; line ++)
              {
               
                angle = deltaAngle*line+ data.StartAngle;
                drawOneLine(steps, angle, rotation);
              }
        }
    }
   
  
}
