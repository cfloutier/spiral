import controlP5.*; 

class Data
{
  String name = "";

  boolean changed = true;

  Style style = new Style();
  DataMain main = new DataMain();

  float width = 800;
  float height = 600;

  void setSize(float width, float height)
  {
    if (this.width != width)
    {
      changed = true;
      this.width = width;
    }

    if (this.height != height)
    {
      changed = true;
      this.height = height;
    }
  }

  void LoadJson(String path)
  {
    print("path" + path);

    JSONObject json = loadJSONObject(path);

    main.LoadJson(json.getJSONObject("Main"));
    style.LoadJson(json.getJSONObject("Style"));
  }

  void SaveJson(String path)
  {
    JSONObject json = new JSONObject();

    json.setJSONObject("Style", style.SaveJson());
    json.setJSONObject("Main", main.SaveJson());

    saveJSONObject(json, path);
  }
}



class DataGUI
{
  StyleGUI style = new StyleGUI();
  MainGUI main = new MainGUI(); 
  
  void updateUI()
  {
    if (!data.changed)
      return;

    main.update();
    style.update();
  }

  void setupControls(ControlP5 cp5)
  { 
    cp5.addTab("Style");
    cp5.addTab("Main");
    
    main.setupControls( cp5 );    
    style.setupControls( cp5 );   
    
    cp5.getTab("Main").bringToFront();
  }
  
  void setGUIValues()
  {
    style.setGUIValues();
    main.setGUIValues();
  }
}
