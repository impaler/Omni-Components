package omni.components.theme.softui;

import omni.components.gui.layout.window.WindowTabbedContainer;
import omni.components.gui.layout.containers.PagedContainer;
import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.gui.layout.containers.PagedContainer.PagedContainerStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import flash.geom.Rectangle;

class SoftUIWindowTabbedContainer extends WindowTabbedContainerStyle
{

    public function new()
    {
        super();

        background = null;

        defaultWidth = 400;
        defaultHeight = 400;
        defaultPadding = 0;

    }

}
