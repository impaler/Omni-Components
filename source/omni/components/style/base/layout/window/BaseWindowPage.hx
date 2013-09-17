package omni.components.style.base.layout.window;

import omni.components.gui.layout.window.WindowContentContainer;
import omni.components.gui.layout.window.WindowPage;
import omni.components.gui.layout.window.WindowPage.WindowPageStyle;

class BaseWindowPage extends WindowPageStyle
{

    public function new()
    {
        super();

        defaultContainerType = WindowContentContainer;
        defaultPadding = 10;

    }

}
