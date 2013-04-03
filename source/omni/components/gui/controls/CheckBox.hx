package omni.components.gui.controls;

import omni.components.core.OToggleButton;

class CheckBox extends OToggleButton
{

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return CheckBoxStyle.styleString;
    }

}

class CheckBoxStyle extends OToggleButtonStyle
{
    public static var styleString:String = "CheckBoxStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}
