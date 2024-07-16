
int indexControler = 0;

static final int StartX = 20;
static final int StartY = 20;

class ColorRef
{
  ColorRef(color col, String name)
  {
    this.col = col;
    this.name = name;
  }

  color col;
  String name;

  void LoadJson(JSONObject src)
  {
    col = src.getInt(name, col);
  }

  void SaveJson(JSONObject dest)
  {
    dest.setInt(name, col);
  }
}

class ColorButton
{
  color col;

  Button bt = null;
  ColorRef refColor = null;

  ColorButton(color col)
  {
    this.col = col;
  }

  void init(UI_Panel panel, ColorRef refColor)
  {
    bt = cp5.addButton("colorbt"+ indexControler)
      .setPosition(panel.xPos, panel.yPos)
      .setSize(20, 20)
      .setLabel("")
      .moveTo(panel.pageName)
      .setColorBackground(col);

    indexControler++;
    panel.xPos += 22;


    bt.plugTo(this, "onCLic");
    this.refColor = refColor;
  }

  void onCLic()
  {
    refColor.col = this.col;
  }
}

class ColorGroup
{
  ColorRef colorRef;
  String name;

  int[][] colors = {
    { 255, 255, 255  },
  
    { 255, 205, 210 }, // rose
    
    { 81, 46, 95   }, 
    { 155, 89, 182  }, 
    { 235, 222, 240 }, 
    { 21, 67, 96 }, 
    { 127, 179, 213 }, 
    { 33, 97, 140 }, 
    { 93, 173, 226 }, 
    { 14, 98, 81 }, 
    { 39, 174, 96 }, 
    { 88, 214, 141 }, 
    
    { 255, 245, 157 }, // jaunes
    { 253, 216, 53  }, 
      
    { 251, 140, 0},  // orange
    { 255, 87, 34 },  // 
    {  191, 54, 12   },  // rouges
    { 100, 30, 22 }, 
    { 192, 57, 43 }, 
    { 148, 49, 38  }, 
    
    { 93, 64, 55  }, //marrons
    { 62, 39, 35  }, 

    
    { 174, 182, 191 }, // gris
    { 44, 62, 80 }, 
    { 23, 32, 42 }, 
    { 10, 14, 19 }, 
    { 0, 0, 0  }
  };

  ColorGroup(ColorRef colorRef, String name)
  {
    this.colorRef = colorRef;
    this.name = name;
  }

  void Init(UI_Panel panel)
  {
    panel.addLabel(name);
    
    for(int i = 0; i< colors.length; i++){
        if (i != 0 && (i%8) == 0)
        {
          panel.yPos += 25;
          panel.xPos = StartX;
        }
        
        int[] colorValues = colors[i];
        new ColorButton(color(colorValues[0], colorValues[1],colorValues[2])).init(panel, colorRef);
        
    }
    
     panel.yPos += 25;
     panel.xPos = StartX;
  }
}


class UI_Panel implements ControlListener
{
  String pageName;
  ControlP5 cp5;


  float xPos = 0;
  float yPos = 0;

  int xspace = 15;

  int widthCtrl = 300;
  int heightCtrl = 20;

  void Init(String pageName, ControlP5 cp5)
  {
    this.pageName = pageName;
    this.cp5 = cp5;

    cp5.addListener(this);

    yPos = StartY;
    xPos = StartX;
  }

  public void onUIChanged()
  {
    data.changed = true;
  }

  public void controlEvent(ControlEvent theEvent) {
    onUIChanged();
  }

  Textlabel addLabel(String content)
  {
    yPos += 10;

    Textlabel l = cp5.addTextlabel("Label" + indexControler)
      .setText(content)
      .setPosition(xPos, yPos)
      .setSize(100, heightCtrl)
      .moveTo(pageName);

    yPos += 15;

    indexControler++;

    return l;
  }


  Slider addIntSlider(String field, String label, Object data_Class, int min, int max, boolean horizontal)
  {
    Slider s = addSlider( field, label, data_Class, min, max, horizontal);
    int nbTicks = (int) (max - min + 1);
    s.setNumberOfTickMarks(nbTicks);
    s.showTickMarks(false);
    s.snapToTickMarks(true);

    return s;
  }


  Slider addSlider(String field, String label, Object data_Class, float min, float max, boolean horizontal)
  {
    Slider s = cp5.addSlider(data_Class, field)
      .setLabel(label)
      .setPosition(xPos, yPos)
      .setSize(widthCtrl, heightCtrl)
      .setRange(min, max)
      .moveTo(pageName);

    if (horizontal)
    {
      xPos += xspace + widthCtrl;
    } else
    {
      yPos+=heightCtrl+2;
      xPos = StartX;
    }

    controlP5.Label l = s.getCaptionLabel();
    l.getStyle().marginTop = 0; //move upwards (relative to button size)
    l.getStyle().marginLeft = -65; //move to the right

    return s;
  }

  Toggle addToggle(String name, String label, Object data_Class)
  {
    Toggle t = cp5.addToggle(data_Class, name)
      .setLabel(label)
      .setPosition(xPos, yPos)
      .setSize(100, heightCtrl)
      .setMode(ControlP5.SWITCH)
      .moveTo(pageName);

    CColor controlerColor = t.getColor();
    int tmp = controlerColor.getActive();
    controlerColor.setActive( controlerColor.getBackground());
    controlerColor.setBackground(tmp);

    yPos+=heightCtrl+2;

    //t.setLabel("The Toggle Name");
    controlP5.Label l = t.getCaptionLabel();
    l.getStyle().marginTop = -heightCtrl + 2; //move upwards (relative to button size)
    l.getStyle().marginLeft = 10; //move to the right

    return t;
  }

  ColorPicker addColorPicker(String name, String label, Object data_Class)
  {
    addLabel(label);

    ColorPicker cp = cp5.addColorPicker(data_Class, name)

      .setPosition(xPos, yPos)
      .setSize(100, heightCtrl*3)
      .moveTo(pageName);

    yPos+=heightCtrl*3;

    return cp;
  }


  ColorGroup addColorGroup(String name, ColorRef colorRef)
  {
    ColorGroup grp = new ColorGroup(colorRef, name );

    grp.Init(this);

    return grp;
  }

  Button addButton(String name)
  {
    Button bt = cp5.addButton(name + indexControler)
      .setPosition(xPos, yPos)
      .setLabel(name)
      .setSize(100, heightCtrl)
      .moveTo(pageName);

    indexControler++;
    yPos+=heightCtrl+5;

    return bt;
  }
}
