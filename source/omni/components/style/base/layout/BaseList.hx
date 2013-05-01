package omni.components.style.base.layout;

import omni.components.gui.layout.window.WindowContentContainer;
import omni.components.style.base.controls.BaseWindowScalerButton;
import omni.components.style.base.layout.window.BaseWindowHeader;
import omni.components.style.base.layout.window.BaseWindowFooter;
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
        header = new BaseWindowHeader();
        footer = new BaseWindowFooter();

        scalerButton = new BaseWindowScalerButton();

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
