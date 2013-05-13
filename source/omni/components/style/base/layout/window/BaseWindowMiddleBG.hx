package omni.components.style.base.layout.window;

import omni.components.style.base.BaseColors;
import omni.components.gui.layout.window.WindowMiddleBG.WindowMiddleBGStyle;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.ODrawable.ODrawableStyle;

class BaseWindowMiddleBG extends WindowMiddleBGStyle
{
    public function new()
    {
        super();

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG);
        setBackgroundBrush(bgColor);

    }
}