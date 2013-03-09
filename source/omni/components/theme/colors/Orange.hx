package omni.components.theme.colors;

import omni.components.style.base.BaseTheme;
import omni.components.style.base.BaseColors;
import omni.utils.ColorUtils;

class Orange extends BaseTheme
{

	override public function setupColors( )
	{
		BaseColors.DISABLED = ColorUtils.LIGHT_ORANGE;
		BaseColors.ACTIVE = ColorUtils.ORANGE;
		BaseColors.OVER = ColorUtils.ORANGE_BRIGHT;
		BaseColors.DOWN = ColorUtils.ORANGE;

		BaseColors.ON = ColorUtils.DARKER_ORANGE;
		BaseColors.ON_OVER = ColorUtils.DARKER_ORANGE;

		BaseColors.OFF = ColorUtils.HALO_ORANGE;
		BaseColors.OFF_OVER = ColorUtils.DARKER_ORANGE;

		BaseColors.BG = ColorUtils.GRAY;
		BaseColors.BG_LAYOUT = ColorUtils.BLACK;

		BaseColors.STEPPER_BUTTON_ACTIVE = ColorUtils.HALO_ORANGE;
		BaseColors.STEPPER_BUTTON_OVER = ColorUtils.LIGHT_GRAY;
		BaseColors.STEPPER_BUTTON_DOWN = ColorUtils.DARKER_ORANGE;

		BaseColors.LABEL_TEXT = ColorUtils.WHITE;
	}

}