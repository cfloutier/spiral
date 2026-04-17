import controlP5.*;  
import processing.pdf.*;
import processing.dxf.*;
import processing.svg.*;


SpiralsData data;
DataGUI dataGui;
SpiralGenerator generator;

PGraphics current_graphics;
ControlP5 cp5;

void setup() 
{
  size(1200, 800);

  generator =  new SpiralGenerator();
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

  if (data.changed)
  {
    dataGui.update_ui();
  }

  generator.draw();
  
  // Update export scale after drawing (for next frame's export)
  if (!_record) {
    BoundingBox bbox = computeBoundingBox();
    file_ui.updateExportScale(bbox);
  }
  
  end_draw();
}

// Compute bounding box from all generator lines (specific to SpiralLine)
BoundingBox computeBoundingBox()
{
  BoundingBox bbox = new BoundingBox();
  
  for (SpiralLine line : generator.lines) {
    for (PVector point : line.points) {
      bbox.addPoint(point);
    }
  }
  
  return bbox;
}

