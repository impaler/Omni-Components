package omni.components.style.base.core;

import omni.components.style.brush.BrushColorFill;
import omni.components.style.base.BaseColors;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.utils.OStates;

class BaseOButtonBase extends OButtonBaseStyle
{
    public function new()
    {
        super();

        defaultWidth = 10;
        defaultHeight = 10;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG);
        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
        bgColor.setColorState(OStates.OVER, BaseColors.OVER);
        bgColor.setColorState(OStates.DOWN, BaseColors.DOWN);
        setBackgroundBrush(bgColor);
    }
}