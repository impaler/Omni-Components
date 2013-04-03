package omni.components.style.base.controls;

import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;

class BaseWindowScalerButton extends OButtonBaseStyle
{
    public function new()
    {
        super();

        defaultWidth = 20;
        defaultHeight = 20;
        defaultPadding = 0;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.ACTIVE);
        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
        bgColor.setColorState(OStates.OVER, BaseColors.OVER);
        bgColor.setColorState(OStates.DOWN, BaseColors.DOWN);
        setBackgroundBrush(bgColor);

    }
}