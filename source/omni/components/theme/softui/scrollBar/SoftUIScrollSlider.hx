package omni.components.theme.softui.scrollBar;

import omni.utils.OStates;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.gui.controls.ScrollSlider.ScrollSliderStyle;

class SoftUIScrollSlider extends ScrollSliderStyle
{
    public function new()
    {
        super();

        var bgColor = new BrushBitmapScale9Fill ();
        bgColor.scaleRect = [4 , 6 , 6 , 20];
        bgColor.setBitmapState(OStates.ACTIVE, "assets/themes/softui/scrollBar_vertical.png");
        setBackgroundBrush(bgColor);
    }

}