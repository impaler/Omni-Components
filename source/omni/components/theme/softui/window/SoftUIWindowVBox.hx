package omni.components.theme.softui.window;

import omni.components.gui.layout.window.WindowVBox.WindowVBoxStyle;
import omni.components.style.brush.BrushColorFill;
import omni.utils.ColorUtils;
import omni.utils.OStates;

class SoftUIWindowVBox extends WindowVBoxStyle
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
		bgColor.setColorState(OStates.ACTIVE, ColorUtils.TRANSPARENT);
		setBackgroundBrush(bgColor);
	}

}
