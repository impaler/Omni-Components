package omni.components.gui.controls;

import omni.components.core.OButtonBase;

class SliderButton extends OButtonBase
{

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return SliderButtonStyle.styleString;
    }
}

class SliderButtonStyle extends OButtonBaseStyle
{
    public static var styleString:String = "SliderButtonStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}