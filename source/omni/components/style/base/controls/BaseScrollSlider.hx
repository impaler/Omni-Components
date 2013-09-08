package omni.components.style.base.controls;

import omni.utils.OStates;
import omni.components.style.base.BaseColors;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.ScrollSlider.ScrollSliderStyle;

class BaseScrollSlider extends ScrollSliderStyle
{
    public function new()
    {
        super();

        buttonStyle = new BaseSliderButton();

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG);
        setBackgroundBrush(bgColor);

        defaultVHeight = 120;
        defaultVWidth = 10;

        defaultHHeight = 10;
        defaultHWidth = 120;

        defaultValue = 50;
    }
}