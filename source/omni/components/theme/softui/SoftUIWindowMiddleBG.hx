package omni.components.theme.softui;

import omni.components.gui.layout.window.WindowMiddleBG.WindowMiddleBGStyle;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.ODrawable.ODrawableStyle;

class SoftUIWindowMiddleBG extends WindowMiddleBGStyle
{
    public function new()
    {
        super();

        var bgColor = new BrushBitmapScale9Fill ();
        bgColor.scaleRect = [3, 31, 2, 4];
        bgColor.setBitmapState(OStates.ACTIVE, "assets/themes/softui/windowBg_middle.png");
        setBackgroundBrush(bgColor);
    }
}