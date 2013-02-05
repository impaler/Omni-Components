package omni.components.theme.bloom;

import omni.components.theme.color.Color;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.ScrollContainer.ScrollContainerStyle;
import omni.components.gui.layout.Layout.LayoutStyle;
import nme.geom.Rectangle;
import omni.components.utils.ColorUtils;

class BloomScrollContainer extends ScrollContainerStyle
{

	public function new()
	{
		super();

		hScrollStyle = new BloomScrollBar();
		vScrollStyle = new BloomScrollBar();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState(OBaseStyle.STATE_ACTIVE, Color.BG);
		setBackgroundBrush(bgColor);

		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 20;

	}

}
