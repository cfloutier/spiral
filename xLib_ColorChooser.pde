// Click handler for a GUIPanel.addColorChooser() trigger button - a named
// class rather than an anonymous one plugTo()'d inline, since Processing's
// preprocessor did not like an anonymous class with a method body used
// directly as a plugTo() argument. Also holds the trigger's own swatchButton
// so ColorChooserPopup can re-tint it after a pick (nothing else is watching
// the underlying color field for changes).
class ColorChooserTrigger
{
  String tabName;
  ColorSetter target;
  Button swatchButton;

  ColorChooserTrigger(String tabName, ColorSetter target, Button swatchButton)
  {
    this.tabName = tabName;
    this.target = target;
    this.swatchButton = swatchButton;
  }

  void onClic()
  {
    colorPopup.show(this);
  }

  void apply(color c)
  {
    target.setColor(c);
    swatchButton.setColorBackground(c);
  }
}

// A named set of swatch colors offered in the ColorChooserPopup (e.g.
// "Default", "Rainbow", ...). Just a name + the RGB triples - rendering is
// still entirely ColorGroup/ColorButton, one ColorGroup per palette.
class ColorPalette
{
  String name;
  int[][] colors;

  ColorPalette(String name, int[][] colors)
  {
    this.name = name;
    this.colors = colors;
  }
}

// Click handler for a palette-switcher button in the popup.
class PaletteSwitcher
{
  ColorChooserPopup popup;
  int index;

  PaletteSwitcher(ColorChooserPopup popup, int index)
  {
    this.popup = popup;
    this.index = index;
  }

  void onClic()
  {
    popup.showPalette(index);
  }
}

// ColorChooserPopup - shared swatch-grid popup, opened from a small trigger
// button on any tab (GUIPanel.addColorChooser()) instead of laying the full
// grid out inline (that's still what ColorGroup/addColorGroup does, unchanged).
//
// Fakes a modal the same way xLib_FileUI.pde's Load/Save browser does: parks
// its controls on ControlP5's built-in "default" tab and calls
// Tab.bringToFront() to show/hide, no backdrop, no click-blocking - clicking
// another tab header also closes it, same as the file picker.
//
// The method that opens the popup is named show(), not open() - naming it
// open() caused Processing's preprocessor to throw a "Syntax Error - Error
// on parameter or method declaration" at the *call site* (not a real Java
// error, and not reproducible with any other method name tried) - some kind
// of reserved/special-cased handling of "open" in Processing's own PDE
// grammar. Confirmed empirically: renaming the method was the only thing
// that fixed it. Avoid a method literally named `open` anywhere in xLib.
//
// One instance for the whole sketch (declared as the global `colorPopup`
// in each project's main .pde, next to `cp5` - can't be a static holder like
// GUIPanel's LabelsHandler since, unlike Textlabel, ColorGroup/GUIPanel are
// sketch-inner classes and need an enclosing instance). Reused by every
// addColorChooser() trigger; only one can be open at a time, which is fine
// since only one color is ever being picked.
//
// Multiple palettes: one ColorGroup per registered ColorPalette, all built
// (hidden) up front in ensureInit(), same hide-all/show-relevant technique
// as the palettes themselves and as xLib_FileUI.pde's picker states. A row
// of small named buttons above the grid switches which one is visible.
class ColorChooserPopup
{
  ArrayList<ColorPalette> palettes = new ArrayList<ColorPalette>();
  ArrayList<ColorGroup> _groups = new ArrayList<ColorGroup>();
  ArrayList<Button> _paletteButtons = new ArrayList<Button>();
  int _activePalette = 0;
  ColorChooserTrigger _trigger;
  boolean _initialized = false;

  // Call before the popup is first shown (e.g. right after `new
  // ColorChooserPopup()`) to add palettes beyond the built-in "Default" one.
  void registerPalette(String name, int[][] colors)
  {
    palettes.add(new ColorPalette(name, colors));
  }

  void ensureInit()
  {
    if (_initialized) return;
    _initialized = true;

    if (palettes.size() == 0)
      registerPalette("Default", DEFAULT_COLOR_PALETTE);

    float switcherX = StartX;
    float switcherY = StartY;

    for (int i = 0; i < palettes.size(); i++)
    {
      Button pb = cp5.addButton("colorpalette" + i)
        .setLabel(palettes.get(i).name)
        .setPosition(switcherX, switcherY)
        .setSize(90, 20)
        .moveTo("default");
      switcherX += 95;
      _paletteButtons.add(pb);
      pb.plugTo(new PaletteSwitcher(this, i), "onClic");
    }

    float gridY = switcherY + 30;

    ColorSetter sink = new ColorSetter()
    {
      public color getColor() { return 0; } // unused - this ColorSetter is a write-only sink
      public void setColor(color c) { pick(c); }
    };

    for (ColorPalette p : palettes)
    {
      ColorGroup g = new ColorGroup(sink, "");
      g.colors = p.colors;

      GUIPanel gridPanel = new GUIPanel("default", null);
      gridPanel.xPos = StartX;
      gridPanel.yPos = gridY;
      g.Init(gridPanel);

      for (ColorButton b : g.buttons)
        b.bt.hide();
      _groups.add(g);
    }

    for (Button pb : _paletteButtons)
      pb.hide();
  }

  color PALETTE_ACTIVE_COLOR   = color(70, 130, 220);
  color PALETTE_INACTIVE_COLOR = color(80);

  void showPalette(int idx)
  {
    for (ColorButton b : _groups.get(_activePalette).buttons)
      b.bt.hide();

    _activePalette = idx;

    for (ColorButton b : _groups.get(_activePalette).buttons)
      b.bt.show();

    for (int i = 0; i < _paletteButtons.size(); i++)
      _paletteButtons.get(i).setColorBackground(i == _activePalette ? PALETTE_ACTIVE_COLOR : PALETTE_INACTIVE_COLOR);
  }

  void show(ColorChooserTrigger trigger)
  {
    ensureInit();
    _trigger = trigger;

    for (Button pb : _paletteButtons)
      pb.show();
    showPalette(_activePalette);

    cp5.getTab("default").bringToFront();
  }

  void pick(color c)
  {
    if (_trigger != null)
      _trigger.apply(c);
    close();
  }

  void close()
  {
    for (Button pb : _paletteButtons)
      pb.hide();
    for (ColorButton b : _groups.get(_activePalette).buttons)
      b.bt.hide();

    if (_trigger != null)
      cp5.getTab(_trigger.tabName).bringToFront();
  }
}
