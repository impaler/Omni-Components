package omni.components.theme.softui;

import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.style.base.BaseColors;
import omni.components.style.brush.BrushColorFill;
import omni.utils.OStates;
import omni.components.gui.controls.Slider.SliderBaseStyle;

class SoftUISlider extends SliderBaseStyle
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

        var bgColor = new BrushBitmapScale9Fill ();
        bgColor.scaleRect = [10 , 26 , 8 , 12];
        bgColor.setBitmapState(OStates.ACTIVE, "assets/themes/softui/SliderBg.png");
        setBackgroundBrush(bgColor);
    }

}
