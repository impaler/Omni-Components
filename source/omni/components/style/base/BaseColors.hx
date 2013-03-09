package omni.components.style.base;

import omni.utils.ColorUtils;
import omni.utils.ColorUtils;

class BaseColors
{

	static public var DISABLED:Int = ColorUtils.GRAY;
	static public var ACTIVE:Int = ColorUtils.DARKER_ORANGE;

	static public var ON:Int = ColorUtils.ORANGE;
	static public var ON_OVER:Int = ColorUtils.DARKER_ORANGE;
	
	static public var OFF:Int = ColorUtils.LIGHT_ORANGE;
	static public var OFF_OVER:Int = ColorUtils.ORANGE;

	static public var OVER:Int = ColorUtils.ORANGE_BRIGHT;
	static public var DOWN:Int = ColorUtils.ORANGE;
	static public var BG:Int = ColorUtils.GRAY;
	static public var BG_LAYOUT:Int = ColorUtils.BLACK;

	static public var STEPPER_BUTTON_ACTIVE:Int = ColorUtils.HALO_ORANGE;
	static public var STEPPER_BUTTON_OVER:Int = ColorUtils.LIGHT_ORANGE;
	static public var STEPPER_BUTTON_DOWN:Int = ColorUtils.DARKER_ORANGE;

	static public var LABEL_TEXT:Int = ColorUtils.GRAY;
	static public var INPUT_TEXT:Int = ColorUtils.GRAY;

	static public var SCROLLBAR_BUTTON_ACTIVE:Int = ColorUtils.HALO_BLUE;
	static public var SCROLLBAR_BUTTON_OVER:Int = ColorUtils.darker( ColorUtils.HALO_BLUE );
	static public var SCROLLBAR_BUTTON_DOWN:Int = ColorUtils.brighter( ColorUtils.HALO_BLUE );

	static public var SCROLLBAR_SLIDER_BUTTON_ACTIVE:Int = ColorUtils.GREEN;
	static public var SCROLLBAR_SLIDER_BUTTON_OVER:Int = ColorUtils.darker( ColorUtils.GREEN );
	static public var SCROLLBAR_SLIDER_BUTTON_DOWN:Int = ColorUtils.brighter( ColorUtils.GREEN );

}
