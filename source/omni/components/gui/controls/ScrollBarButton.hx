package omni.components.gui.controls;

import omni.components.core.OButtonBase;

class ScrollBarButton extends OButtonBase
{

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return ScrollBarButtonStyle.styleString;
    }
}

class ScrollBarButtonStyle extends OButtonBaseStyle
{
    public static var styleString:String = "ScrollBarButtonStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}