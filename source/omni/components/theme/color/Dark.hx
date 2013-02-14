package omni.components.theme.color;

import omni.utils.ColorUtils;

class Dark extends Color
{

	override public function setupColors( )
	{
		Colors.DISABLED = ColorUtils.BLACK;
		Colors.ACTIVE = ColorUtils.GRAY;
		Colors.OVER = ColorUtils.LIGHT_GRAY;
		Colors.DOWN = ColorUtils.ORANGE;

		Colors.ON = ColorUtils.GRAY;
		Colors.ON_OVER = ColorUtils.GRAY;
		Colors.OFF = ColorUtils.GRAY;
		Colors.OFF_OVER = ColorUtils.GRAY;

		Colors.BG = ColorUtils.BLACK;
		Colors.BG_LAYOUT = ColorUtils.BLACK;

		Colors.STEPPER_BUTTON_ACTIVE = ColorUtils.BLACK;
		Colors.STEPPER_BUTTON_OVER = ColorUtils.LIGHT_GRAY;
		Colors.STEPPER_BUTTON_DOWN = ColorUtils.GRAY;
	}

}