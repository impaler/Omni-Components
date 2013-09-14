package omni.components.theme.softui.scrollBar;

import omni.utils.OStates;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.gui.controls.ScrollBarButton.ScrollBarButtonStyle;
class SoftUIScrollBarButton extends ScrollBarButtonStyle
{
    public function new()
    {
        super();

        var bgColor = new BrushBitmapScale9Fill ();
	    bgColor.scaleRect = [10 , 12 , 8 , 10];
	    bgColor.setBitmapState(OStates.ACTIVE, "assets/themes/softui/button_active.png");
	    bgColor.setBitmapState(OStates.OVER, "assets/themes/softui/button_over.png");
	    bgColor.setBitmapState(OStates.DOWN, "assets/themes/softui/button_down.png");
        setBackgroundBrush(bgColor);

        defaultWidth = 50;
        defaultHeight = 50;
    }
}