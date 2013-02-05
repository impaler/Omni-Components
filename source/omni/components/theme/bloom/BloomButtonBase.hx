package omni.components.theme.bloom;

import nme.Assets;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.OBaseStyle;
import omni.components.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.ComponentStyle;

class BloomButtonBase extends OButtonBaseStyle
{
	public function new()
	{
		super();

		var bg = new BrushBitmapScale9Fill ();
		bg.setBitmapState(OBaseStyle.STATE_ACTIVE, "assets/themes/bloom/controls/buttonBase/button_active.png");
		bg.setBitmapState(OBaseStyle.STATE_DISABLED, "assets/themes/bloom/controls/buttonBase/button_disabled.png");
		bg.setBitmapState(OButtonBaseStyle.STATE_DOWN, "assets/themes/bloom/controls/buttonBase/button_down.png");
		bg.setBitmapState(OButtonBaseStyle.STATE_OVER, "assets/themes/bloom/controls/buttonBase/button_over.png");

		var rect9 = [];
		//vertical left
		rect9[0] = Std.int(10);
		//vertical right
		rect9[1] = Std.int(110);
		//horizontal top
		rect9[2] = Std.int(10);
		//horizontal bottom
		rect9[3] = Std.int(20);

		bg.scaleRect = rect9;
		setBackgroundBrush(bg);

		defaultWidth = 200;
		defaultHeight = 50;

		setMinSizeBitmap("assets/themes/bloom/controls/buttonBase/button_active.png");
		maxWidth = 2000;
		maxHeight = 2000;
		defaultPadding = 0;
	}

}