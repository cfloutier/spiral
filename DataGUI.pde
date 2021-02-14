import controlP5.*; //<>// //<>//


class DataGUI
{
    ControlP5 cp5;
    void setGUIValues(DrawingData data)
    {
      NbLines.setValue(data.NbLines);
      NbSteps.setValue(data.NbSteps);
      NbStepsMultiplier.setValue(data.NbStepsMultiplier);
     
      StartAngle.setValue(data.StartAngle);
      Rotation.setValue(data.Rotation);
      RotationMultiplier.setValue(data.RotationMultiplier);
      Radius.setValue(data.Radius);
      RatioRadius.setValue(data.RatioRadius);
      //LineWeight.setValue(data.LineWeight);
      //RatioWeight.setValue(data.RatioWeight);
      Mirror.setValue(data.Mirror);
    }
    
   Slider NbLines;
   Slider NbSteps;
   Slider NbStepsMultiplier;
   Slider StartAngle;
   Slider Rotation;
   Slider RotationTwitch;
  
   Slider RotationMultiplier;
   Slider Radius;
   Slider RatioRadius;
   //Slider LineWeight;
   //Slider RatioWeight;
   Toggle Mirror;
    
    void setupControls(DrawingData data, ControlP5 cp5)
  	{ 
    
      this.cp5 = cp5;
      
  	  float xPos = 0;
  	  float yPos = 20;
  	  int widthCtrl = 500; 
  	  int heightCtrl = 20;
  	  
  		NbLines = cp5.addSlider(data, "NbLines")   
        		 .setPosition(xPos,yPos)
        		 .setSize(widthCtrl,heightCtrl)
             .setRange(1,36)
             .moveTo("Controls");
       
  		yPos+=heightCtrl;
  	  
  	  NbSteps = cp5.addSlider(data, "NbSteps")
        		 .setPosition(xPos,yPos)
        		 .setSize(widthCtrl,heightCtrl)
        		 .setRange(2,100)
             .moveTo("Controls");
  
      yPos+=heightCtrl;
  		 
      NbStepsMultiplier = cp5.addSlider(data, "NbStepsMultiplier")
              .setPosition(xPos,yPos)
              .setSize(widthCtrl,heightCtrl)
              .setRange(1,10)
              .moveTo("Controls");

  		 yPos+=heightCtrl;
      
  	  StartAngle = cp5.addSlider(data,"StartAngle")
      		 .setPosition(xPos,yPos)
      		 .setSize(widthCtrl,heightCtrl)
      		 .setRange(0,180)
           .moveTo("Controls");
  		 
  	  yPos+=heightCtrl;
  
      Rotation = cp5.addSlider(data,"Rotation")
             .setPosition(xPos,yPos)
             .setSize(widthCtrl,heightCtrl)
             .setRange(0,180)
             .moveTo("Controls");
       
      yPos+=heightCtrl;
      
      RotationTwitch = cp5.addSlider(data,"RotationTwitch")
             .setPosition(xPos,yPos)
             .setSize(widthCtrl,heightCtrl)
             .setRange(-3,3)
             .moveTo("Controls");
       
      yPos+=heightCtrl;
  	  
  		RotationMultiplier = cp5.addSlider(data,"RotationMultiplier")
      		 .setPosition(xPos,yPos)
      		 .setSize(widthCtrl,heightCtrl)
      		 .setRange(1,8)
           .moveTo("Controls");
  		 
  	  yPos+=heightCtrl;
  	  
  		Radius = cp5.addSlider(data, "Radius")
    		  .setPosition(xPos,yPos)
    		  .setSize(widthCtrl,heightCtrl)
    		  .setRange(0,800)
          .moveTo("Controls");
  
  		yPos+=heightCtrl;
  		   
  		RatioRadius = cp5.addSlider(data, "RatioRadius")
    		  .setPosition(xPos,yPos)
    		  .setSize(widthCtrl,heightCtrl)
    		  .setRange(0.8,1.2)
          .moveTo("Controls");
  		  
  		  yPos+=heightCtrl;
  		
  		/*LineWeight = cp5.addSlider(data, "LineWeight")
      		  .setPosition(xPos,yPos)
      		  .setSize(widthCtrl,heightCtrl)
      		  .setRange(0,20)
            .moveTo("Controls");
  		  
  		  yPos+=heightCtrl;
  		
  		RatioWeight = cp5.addSlider(data, "RatioWeight")
      		  .setPosition(xPos,yPos)
      		  .setSize(widthCtrl,heightCtrl)
      		  .setRange(0,1)
            .moveTo("Controls");
  		    
  		  yPos+=heightCtrl;*/
  		
  		 Mirror = cp5.addToggle(data, "Mirror")
      		  .setPosition(xPos,yPos)
      		  .setSize(100,heightCtrl)  
      		  .setMode(ControlP5.SWITCH)
            .moveTo("Controls");
  	}
}
