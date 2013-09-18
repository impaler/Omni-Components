package omni.components.style.base.layout.window;

import omni.utils.ColorUtils;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.window.WindowContentContainer;
import omni.components.gui.layout.window.WindowPage;
import omni.components.gui.layout.window.WindowPage.WindowPageStyle;

class BaseWindowPage extends WindowPageStyle
{

    public function new()
    {
        super();

        defaultContainerType = WindowContentContainer;
        defaultPadding = 0;

	    var bgColor = new BrushColorFill ();
	    bgColor.setColorState(OStates.ACTIVE, ColorUtils.TRANSPARENT);
	    setBackgroundBrush(bgColor);

    }

}
