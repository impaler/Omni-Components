package omni.components.theme.softui.scrollBar;

import omni.components.gui.controls.ScrollBarButton.ScrollBarButtonStyle;
import omni.components.style.brush.BrushBitmapFill;
import flash.geom.Rectangle;
import omni.utils.OStates;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.style.base.layout.BaseIcon;
import omni.components.style.base.text.BaseButtonLabel;
import omni.components.gui.controls.Button.ButtonStyle;

class SoftUIScrollSliderButton extends ScrollBarButtonStyle
{

public function new()
{
    super();

    var bgColor = new BrushBitmapScale9Fill ();
    bgColor.scaleRect = [4 , 6 , 2 , 10];
    bgColor.setBitmapState(OStates.ACTIVE, "assets/themes/softui/scrollBar_vertical_button_up.png");
    //bgColor.setBitmapState(OStates.OVER, "assets/themes/softui/button_over.png");
    //bgColor.setBitmapState(OStates.DOWN, "assets/themes/softui/button_down.png");
    setBackgroundBrush(bgColor);

    }
}