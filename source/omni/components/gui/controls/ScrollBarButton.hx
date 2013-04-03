package omni.components.gui.controls;

import omni.components.core.OButtonBase;
import omni.utils.signals.OSignalType;
import omni.components.core.interfaces.IStyle;
import omni.utils.signals.OSignalMouse;
import omni.utils.signals.OCoreEvent;
import omni.components.style.base.OBaseStyle;
import omni.components.core.OCore;
import omni.components.style.base.OBaseBackgroundStyle;

import nme.events.Event;
import nme.events.MouseEvent;


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