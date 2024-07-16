
class DataMain
{
  int NbLines =6;

  int NbSteps = 30;
  int NbStepsMultiplier = 1;

  float StartAngle = 0;


  float Rotation = 3; // first angle
  float RotationTwitch = 0;
  int RotationMultiplier = 1;

  float Radius = 300; // firts circle radius

  float RatioRadius = 0.9;

  //float LineWeight = 1;
  //float RatioWeight = 1;

  boolean Mirror = false;



  void LoadJson(JSONObject src)
  {
    if (src == null)
      return;


    NbLines = src.getInt("NbLines", NbLines);
    NbSteps = src.getInt("NbSteps", NbSteps);
    NbStepsMultiplier = src.getInt("NbStepsMultiplier", NbStepsMultiplier);
    StartAngle = src.getFloat("StartAngle2", StartAngle);
    Rotation = src.getFloat("Rotation", Rotation);
    RotationMultiplier = src.getInt("RotationMultiplier", RotationMultiplier);
    RotationTwitch = src.getFloat("RotationMultiplier", RotationTwitch);
    Radius = src.getFloat("Radius", Radius);
    RatioRadius = src.getFloat("RatioRadius", RatioRadius);
    //LineWeight = json.getFloat("LineWeight", LineWeight);
    //RatioWeight = json.getFloat("RatioWeight", RatioWeight);
    Mirror = src.getBoolean("Mirror", Mirror);
  }

  JSONObject SaveJson()
  {
    JSONObject dest = new JSONObject();


    dest.setInt("NbLines", NbLines);
    dest.setInt("NbSteps", NbSteps);

    dest.setInt("NbStepsMultiplier", NbStepsMultiplier);
    dest.setFloat("StartAngle", StartAngle);
    dest.setFloat("Rotation", Rotation);
    dest.setInt("RotationMultiplier", RotationMultiplier);
    dest.setFloat("RotationTwitch", RotationTwitch);
    dest.setFloat("Radius", Radius);
    dest.setFloat("RatioRadius", RatioRadius);
    //json.setFloat("LineWeight", LineWeight);
    //json.setFloat("RatioWeight", RatioWeight);
    dest.setBoolean("Mirror", Mirror);


    return dest;
  }
}


class MainGUI extends UI_Panel
{

  DataMain main;

  Slider NbLines;
  Slider NbSteps;
  Slider NbStepsMultiplier;
  Slider StartAngle;
  Slider Rotation;
  Slider RotationTwitch;

  Slider RotationMultiplier;
  Slider Radius;
  Slider RatioRadius;
  //Slider LineWeight;
  //Slider RatioWeight;
  Toggle Mirror;

  void setGUIValues()
  {
    NbLines.setValue(main.NbLines);
    NbSteps.setValue(main.NbSteps);
    NbStepsMultiplier.setValue(main.NbStepsMultiplier);

    StartAngle.setValue(main.StartAngle);
    Rotation.setValue(main.Rotation);

    RotationTwitch.setValue(main.RotationTwitch);

    RotationMultiplier.setValue(main.RotationMultiplier);

    Radius.setValue(main.Radius);
    RatioRadius.setValue(main.RatioRadius);
  }

  void setupControls(ControlP5 cp5)
  {
    super.Init("Main", cp5);

    main = data.main;

    addLabel("Page");

    NbLines = addSlider("NbLines", "Nb of Lines", main, 1, 36, true);
    NbSteps = addSlider("NbSteps", "Nb Steps", main, 2, 100, false);
    NbStepsMultiplier = addSlider("NbStepsMultiplier", "Nb Steps Multiplier", main, 1, 10, false);

    StartAngle = addSlider("StartAngle", "Start Angle", main, 0, 360, false);

    addLabel("Rotation");

    Rotation = addSlider( "Rotation", "Rotation", main, 0, 180, false);
    RotationTwitch = addSlider( "RotationTwitch", "Rotation Twitch", main, -3, 3, false);
    RotationMultiplier = addSlider( "RotationMultiplier", "Rotation Multiplier", main, 1, 8, false);

    addLabel("Size");

    Radius = addSlider("Radius", "Radius", main, 0, 800, false);
    RatioRadius = addSlider("RatioRadius", "Ratio Radius", main, 0.8, 1.2, false);

    Mirror = addToggle( "Mirror", "Y Mirror", main);
  }

  void update()
  {
    
  }
}
