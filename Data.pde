import controlP5.*; 

class SpiralsData extends DataGlobal
{
  String name = "";

  boolean changed = true;

  Style style = new Style();
  DataMain main = new DataMain();

  SpiralsData()
  {
    addChapter(main);
    addChapter(style);

  }

  void reset()
  {
    main.CopyFrom(new DataMain());
    
  }
}

class DataGUI extends MainPanel
{
  SpiralsData data;

  MainGUI main_ui;
  StyleGUI style_ui;

  public DataGUI(SpiralsData data)
  {
    this.data = data;

    main_ui = new MainGUI(data.main); 
    style_ui = new StyleGUI(data.style); 
  }
  
  void Init()
  {
    addTab(style_ui);
    addTab(main_ui);
    super.Init();

    cp5.getTab("Files").bringToFront();
  } 
} 
