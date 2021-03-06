package omni.components.style.base.layout.window;

import omni.components.style.base.core.BaseOContainer;
import omni.components.gui.layout.window.WindowTabbedContainer;
import omni.components.gui.layout.window.WindowContentContainer;
import omni.components.core.OContainerContent;
import omni.components.style.base.controls.BaseWindowScalerButton;
import omni.components.style.base.core.BaseOButtonBase;
import omni.components.style.base.BaseColors;
import omni.components.gui.layout.window.Window.WindowStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import omni.utils.OStates;
import flash.geom.Rectangle;

class BaseWindow extends WindowStyle
{

    public function new()
    {
        super();

//        header = new BaseWindowHeader();
//        footer = new BaseWindowFooter();
//        middlebg = new BaseWindowMiddleBG();
//
//        scalerButton = new BaseWindowScalerButton();

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.ACTIVE);
        setBackgroundBrush(bgColor);

        defaultWidth = 600;
        defaultHeight = 600;

        maxWidth = 680;
        maxHeight = 680;
        minHeight = 200;
        minWidth = 200;

        containerDefault = WindowContentContainer;

        moveable = true;
        resizeable = true;
        liveResize = true;
        resizeBehaviour = OStates.FIT;

        containerLeftPadding = 10;
        containerRightPadding = 10;
        containerTopPadding = 10;
    }

}
