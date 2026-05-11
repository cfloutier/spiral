class SpiralGenerator //<>//
{
  PolylineGroup group;

  PVector center = new PVector(0, 0);
  
  SpiralGenerator()
  {
    group = new PolylineGroup();
  }

  void buildOneLine(int steps, float angle, float deltaRot)
  {
    SpiralLine line = new SpiralLine();
    float radius = data.main.Radius;

    line.addPoint(new PVector(
      center.x + radius * cos(radians(angle)),
      center.y + radius * sin(radians(angle))
    ));

    for (int i = 0; i < steps; i++)
    {
      float angle2 = angle + deltaRot;
      float radius2 = radius * data.main.RatioRadius;

      line.addPoint(new PVector(
        center.x + radius2 * cos(radians(angle2)),
        center.y + radius2 * sin(radians(angle2))
      ));

      angle = angle2;
      radius = radius2;
    }

    if (line.size() >= 2)
    {
      group.add(line);
    }
  }

  void update()
  {
    group.clear();

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
      angle = deltaAngle * line + data.main.StartAngle;
      buildOneLine(steps, angle, rotation);
    }

    if (data.main.Mirror)
    {
      rotation = -rotation;
      for (int line = 0; line < data.main.NbLines; line++)
      {
        angle = deltaAngle * line + data.main.StartAngle;
        buildOneLine(steps, angle, rotation);
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

    group.draw(data.page.clipping, data.page.clip_width, data.page.clip_height);
  }
}

// SpiralLine: polyline for spiral
class SpiralLine extends Polyline
{
}
