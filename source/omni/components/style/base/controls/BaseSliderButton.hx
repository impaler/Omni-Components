package omni.components.style.base.controls;

import omni.components.style.base.BaseColors;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.SliderButton.SliderButtonStyle;
import omni.utils.OStates;

class BaseSliderButton extends SliderButtonStyle
{
    public function new()
    {
        super();

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.SLIDER_BUTTON_ACTIVE);
        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
        bgColor.setColorState(OStates.OVER, BaseColors.SLIDER_BUTTON_OVER);
        bgColor.setColorState(OStates.DOWN, BaseColors.SLIDER_BUTTON_DOWN);
        setBackgroundBrush(bgColor);
    }
}