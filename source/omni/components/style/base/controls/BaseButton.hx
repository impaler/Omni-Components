package omni.components.style.base.controls;

import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.style.brush.BrushColorFill;
import omni.components.style.base.BaseColors;
import omni.components.gui.controls.Button.ButtonStyle;
import omni.utils.OStates;

class BaseButton extends ButtonStyle
{
    public function new()
    {
        super();

        defaultHeight = 40;
        deafultLayoutStyle = new BaseOComponentButtonLayout();

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.ACTIVE);
        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
        bgColor.setColorState(OStates.OVER, BaseColors.OVER);
        bgColor.setColorState(OStates.DOWN, BaseColors.DOWN);
        setBackgroundBrush(bgColor);
    }
}