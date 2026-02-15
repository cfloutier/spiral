import java.util.Locale;

Slider slider_crop_width;
Slider slider_crop_height;

void addFileTab()
{
  cp5.addTab("Files");
  
  println("addFileTab");

  float xPos = 0;
  float yPos = 20;

  int widthButton = 100;
  int heightButton = 20;

  cp5.addButton("LoadJson")
    .setPosition(xPos, yPos)
    .setSize(widthButton, heightButton)
    .moveTo("Files");        

  xPos += widthButton;

  cp5.addButton("SaveJson")
    .setPosition(xPos, yPos)
    .setSize(widthButton, heightButton)
    .moveTo("Files");    

  yPos += heightButton;
  xPos = 0;

  cp5.addButton("ExportPDF")
    .setPosition(xPos, yPos)
    .setSize(widthButton, heightButton)
    .moveTo("Files");      

  xPos += widthButton;

  cp5.addButton("ExportSVG")
    .setPosition(xPos, yPos)
    .setSize(widthButton, heightButton)
    .moveTo("Files");

 // xPos += widthButton;
  
  yPos += heightButton+20;
  xPos = 0;
  
  scale_slider = new ScaleSlider(cp5, "");
  
  scale_slider.setLabel("Global Scale")
      .setPosition(xPos, yPos)
      .setSize(200, heightButton)
      .setRange(-9, 9)
      .moveTo("Files")
      .setValue(0)
      .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0);
      
 xPos += 210;
      
  cp5.addButton("Reset_Scale")
    .setPosition(xPos, yPos)
    .setSize(widthButton, heightButton)
    .moveTo("Files");

  xPos = 0;
  yPos += heightButton+20;

  cp5.addToggle("onCrop")
    .setPosition(xPos, yPos)
    .setSize(widthButton, heightButton)
    .moveTo("Files")
    .getCaptionLabel().align(ControlP5.LEFT, ControlP5.TOP_OUTSIDE).setPaddingX(0);
    
  xPos = 0;
  yPos += heightButton+10;

  slider_crop_width = cp5.addSlider("on_crop_width")
      .setLabel("Width")
      .setPosition(xPos, yPos)
      .setSize(200, heightButton)
      .setRange(0, 2000)
      .setValue(data.crop_width)  
      .moveTo("Files")
      .hide();
      
  yPos += heightButton+10;
 
  slider_crop_height = cp5.addSlider("on_crop_height")
      .setLabel("Height")
      .setPosition(xPos, yPos)
      .setSize(200, heightButton)
      .setRange(0, 2000)
      .setValue(data.crop_height)
      .moveTo("Files")
      .hide();
}

void on_crop_height(float value) {  data.crop_height = value; }
void on_crop_width(float value) {  data.crop_width = value; }

void onCrop()
{
  data.crop = !data.crop;

  if (data.crop)
  {
    slider_crop_width.show();
    slider_crop_height.show();
  }
  else 
  {    
    slider_crop_width.hide();
    slider_crop_height.hide();
  }
}

ScaleSlider scale_slider;

void Reset_Scale()
{
  scale_slider.setValue(0);
}

//subclass slider
public class ScaleSlider extends Slider{
  //constructor
  public ScaleSlider( ControlP5 cp5 , String name ) {
    super(cp5,name);
    
  }
  
  void computeScale()
  {
    float value =  getValue();
    if (value >= 0)
    {
       data.global_scale = 1 + value;
       getValueLabel().setText(String.format(Locale.US, " x %.1f", 1 + value));
    }
    else
    {
      data.global_scale = 1 / (1-value);
      getValueLabel().setText(String.format(Locale.US, " / %.1f", 1 - value));
    }
    
  }

  @Override public Slider setValue( float theValue ) {
    super.setValue(theValue);
    computeScale();
    return this;
  }

} 

void LoadJson()
{
  println("LoadJson ");
  selectInput("Select data file ", "loadSelected", dataFile("../Settings/default.json")  );
}

void loadSelected(File selection) 
{
  if (selection != null) 
  {
    data.LoadSettings(selection.getAbsolutePath());
    dataGui.setGUIValues();
  }
}

void SaveJson()
{
  selectInput("Save data file ", "saveSelected", dataFile("../Settings/default.json"));
}

void saveSelected(File selection) 
{
  if (selection == null) 
  {
  } else 
  {
    String path = selection.getAbsolutePath();
    if (path.length() < 5 || !path.substring(path.length() - 5).equals(".json"))
      path = path + ".json";

    data.SaveSettings(path);
    
    String name = selection.getName();
    if (name.endsWith(".json"))
      data.name = name.substring(0, name.length() - 5);
    else
      data.name = name;
  }
}

boolean _record = false;
int mode  = 0;

String fileName = "";
void ExportPDF()
{
  _record = true;
  mode = 0;
}

void ExportDXF()
{
  _record = true;
  mode = 1;
}  

void ExportSVG()
{
  _record = true;
  mode = 2;
}

void start_draw()
{
  dataGui.update_ui();

  if (data.changed)
  {
    if (data.auto_save)
      data.save();

    data.changed = false;
  }

  if (_record) 
  {
    String name = data.name;
    if (name == "")
      name = "default";
      
    float sizeMultiplier = 1;
    
    println("saving " + name);
      
   // sizeMultiplier = (float) width  / 28;
      
    float newWidth = width * sizeMultiplier;
    float newheight = height * sizeMultiplier;
      
    fileName = "Export/"+ name + "_" + year() + "-" + month() + "-" + day() + "_" + hour() + "-" + minute() + "-" + second(); 
    
    if (mode == 0)
       current_graphics = createGraphics((int)newWidth, (int)newheight, PDF, fileName+ ".pdf");       
    else if (mode == 1)
      current_graphics = createGraphics((int)newWidth, (int)newheight, DXF, fileName+ ".dxf");       
    else if (mode ==2)
      current_graphics = createGraphics((int)newWidth, (int)newheight, SVG, fileName+ ".svg");       
    
    data.setSize(newWidth, newheight); 
    
    current_graphics.beginDraw();
    current_graphics.strokeWeight(data.style.lineWidth*sizeMultiplier);
    
    current_graphics.rotate(-PI/2);
    current_graphics.translate(-newWidth,newheight/2);
    
  } else {
    
    current_graphics = g;

    background(data.style.backgroundColor.col);
    strokeWeight(data.style.lineWidth);
    stroke(data.style.lineColor.col);
    
    current_graphics = g;

    data.setSize(width, height);
  } 
}

void end_draw()
{
  if (_record) 
  {
    current_graphics.dispose();
    current_graphics.endDraw();
    _record = false;
  }
}
