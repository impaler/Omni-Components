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

		BaseColors.ON = ColorUtils.GREEN;
		BaseColors.ON_OVER = ColorUtils.DARKER_ORANGE;

		BaseColors.OFF = ColorUtils.HALO_ORANGE;
		BaseColors.OFF_OVER = ColorUtils.DARKER_ORANGE;

		BaseColors.BG = ColorUtils.GRAY;
		BaseColors.BG_LAYOUT = ColorUtils.BLACK;
		BaseColors.BG_HBOX = ColorUtils.GREEN;
		BaseColors.BG_VBOX = ColorUtils.BLUE;

		BaseColors.STEPPER_BUTTON_ACTIVE = ColorUtils.HALO_ORANGE;
		BaseColors.STEPPER_BUTTON_OVER = ColorUtils.LIGHT_GRAY;
		BaseColors.STEPPER_BUTTON_DOWN = ColorUtils.DARKER_ORANGE;
		
		BaseColors.SLIDER_BUTTON_ACTIVE = ColorUtils.HALO_ORANGE;
		BaseColors.SLIDER_BUTTON_OVER = ColorUtils.GREEN;
		BaseColors.SLIDER_BUTTON_DOWN = ColorUtils.PINK;

		BaseColors.LABEL_TEXT = ColorUtils.WHITE;
		
		BaseColors.SCROLLBAR_BUTTON_ACTIVE = ColorUtils.HALO_ORANGE;
		BaseColors.SCROLLBAR_BUTTON_OVER = ColorUtils.BLUE;
		BaseColors.SCROLLBAR_BUTTON_DOWN = ColorUtils.GREEN_LIGHT;
		
		BaseColors.SCROLLBAR_SLIDER_BUTTON_ACTIVE = ColorUtils.HALO_ORANGE;
		BaseColors.SCROLLBAR_SLIDER_BUTTON_OVER = ColorUtils.HALO_ORANGE;
		BaseColors.SCROLLBAR_SLIDER_BUTTON_DOWN = ColorUtils.HALO_ORANGE;
	}

}