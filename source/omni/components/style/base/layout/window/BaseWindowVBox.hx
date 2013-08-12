package omni.components.style.base.layout.window;

import omni.components.gui.layout.window.WindowVBox.WindowVBoxStyle;
import omni.utils.OStates;
import omni.components.style.base.BaseColors;
import omni.components.gui.layout.VBox.VBoxStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.utils.ColorUtils;
import flash.geom.Rectangle;

class BaseWindowVBox extends WindowVBoxStyle
{

    public function new()
    {
        super();

        defaultHAlign = OStates.MIDDLE;
        defaultVAlign = OStates.TOP;

        defaultPadding = 20;
        defaultTopPadding = 20;
        defaultBottomPadding = 20;
        defaultLeftPadding = 20;
        defaultRightPadding = 20;

        defaultWidthSizeMethod = OStates.AUTO;
        defaultHeightSizeMethod = OStates.AUTO;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, ColorUtils.WHITE);
        setBackgroundBrush(bgColor);
    }

}
