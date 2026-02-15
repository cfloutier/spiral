import controlP5.*; 

class SpiralsData extends DataGlobal
{
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
  FileGUI file_ui;

  public DataGUI(SpiralsData data)
  {
    this.data = data;

    file_ui = new FileGUI(data);
    main_ui = new MainGUI(data.main); 
    style_ui = new StyleGUI(data.style); 
  }
  
  void Init()
  {
    addTab(file_ui);
    addTab(style_ui);
    addTab(main_ui);
    super.Init();

    cp5.getTab("Files").bringToFront();
  } 
} 
