package omni.components.style.base.controls;

import omni.utils.OStates;
import omni.components.style.base.BaseColors;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.ScrollBarButton.ScrollBarButtonStyle;

class BaseScrollSliderButton extends ScrollBarButtonStyle
{
    public function new()
    {
        super();

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.SCROLLBAR_SLIDER_BUTTON_ACTIVE);
        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
        bgColor.setColorState(OStates.OVER, BaseColors.SCROLLBAR_SLIDER_BUTTON_OVER);
        bgColor.setColorState(OStates.DOWN, BaseColors.SCROLLBAR_SLIDER_BUTTON_DOWN);
        setBackgroundBrush(bgColor);
    }
}