package omni.components.style.base.layout;

import omni.utils.OStates;
import omni.components.style.base.BaseColors;
import omni.components.gui.layout.VBox.VBoxStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.utils.ColorUtils;
import flash.geom.Rectangle;

class BaseVBox extends VBoxStyle
{

    public function new()
    {
        super();

        defaultHAlign = OStates.MIDDLE;
        defaultVAlign = OStates.MIDDLE;

        defaultWidthSizeMethod = OStates.AUTO;
        defaultHeightSizeMethod = OStates.AUTO;

        defaultWidth = 160;
        defaultHeight = 220;

        defaultPadding = 10;
        defaultBottomPadding = 0;
        defaultTopPadding = 0;
        defaultLeftPadding = 0;
        defaultRightPadding = 0;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG_VBOX);
        setBackgroundBrush(bgColor);
    }

}
