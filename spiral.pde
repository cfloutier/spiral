import controlP5.*; //<>// //<>//
import processing.pdf.*;
import processing.dxf.*;
import processing.svg.*;


Data data;
DataGUI dataGui;
DrawingGenerator drawer;

PGraphics current_graphics;
ControlP5 cp5;

void setup() 
{
  size(1200, 800);

  drawer =  new DrawingGenerator();
  data = new Data();
  dataGui = new DataGUI();
  
  setupControls();
   
  data.LoadJson("./Saved/default.json");
  data.name = "default";

  dataGui.setGUIValues();

  surface.setResizable(true);
}

void setupControls()
{ 
  cp5 = new ControlP5(this); 
  cp5.getTab("default").setLabel("Hide GUI");

  dataGui.setupControls( cp5);     
  addFileTab();
}


void draw()
{
  start_draw();

  if (!record && data.changed)
  {
    dataGui.updateUI();
  }
  
  drawer.center = new PVector(width/2, height/2);
  
  drawer.data = data;
  drawer.draw();

  end_draw();
}
