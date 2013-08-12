package omni.components.style.base.controls;

import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.style.base.core.BaseOButtonBase;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.Slider.SliderBaseStyle;
import omni.utils.ColorUtils;

class BaseSlider extends SliderBaseStyle
{

    public function new()
    {
        super();

        defaultStep = 10;
        defaultValue = 0;
        defaultMax = 100;
        defaultMin = 0;
        defaultType = OStates.HORIZONTAL;
        defaultValue = 50;

        defaultVHeight = 120;
        defaultVWidth = 30;

        defaultHHeight = 30;
        defaultHWidth = 120;

//        buttonStyle = new BaseSliderButton();

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG);
        setBackgroundBrush(bgColor);
    }

}
