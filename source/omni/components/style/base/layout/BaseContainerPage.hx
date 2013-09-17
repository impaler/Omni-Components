package omni.components.style.base.layout;

import omni.components.core.OContainerPage;
import omni.components.core.OContainerContent;
import omni.components.core.OContainerPage.OContainerPageStyle;
import omni.components.style.brush.BrushColorFill;
import omni.utils.ColorUtils;
import omni.utils.OStates;

class BaseContainerPage extends OContainerPageStyle
{
    public function new()
    {
        super();

        defaultContainerType = OContainerContent;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.BG);
        setBackgroundBrush(bgColor);

        defaultWidth = 400;
        defaultHeight = 400;
        defaultPadding = 10;
    }
}
