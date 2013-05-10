package omni.components.style.base.core;

import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.ODrawable.ODrawableStyle;

class BaseODrawable extends ODrawableStyle
{
    public function new()
    {
        super();

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG);
        setBackgroundBrush(bgColor);

    }
}