package omni.components.style.base.controls;

import omni.components.gui.controls.SlideToggle.SlideToggleStyle;
import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.style.base.text.BaseButtonLabel;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OToggleButton.OToggleButtonStyle;

class BaseSlideToggle extends SlideToggleStyle
{
    public function new()
    {
        super();

        var bgColor = new BrushColorFill ();

        bgColor.setColorState(OStates.ON, BaseColors.ON);
        bgColor.setColorState(OStates.ON_OVER, BaseColors.ON_OVER);
        bgColor.setColorState(OStates.OFF, BaseColors.OFF);
        bgColor.setColorState(OStates.OFF_OVER, BaseColors.OFF_OVER);
        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
        setBackgroundBrush(bgColor);

        defaultLabel = null;
        //black in bg
        deafultLayoutStyle = null;
        defaultState = OStates.OFF;


        defaultWidth = 500;

    }
}