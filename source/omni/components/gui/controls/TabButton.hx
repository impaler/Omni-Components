package omni.components.gui.controls;

import omni.utils.signals.OSignalT;
import omni.components.core.OContainerPage;
import omni.components.core.OToggleButton;
import omni.utils.signals.OSignalMouse;

class TabButton extends OToggleButton
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var containerPage:OContainerPage;

    //***********************************************************
    //                  Event Handlers
    //***********************************************************

    override public function createComponentMembers():Void
    {
        super.createComponentMembers();
        onChange = new OSignalT<TabButton>();
    }

    override public function handleMouseDown(?e:OSignalMouse):Void
    {
        if (_value == true)
        {
            return;
        }
        super.handleMouseDown(e);
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return TabButtonStyle.styleString;
    }

}

class TabButtonStyle extends OToggleButtonStyle
{
    public static var styleString:String = "TabButtonStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}
