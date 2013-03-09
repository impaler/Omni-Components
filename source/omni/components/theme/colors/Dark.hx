package omni.components.theme.colors;

import omni.components.style.base.BaseTheme;
import omni.components.style.base.BaseColors;
import omni.utils.ColorUtils;

class Dark extends BaseTheme
{

	override public function setupColors( )
	{
		BaseColors.DISABLED = ColorUtils.BLACK;
		BaseColors.ACTIVE = ColorUtils.GRAY;
		BaseColors.OVER = ColorUtils.LIGHT_GRAY;
		BaseColors.DOWN = ColorUtils.ORANGE;

		BaseColors.ON = ColorUtils.GRAY;
		BaseColors.ON_OVER = ColorUtils.GRAY;
		BaseColors.OFF = ColorUtils.GRAY;
		BaseColors.OFF_OVER = ColorUtils.GRAY;

		BaseColors.BG = ColorUtils.BLACK;
		BaseColors.BG_LAYOUT = ColorUtils.BLACK;

		BaseColors.STEPPER_BUTTON_ACTIVE = ColorUtils.BLACK;
		BaseColors.STEPPER_BUTTON_OVER = ColorUtils.LIGHT_GRAY;
		BaseColors.STEPPER_BUTTON_DOWN = ColorUtils.GRAY;

		BaseColors.LABEL_TEXT = ColorUtils.LIGHT_GRAY;

	}

}