package omni.components.theme.softui;

import omni.utils.OStates;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.gui.controls.SliderButton.SliderButtonStyle;

class SoftUISliderButton extends SliderButtonStyle
{
    public function new()
    {
        super();

        defaultHeight = 40;

        var bgColor = new BrushBitmapScale9Fill ();
        //bgColor.debuglines = true;
        bgColor.scaleRect = [10 , 12 , 8 , 10];
        bgColor.setBitmapState(OStates.ACTIVE, "assets/themes/softui/button_active.png");
        bgColor.setBitmapState(OStates.OVER, "assets/themes/softui/button_over.png");
        bgColor.setBitmapState(OStates.DOWN, "assets/themes/softui/button_down.png");
        setBackgroundBrush(bgColor);
    }
}
