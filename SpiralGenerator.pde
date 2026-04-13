class SpiralGenerator //<>//
{
  SpiralsData data;
  ArrayList<SpiralLine> lines;

  PVector center = new PVector(0, 0);
  
  SpiralGenerator()
  {
    lines = new ArrayList<SpiralLine>();
  }

  void addLineSegment(SpiralLine line, float xFrom, float yFrom, float xTo, float yTo)
  {
    if (data.page.clipping) 
    {
      float[] clipped = new float[4];
      if (clipLineToCenteredRect(xFrom, yFrom, xTo, yTo, clipped))
      {
        line.addPoint(new PVector(clipped[0], clipped[1]));
        line.addPoint(new PVector(clipped[2], clipped[3]));
      }
    }
    else
    {
      line.addPoint(new PVector(xFrom, yFrom));
      line.addPoint(new PVector(xTo, yTo));
    }
  }

  // Clips a line segment to the centered rectangle defined by data.crop_width / data.crop_height.
  // Returns true and fills out[0..3] = {x1,y1,x2,y2} when a clipped segment exists.
  boolean clipLineToCenteredRect(float xFrom, float yFrom, float xTo, float yTo, float[] out)
  {
    float halfW = data.page.clip_width * 0.5;
    float halfH = data.page.clip_height * 0.5;
    float xmin = center.x - halfW;
    float xmax = center.x + halfW;
    float ymin = center.y - halfH;
    float ymax = center.y + halfH;

    float dx = xTo - xFrom;
    float dy = yTo - yFrom;

    float[] p = { -dx, dx, -dy, dy };
    float[] q = { xFrom - xmin, xmax - xFrom, yFrom - ymin, ymax - yFrom };

    float u1 = 0.0;
    float u2 = 1.0;

    for (int i = 0; i < 4; i++)
    {
      if (p[i] == 0)
      {
        if (q[i] < 0) // parallel and outside
          return false;
      }
      else
      {
        float t = q[i] / p[i];
        if (p[i] < 0)
        {
          if (t > u2) return false;
          if (t > u1) u1 = t;
        }
        else
        {
          if (t < u1) return false;
          if (t < u2) u2 = t;
        }
      }
    }

    out[0] = xFrom + u1 * dx;
    out[1] = yFrom + u1 * dy;
    out[2] = xFrom + u2 * dx;
    out[3] = yFrom + u2 * dy;
    return true;
  }

  void addPolarSegment(SpiralLine line, float radius1, float angle1, float radius2, float angle2)
  {
    float xFrom = center.x + radius1 * cos(radians(angle1));
    float yFrom = center.y + radius1 * sin(radians(angle1));
    float xTo = center.x + radius2 * cos(radians(angle2));
    float yTo = center.y + radius2 * sin(radians(angle2));
    
    addLineSegment(line, xFrom, yFrom, xTo, yTo);
  }

  void buildOneLine(SpiralLine line, int steps, float angle, float deltaRot)
  {
    float radius = data.main.Radius;
    for (int i = 0; i < steps; i++)
    {   
      float angle2 = angle + deltaRot;
      float radius2 = radius * data.main.RatioRadius;

      addPolarSegment(line, radius, angle, radius2, angle2);

      angle = angle2;
      radius = radius2;
    }
  }

  void update()
  {
    lines.clear();

    int steps = data.main.NbSteps * data.main.NbStepsMultiplier;

    if (steps < 2)
      steps = 2;

    if (data.main.NbLines < 1)
      data.main.NbSteps = 1;

    float angle = 0;
    float deltaAngle = 360.0 / data.main.NbLines;
    float rotation = data.main.Rotation * data.main.RotationMultiplier + data.main.Rotation * data.main.RotationTwitch / 100;

    for (int line = 0; line < data.main.NbLines; line++)
    {        
      SpiralLine spiralLine = new SpiralLine();
      angle = deltaAngle * line + data.main.StartAngle;
      buildOneLine(spiralLine, steps, angle, rotation);
      lines.add(spiralLine);
    }

    if (data.main.Mirror)
    {
      rotation = -rotation;
      for (int line = 0; line < data.main.NbLines; line++)
      {
        SpiralLine spiralLine = new SpiralLine();
        angle = deltaAngle * line + data.main.StartAngle;
        buildOneLine(spiralLine, steps, angle, rotation);
        lines.add(spiralLine);
      }
    }
  }

  void draw()
  {
    if (data.any_change())
    {
      update();
      data.reset_all_changes();
    }

    for (int i = 0; i < lines.size(); i++)
    {
      lines.get(i).draw();
    }
  }
}

// SpiralLine: polyline for spiral that draws points as individual line segments (point-to-point)
class SpiralLine extends SegmentedPolyline
{
}
