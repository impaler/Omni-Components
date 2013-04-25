package omni.components.style.base.layout;

import omni.components.gui.layout.list.List.ListStyle;
import omni.utils.OStates;
import omni.components.style.base.BaseColors;
import omni.components.gui.layout.VBox.VBoxStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class BaseList extends ListStyle
{

    public function new()
    {
        super();

        //defaultDirection = OStates.VERTICAL;

        //defaultLayoutStyle = new OLayoutStyle();

        //defaultHAlign = OStates.MIDDLE;
        //defaultVAlign = OStates.MIDDLE;

        //defaultLayoutStyle.defaultWidthSizeMethod = OStates.AUTO;
        //defaultLayoutStyle.defaultHeightSizeMethod = OStates.AUTO;
        //defaultLayoutStyle.defaultPadding = 10;

        defaultWidth = 160;
        defaultHeight = 220;

        defaultPadding = 10;
        //defaultBottomPadding = 0;
        //defaultTopPadding = 0;
        //defaultLeftPadding = 0;
        //defaultRightPadding = 0;


        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG_VBOX);
        setBackgroundBrush(bgColor);
    }

}
