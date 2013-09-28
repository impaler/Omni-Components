package omni.components.theme.softui.window;

import omni.components.gui.layout.window.WindowContentContainer;
import omni.components.gui.layout.window.WindowPage;
import omni.components.gui.layout.window.WindowPage.WindowPageStyle;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.utils.ColorUtils;

class SoftUIWindowPage extends WindowPageStyle
{

	public function new()
	{
		super();

		defaultContainerType = WindowContentContainer;
		defaultPadding = 10;

		var bgColor = new BrushColorFill ();
		bgColor.setColorState(OStates.ACTIVE, ColorUtils.TRANSPARENT);
		setBackgroundBrush(bgColor);

	}

}