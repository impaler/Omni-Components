package omni.components.style.base.core;

import omni.components.core.OComponentButton.OComponentButtonLayoutStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.style.base.BaseColors;
import omni.components.core.OToggleButton.OToggleButtonStyle;
import omni.utils.OStates;

class BaseOToggleButton extends OToggleButtonStyle
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

        defaultHeight = 100;
        defaultWidth = 100;

        deafultLayoutStyle = new OComponentButtonLayoutStyle();
        deafultLayoutStyle.defaultDirection = OStates.HORIZONTAL;
        deafultLayoutStyle.defaultWidthSizeMethod = OStates.FIXED;
        deafultLayoutStyle.defaultHeightSizeMethod = OStates.FIXED;

        defaultLabel = null;
        defaultState = OStates.OFF;
    }
}