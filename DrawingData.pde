import controlP5.*; //<>// //<>// //<>//


class DrawingData
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
    
    
       
    void LoadJson(String path)
    {
      JSONObject json = loadJSONObject(path);
      NbLines = json.getInt("NbLines", NbLines);
      NbSteps = json.getInt("NbSteps", NbSteps);
      NbStepsMultiplier = json.getInt("NbStepsMultiplier", NbStepsMultiplier);
      StartAngle = json.getFloat("StartAngle2", StartAngle);
      Rotation = json.getFloat("Rotation", Rotation);
      RotationMultiplier = json.getInt("RotationMultiplier", RotationMultiplier);
      RotationTwitch = json.getFloat("RotationMultiplier", RotationTwitch);
      Radius = json.getFloat("Radius", Radius);
      RatioRadius = json.getFloat("RatioRadius", RatioRadius);
      //LineWeight = json.getFloat("LineWeight", LineWeight);
      //RatioWeight = json.getFloat("RatioWeight", RatioWeight);
      Mirror = json.getBoolean("Mirror", Mirror);
    }
    
    void SaveJson(String path)
    {
      JSONObject json = new JSONObject();
      
      json.setInt("NbLines", NbLines);
      json.setInt("NbSteps", NbSteps);
      
      json.setInt("NbStepsMultiplier", NbStepsMultiplier);
      json.setFloat("StartAngle", StartAngle);
      json.setFloat("Rotation", Rotation);
      json.setInt("RotationMultiplier", RotationMultiplier);
      json.setFloat("RotationTwitch", RotationTwitch);
      json.setFloat("Radius", Radius);
      json.setFloat("RatioRadius", RatioRadius);
      //json.setFloat("LineWeight", LineWeight);
      //json.setFloat("RatioWeight", RatioWeight);
      json.setBoolean("Mirror", Mirror);
           
      saveJSONObject(json, path);
    }
    
}
