package omni.components.style.base.layout;

import omni.components.gui.layout.containers.PagedContainer;
import omni.components.gui.layout.containers.PagedContainer.PagedContainerStyle;

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
