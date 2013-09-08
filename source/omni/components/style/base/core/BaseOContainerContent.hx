package omni.components.style.base.core;

import omni.utils.ColorUtils;
import omni.components.core.OContainerContent;
import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.gui.layout.VBox;
import omni.components.gui.layout.ScrollContainer;
import omni.components.core.OContainerContent.OContainerContentStyle;
import omni.components.style.brush.BrushColorFill;

class BaseOContainerContent extends OContainerContentStyle
{
    public function new()
    {
        super();

        defaultLayoutType = VBox;
        defaultContainerType = ScrollContainer;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, ColorUtils.GREEN);
        setBackgroundBrush(bgColor);
    }
}