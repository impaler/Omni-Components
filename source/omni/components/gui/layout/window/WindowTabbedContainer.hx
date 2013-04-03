package omni.components.gui.layout.window;

import omni.components.gui.layout.containers.PagedContainer;
import omni.components.core.OContainerPage;

class WindowTabbedContainer extends PagedContainer
{

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return WindowTabbedContainerStyle.styleString;
    }
}

class WindowTabbedContainerStyle extends PagedContainerStyle
{
    public static var styleString:String = "WindowTabbedContainer";

    public function new()
    {
        super();
        styleID = styleString;
    }
}