package omni.components.theme.softui.window;

import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OButtonBase.OButtonBaseStyle;

class SoftUIWindowScalerButton extends OButtonBaseStyle
{
	public function new()
	{
		super();

		defaultWidth = 10;
		defaultHeight = 10;
		defaultPadding = 0;

		var bgColor = new BrushColorFill ();
		bgColor.setColorState(OStates.ACTIVE, BaseColors.TRANS);
		setBackgroundBrush(bgColor);

		setBackgroundBrush(null);

	}
}