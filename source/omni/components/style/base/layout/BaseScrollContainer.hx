package omni.components.style.base.layout;

import omni.components.style.base.controls.BaseScrollBar;
import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.core.OLayout;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.ScrollContainer.ScrollContainerStyle;
import omni.components.core.OLayout.OLayoutStyle;
import nme.geom.Rectangle;
import omni.utils.ColorUtils;

class BaseScrollContainer extends ScrollContainerStyle
{

    public function new()
    {
        super();

        hScrollStyle = new BaseScrollBar();
        vScrollStyle = new BaseScrollBar();

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG_LAYOUT);
        setBackgroundBrush(bgColor);

        defaultWidth = 300;
        defaultHeight = 300;
        defaultPadding = 20;

    }

}
