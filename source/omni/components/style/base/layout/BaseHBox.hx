package omni.components.style.base.layout;

import omni.components.style.base.BaseColors;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.HBox.HBoxStyle;
import omni.utils.OStates;

class BaseHBox extends HBoxStyle
{

    public function new()
    {
        super();

        defaultVAlign = OStates.MIDDLE;
        defaultHAlign = OStates.MIDDLE;

        defaultWidthSizeMethod = OStates.AUTO;
        defaultHeightSizeMethod = OStates.AUTO;

        defaultWidth = 220;
        defaultHeight = 160;

        defaultPadding = 10;
        defaultBottomPadding = 0;
        defaultTopPadding = 0;
        defaultLeftPadding = 0;
        defaultRightPadding = 0;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG_HBOX);
        setBackgroundBrush(bgColor);
    }

}
