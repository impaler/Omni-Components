package omni.components.theme.softui;

import omni.components.style.brush.BrushBitmapFill;
import flash.geom.Rectangle;
import omni.utils.OStates;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.style.base.layout.BaseIcon;
import omni.components.style.base.text.BaseButtonLabel;
import omni.components.gui.controls.Button.ButtonStyle;

class SoftUIButton extends ButtonStyle
{

public function new()
{
    super();

    defaultHeight = 40;

//    defaultLabel = new SoftUILabel();
    defaultIcon = new BaseIcon();

    deafultLayoutStyle = new BaseOComponentButtonLayout();

    var bgColor = new BrushBitmapScale9Fill ();
    bgColor.scaleRect = [10 , 16 , 10 , 15];
    bgColor.setBitmapState(OStates.ACTIVE, "assets/themes/softui/button_active.png");
    bgColor.setBitmapState(OStates.OVER, "assets/themes/softui/button_over.png");
    bgColor.setBitmapState(OStates.DOWN, "assets/themes/softui/button_down.png");
    setBackgroundBrush(bgColor);

    }
}