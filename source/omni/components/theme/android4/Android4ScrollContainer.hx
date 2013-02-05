package omni.components.theme.android4;

import omni.components.theme.color.ColorScrollBar;
import omni.components.theme.bloom.BloomScrollBar;
import omni.components.theme.color.Color;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.ScrollContainer.ScrollContainerStyle;
import omni.components.gui.layout.Layout.LayoutStyle;
import nme.geom.Rectangle;
import omni.components.utils.ColorUtils;

class Android4ScrollContainer extends ScrollContainerStyle
{

	public function new()
	{
		super();

		hScrollStyle = new ColorScrollBar();
		vScrollStyle = new ColorScrollBar();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState(OBaseStyle.STATE_ACTIVE, Color.BG);
		setBackgroundBrush(bgColor);

		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 20;

	}

}
