package omni.components.style.base.layout;

import omni.components.core.OContainerPage;
import omni.utils.OStates;
import omni.components.core.OContainerContent;
import omni.components.core.OContainerPage.OContainerPageStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import flash.geom.Rectangle;

class BaseContainerPage extends OContainerPageStyle
{

    public function new()
    {
        super();

        defaultContainerType = OContainerContent;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, ColorUtils.GREEN);
        setBackgroundBrush(bgColor);

        defaultWidth = 400;
        defaultHeight = 400;
        defaultPadding = 10;

    }

}
