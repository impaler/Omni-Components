package omni.components.theme.color;

import omni.components.core.OTheme;
import omni.components.utils.ColorUtils;

class Color extends OTheme
{
	static public inline var DISABLED:Int = ColorUtils.LIGHT_ORANGE;
	static public inline var ACTIVE:Int = ColorUtils.DARKER_ORANGE;
	static public inline var OVER:Int = ColorUtils.ORANGE_BRIGHT;
	static public inline var DOWN:Int = ColorUtils.ORANGE;
	static public inline var BG:Int = ColorUtils.GRAY;
	static public inline var BG_LAYOUT:Int = ColorUtils.BLACK;

	public function new()
	{
		super();

		addStyle(ColorComponent);
		addStyle(ColorButtonBase);
		addStyle(ColorLayout);
		addStyle(ColorSlider);
		addStyle(ColorScrollBar);
		addStyle(ColorScrollContainer);
		addStyle(ColorTextBase);
	}
}