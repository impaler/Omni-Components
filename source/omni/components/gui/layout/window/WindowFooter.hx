package omni.components.gui.layout.window;

import omni.components.core.OContainer;
import omni.components.core.OContainer.OContainerStyle;

class WindowFooter extends OContainer
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createComponentMembers():Void
    {
        super.createComponentMembers();
    }

    override public function destroy():Void
    {
        super.destroy();
    }

    //***********************************************************
    //                  Event Handlers
    //***********************************************************

    //***********************************************************
    //                  Properties
    //***********************************************************

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return WindowFooterStyle.styleString;
    }
}

class WindowFooterStyle extends OContainerStyle
{
    public static var styleString:String = "WindowFooterStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}