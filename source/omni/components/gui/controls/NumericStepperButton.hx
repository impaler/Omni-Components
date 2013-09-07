package omni.components.gui.controls;

import omni.components.core.OCore;
import omni.components.core.OComponentButton;
import omni.components.core.OComponentButton.OComponentButtonStyle;
import omni.utils.signals.OSignalMouse;

class NumericStepperButton extends OComponentButton
{

    override public function handleMouseDown(?e:OSignalMouse):Void
    {
        OCore.instance.disableScrolling = true;
        super.handleMouseDown(e);
    }

    override public function handleMouseUp(?e:OSignalMouse):Void
    {
        OCore.instance.disableScrolling = false;
        super.handleMouseUp(e);
    }

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