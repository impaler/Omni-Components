package omni.components.gui.controls;

import omni.utils.OStates;
import omni.components.core.OComponentButton;
import omni.components.core.OComponentButton.OComponentButtonStyle;

class NumericStepperButton extends OComponentButton
{

//***********************************************************
//                  Component Style
//***********************************************************

    override public function get_styleId():String
    {
        return NumericStepperButtonStyle.styleString;
    }
}

class NumericStepperButtonStyle extends OComponentButtonStyle
{
    public static var styleString:String = "NumericStepperButtonStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}