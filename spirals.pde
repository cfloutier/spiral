import controlP5.*; //<>//
import processing.pdf.*;
import processing.dxf.*;
import processing.svg.*;


DrawingData data;
DataGUI dataGui;
DrawingGenerator spiral;

ControlP5 cp5;

void setup() 
{
    size(1200,800);
    
    spiral =  new DrawingGenerator();
    data = new DrawingData();
    dataGui = new DataGUI();
    
    spiral.center =  new PVector(800,400);
    
    setupControls();
    
    surface.setResizable(true);
    
    //noLoop();  // Run once and stop
}
   
void setupControls()
{ 
  cp5 = new ControlP5(this);
  
//  cp5.addTab("Controls");
  
  cp5.getTab("default").setLabel("Hide GUI");
                          
  dataGui.setupControls(data, cp5);     
  
  
  dataGui.setGUIValues(new DrawingData());
         
     addFileTab();
}

void addFileTab()
{
     cp5.addTab("Files");
  
      float xPos = 0;
      float yPos = 20;
      
      int widthButton = 100;
      int heightButton = 20;
                       
       cp5.addButton("LoadJson")
          .setPosition(xPos,yPos)
          .setSize(widthButton,heightButton)
          .moveTo("Files");        
      
      xPos += widthButton;
                
       cp5.addButton("SaveJson")
          .setPosition(xPos,yPos)
          .setSize(widthButton,heightButton)
          .moveTo("Files");    
      
      yPos += heightButton;
      xPos = 0;
                          
      cp5.addButton("ExportPDF")
          .setPosition(xPos,yPos)
          .setSize(widthButton,heightButton)
          .moveTo("Files");      
      
      xPos += widthButton;

      cp5.addButton("ExportDXF")
        .setPosition(xPos,yPos)
          .setSize(widthButton,heightButton)
        .moveTo("Files");      
        
        xPos += widthButton;
    
  cp5.addButton("ExportSVG")
    .setPosition(xPos,yPos)
    .setSize(widthButton,heightButton)
    .moveTo("Files");    
    
    xPos += widthButton;
}

void LoadJson()
{
  File file = new File(".");
  selectInput("Select data file ", "loadSelected", file);
}

void loadSelected(File selection) 
{
  if (selection == null) 
  {
    
  }
  else 
  {
    data.LoadJson(selection.getAbsolutePath());
    dataGui.setGUIValues(data);
  }
}


void SaveJson()
{
   selectInput("Save data file ", "saveSelected");
}


void saveSelected(File selection) 
{
  if (selection == null) 
  {
    
  }
  else 
  {
    String path = selection.getAbsolutePath();
    if (path.length() < 5 || !path.substring(path.length() - 5).equals(".json"))
        path = path + ".json";
      
    data.SaveJson(path);
  }
}


boolean record = false;
int mode  = 0;

String fileName = "";
void ExportPDF()
{
  record = true;
  mode = 0;
}

void ExportDXF()
{
  record = true;
  mode = 1;
}  

void ExportSVG()
{
  record = true;
  mode = 2;
}



void draw()
{
 
  background(0);
  
   if (record) 
   {
    // Note that #### will be replaced with the frame number. Fancy!
        
      fileName = "Export/Spiral_" + year() + "-" + month() + "-" + day() + "_" + hour() + "-" + minute() + "-" + second(); 
      if (mode == 0)
        beginRecord(PDF, fileName + ".pdf"); 
      else if (mode == 1)
        beginRecord(DXF, fileName + ".dxf"); 
      else if (mode ==2)
        beginRecord(SVG, fileName + ".svg"); 
        
        stroke(0);
   }
   else
       stroke(255);
       
    spiral.center =  new PVector(width/2,height/2);
   
    spiral.data = data;
    spiral.draw();
     
     if (record) 
     {
        endRecord();
        record = false;
     }
}
