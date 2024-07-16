//<>// //<>//
class DrawingGenerator
{
  Data data;

  PVector center = new PVector(400, 400);

  void drawPolarLine(float radius1, float angle1, float radius2, float angle2)
  {
    line(center.x+radius1*cos(radians(angle1)), center.y+radius1*sin(radians(angle1)), center.x+radius2*cos(radians(angle2)), center.y+radius2*sin(radians(angle2)));
  }

  void drawOneLine(int steps, float angle, float deltaRot)
  {
  
    float radius = data.main.Radius;
    for (int i = 0; i < steps; i++)
    {   
      float angle2 = angle + deltaRot;
      float radius2 = radius * data.main.RatioRadius;

      drawPolarLine(radius, angle, radius2, angle2);

      angle = angle2;
      radius = radius2;
      //weight = weight * data.RatioWeight;
    }
  }

  void draw()
  {
    int steps = data.main.NbSteps * data.main.NbStepsMultiplier;

    if (steps < 2)
      steps = 2;

    if (data.main.NbLines < 1)
      data.main.NbSteps = 1;

    float angle = 0;
    float deltaAngle = 360.0 / data.main.NbLines;
    float rotation =  data.main.Rotation *  data.main.RotationMultiplier + data.main.Rotation * data.main.RotationTwitch/100;

    for (int line = 0; line < data.main.NbLines; line ++)
    {        
      angle = deltaAngle*line + data.main.StartAngle;
      drawOneLine(steps, angle, rotation);
    }

    if (data.main.Mirror)
    {
      rotation = - rotation;
      for (int line = 0; line < data.main.NbLines; line ++)
      {
        angle = deltaAngle*line+ data.main.StartAngle;
        drawOneLine(steps, angle, rotation);
      }
    }
  }
}
