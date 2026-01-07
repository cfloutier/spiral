
class DataMain extends GenericData
{
  DataMain()
  {  
    super("Main");
  }

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
}


class MainGUI extends GUIPanel
{

  DataMain main;
  MainGUI(DataMain main)
  {
    super("Main", main);
    this.main = main;
  }

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

  void setupControls()
  {
    super.Init();

    main = data.main;

    addLabel("Page");

    NbLines = addIntSlider("NbLines", "Nb of Lines", 1, 36);
    nextLine();
    NbSteps = addIntSlider("NbSteps", "Nb Steps", 2, 100);
    NbStepsMultiplier = addIntSlider("NbStepsMultiplier", "Nb Steps Multiplier", 1, 10);
    StartAngle = addSlider("StartAngle", "Start Angle", 0, 360);

    nextLine();
    addLabel("Rotation");

    Rotation = addSlider( "Rotation", "Rotation", 0, 180);
    RotationTwitch = addSlider( "RotationTwitch", "Rotation Twitch", -3, 3);
    RotationMultiplier = addIntSlider( "RotationMultiplier", "Rotation Multiplier", 1, 8);

    nextLine();
    addLabel("Size");

    Radius = addSlider("Radius", "Radius", 0, 800);
    RatioRadius = addSlider("RatioRadius", "Ratio Radius", 0.8, 1.2);
    nextLine();
    Mirror = addToggle( "Mirror", "Y Mirror");
  }

  void update_ui()
  {

  }
}
