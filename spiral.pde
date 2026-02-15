import controlP5.*;  
import processing.pdf.*;
import processing.dxf.*;
import processing.svg.*;


SpiralsData data;
DataGUI dataGui;
DrawingGenerator drawer;

PGraphics current_graphics;
ControlP5 cp5;

void setup() 
{
  size(1200, 800);

  drawer =  new DrawingGenerator();
  data = new SpiralsData();
  dataGui = new DataGUI(data);
  
  setupControls();
   
  data.LoadSettings("./Saved/default.json");
  data.name = "default";

  dataGui.setGUIValues();

  surface.setResizable(true);
}

void setupControls()
{ 
  cp5 = new ControlP5(this);
  cp5.getTab("default").setLabel("Hide GUI");
  addFileTab();
  dataGui.Init();
}

void draw()
{
  start_draw();

  // recenter
  pushMatrix();
  translate(width/2, height/2);
  scale(data.page.global_scale,data.page .global_scale);
 // translate(-width/2, -height/2);

  if (data.changed)
  {
    dataGui.update_ui();
  }
  
  // drawer.center = new PVector(width/2, height/2);
  
  drawer.data = data;
  drawer.draw();

  popMatrix();
  end_draw();
}
