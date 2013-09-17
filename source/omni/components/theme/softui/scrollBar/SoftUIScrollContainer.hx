package omni.components.theme.softui.scrollBar;

import omni.components.style.base.BaseColors;
import omni.components.style.brush.BrushColorFill;
import omni.utils.OStates;
import omni.components.gui.layout.ScrollContainer.ScrollContainerStyle;

class SoftUIScrollContainer extends ScrollContainerStyle
{

    public function new()
    {
        super();

        hContentAlign = OStates.MIDDLE;
        scrollButtonSize = 30;
        scrollStep = 80;
        tweenEnabled = true;
        tweenBackSpeed = 2;
        speedLimit = 1;
        ratio = .8;
        decel = .96;
        mouseWheelV = true;
        touchTolerance = 10;

	    scrollH = false;
	    scrollV = true;

        hScrollStyle = new SoftUIScrollBar();
        vScrollStyle = new SoftUIScrollBar();

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG_LAYOUT);
        setBackgroundBrush(bgColor);

        defaultWidth = 300;
        defaultHeight = 300;
        defaultPadding = 0;

    }

}