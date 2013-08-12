package omni.components.style.base.controls;

import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.gui.controls.ScrollBarButton.ScrollBarButtonStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;

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