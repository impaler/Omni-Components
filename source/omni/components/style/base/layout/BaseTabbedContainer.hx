package omni.components.style.base.layout;

import omni.components.gui.layout.containers.PagedContainer;
import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.gui.layout.containers.PagedContainer.PagedContainerStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import flash.geom.Rectangle;

class BaseTabbedContainer extends PagedContainerStyle
{

    public function new()
    {
        super();

        defaultWidth = 300;
        defaultHeight = 300;
        defaultPadding = 10;

    }

}
