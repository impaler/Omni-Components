package omni.components.style.base.core;

import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponentButton.OComponentButtonLayoutStyle;
import omni.utils.OStates;

class BaseOComponentButtonLayout extends OComponentButtonLayoutStyle
{

    public function new()
    {
        super();

        defaultPadding = 10;
        defaultTopPadding = 10;
        defaultLeftPadding = 10;
        defaultRightPadding = 10;
        defaultBottomPadding = 10;

        defaultDirection = OStates.HORIZONTAL;

        defaultHAlign = OStates.LEFT;
        defaultVAlign = OStates.MIDDLE;

        defaultWidthSizeMethod = OStates.AUTO;
        defaultHeightSizeMethod = OStates.AUTO;
    }

}
