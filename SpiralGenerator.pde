class SpiralGenerator //<>//
{
  ArrayList<SpiralLine> lines;

  PVector center = new PVector(0, 0);
  
  SpiralGenerator()
  {
    lines = new ArrayList<SpiralLine>();
  }

  boolean isPointInClipRect(float x, float y)
  {
    return pointInClipRect(x, y, center.x, center.y, data.page.clip_width, data.page.clip_height);
  }

  SpiralLine addLineSegment(SpiralLine line, float xFrom, float yFrom, float xTo, float yTo)
  {
    if (!data.page.clipping) 
    {
      line.addPoint(new PVector(xFrom, yFrom));
      line.addPoint(new PVector(xTo, yTo));
      return line;
    }

    boolean fromInside = isPointInClipRect(xFrom, yFrom);
    boolean toInside = isPointInClipRect(xTo, yTo);
    float[] clipped = new float[4];
    boolean hasClipped = clipLineToCenteredRect(xFrom, yFrom, xTo, yTo, 
                                                center.x, center.y, 
                                                data.page.clip_width, data.page.clip_height, clipped);

    if (fromInside && toInside)
    {
      // Les deux points dedans → ajouter le segment entier
      line.addPoint(new PVector(xFrom, yFrom));
      line.addPoint(new PVector(xTo, yTo));
    }
    else if (fromInside && !toInside)
    {
      // Dedans → Dehors: ajouter jusqu'au bord puis fermer la ligne
      if (hasClipped)
      {
        line.addPoint(new PVector(clipped[2], clipped[3])); // Point de sortie
      }
      if (line.points.size() >= 2)
      {
        lines.add(line);
      }
      line = new SpiralLine();
    }
    else if (!fromInside && toInside)
    {
      // Dehors → Dedans: créer nouvelle ligne avec le point d'entrée
      if (hasClipped)
      {
        if (line.points.size() >= 2)
        {
          lines.add(line);
        }
        line = new SpiralLine();
        line.addPoint(new PVector(clipped[0], clipped[1])); // Point d'entrée
        line.addPoint(new PVector(xTo, yTo)); // Point final dedans
      }
    }
    else // !fromInside && !toInside
    {
      // Les deux dehors: vérifier si le segment coupe le rectangle
      if (hasClipped)
      {
        // Le segment traverse → créer nouvelle ligne avec le segment clippé
        if (line.points.size() >= 2)
        {
          lines.add(line);
        }
        line = new SpiralLine();
        line.addPoint(new PVector(clipped[0], clipped[1]));
        line.addPoint(new PVector(clipped[2], clipped[3]));
      }
      // Sinon: complètement dehors → ne rien faire
    }

    return line;
  }

  SpiralLine addPolarSegment(SpiralLine line, float radius1, float angle1, float radius2, float angle2)
  {
    float xFrom = center.x + radius1 * cos(radians(angle1));
    float yFrom = center.y + radius1 * sin(radians(angle1));
    float xTo = center.x + radius2 * cos(radians(angle2));
    float yTo = center.y + radius2 * sin(radians(angle2));
    
    return addLineSegment(line, xFrom, yFrom, xTo, yTo);
  }

  void buildOneLine(SpiralLine line, int steps, float angle, float deltaRot)
  {
    float radius = data.main.Radius;
    for (int i = 0; i < steps; i++)
    {   
      float angle2 = angle + deltaRot;
      float radius2 = radius * data.main.RatioRadius;

      line = addPolarSegment(line, radius, angle, radius2, angle2);

      angle = angle2;
      radius = radius2;
    }
    
    // Ajouter la dernière ligne seulement si elle a au moins 2 points
    if (line.points.size() >= 2)
    {
      lines.add(line);
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
    }

    if (data.main.Mirror)
    {
      rotation = -rotation;
      for (int line = 0; line < data.main.NbLines; line++)
      {
        SpiralLine spiralLine = new SpiralLine();
        angle = deltaAngle * line + data.main.StartAngle;
        buildOneLine(spiralLine, steps, angle, rotation);
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

// SpiralLine: polyline for spiral
class SpiralLine extends Polyline
{
}
