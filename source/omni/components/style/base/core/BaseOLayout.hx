package omni.components.style.base.core;

import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import flash.geom.Rectangle;

class BaseOLayout extends OLayoutStyle
{

    public function new()
    {
        super();

        defaultScrollRect = false;

        defaultHAlign = OStates.MIDDLE;
        defaultVAlign = OStates.MIDDLE;

        defaultWidthSizeMethod = OStates.AUTO;
        defaultHeightSizeMethod = OStates.AUTO;

        defaultWidth = 300;
        defaultHeight = 300;
        defaultPadding = 0;
        defaultBottomPadding = 0;
        defaultTopPadding = 0;
        defaultLeftPadding = 0;
        defaultRightPadding = 0;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG_LAYOUT);
        setBackgroundBrush(bgColor);
    }
}
