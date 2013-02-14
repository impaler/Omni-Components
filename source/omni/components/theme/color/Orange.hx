package omni.components.theme.color;

import omni.utils.ColorUtils;

class Orange extends Color
{

	override public function setupColors( )
	{
		Colors.DISABLED = ColorUtils.LIGHT_ORANGE;
		Colors.ACTIVE = ColorUtils.ORANGE;
		Colors.OVER = ColorUtils.ORANGE_BRIGHT;
		Colors.DOWN = ColorUtils.ORANGE;

		Colors.ON = ColorUtils.DARKER_ORANGE;
		Colors.ON_OVER = ColorUtils.BLUE;
		Colors.OFF = ColorUtils.LIGHT_ORANGE;
		Colors.OFF_OVER = ColorUtils.HALO_GREEN;

		Colors.BG = ColorUtils.GRAY;
		Colors.BG_LAYOUT = ColorUtils.BLACK;

		Colors.STEPPER_BUTTON_ACTIVE = ColorUtils.HALO_ORANGE;
		Colors.STEPPER_BUTTON_OVER = ColorUtils.LIGHT_GRAY;
		Colors.STEPPER_BUTTON_DOWN = ColorUtils.DARKER_ORANGE;
	}

}