package omni.components.core;

import omni.components.style.base.OBaseBackgroundStyle;

class ODrawable extends OComponent
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    //***********************************************************
    //                  Properties
    //***********************************************************

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return ODrawableStyle.styleString;
    }
}

class ODrawableStyle extends OBaseBackgroundStyle
{
    public static var styleString:String = "ODrawableStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}
