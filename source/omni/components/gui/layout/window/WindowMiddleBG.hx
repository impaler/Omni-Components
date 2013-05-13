package omni.components.gui.layout.window;

import omni.components.core.ODrawable;
import omni.components.gui.layout.VBox.VBoxStyle;

class WindowMiddleBG extends ODrawable
{

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return WindowMiddleBGStyle.styleString;
    }
}

class WindowMiddleBGStyle extends ODrawableStyle
{
    public static var styleString:String = "WindowMiddleBGStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }

}