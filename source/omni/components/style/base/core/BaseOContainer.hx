package omni.components.style.base.core;

import omni.components.style.brush.BrushColorFill;
import omni.components.style.base.BaseColors;
import omni.components.core.OContainer.OContainerStyle;
import omni.utils.OStates;

class BaseOContainer extends OContainerStyle
{
    public function new()
    {
        super();

        defaultScrollRect = false;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG);
        setBackgroundBrush(bgColor);
    }
}