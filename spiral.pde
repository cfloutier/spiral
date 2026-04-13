import controlP5.*;  
import processing.pdf.*;
import processing.dxf.*;
import processing.svg.*;


SpiralsData data;
DataGUI dataGui;
SpiralGenerator drawer;

PGraphics current_graphics;
ControlP5 cp5;

void setup() 
{
  size(1200, 800);

  drawer =  new SpiralGenerator();
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
  // addFileTab();
  dataGui.Init();
}

void draw()
{
  start_draw();

  pushMatrix();
  translate(width/2, height/2);
  scale(data.page.global_scale, data.page.global_scale);

  if (data.changed)
  {
    dataGui.update_ui();
  }

  drawer.draw();

  popMatrix();
  end_draw();
}
