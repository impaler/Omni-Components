package omni.components.theme.colors;

import omni.components.style.base.BaseTheme;
import omni.components.style.base.BaseColors;
import omni.utils.ColorUtils;

class Dark extends BaseTheme
{

    override public function setupColors()
    {
        BaseColors.DISABLED = ColorUtils.BLACK;
        BaseColors.ACTIVE = ColorUtils.GRAY;
        BaseColors.OVER = ColorUtils.LIGHT_GRAY;
        BaseColors.DOWN = ColorUtils.BLACK;

        BaseColors.ON = ColorUtils.GRAY;
        BaseColors.ON_OVER = ColorUtils.LIGHT_GRAY;

        BaseColors.OFF = ColorUtils.DARK_GRAY;
        BaseColors.OFF_OVER = ColorUtils.LIGHT_GRAY;

        BaseColors.BG = ColorUtils.BLACK;
        BaseColors.BG_LAYOUT = ColorUtils.BLACK;
        BaseColors.BG_HBOX = ColorUtils.GRAY;
        BaseColors.BG_VBOX = ColorUtils.GRAY;

        BaseColors.STEPPER_BUTTON_ACTIVE = ColorUtils.BLACK;
        BaseColors.STEPPER_BUTTON_OVER = ColorUtils.LIGHT_GRAY;
        BaseColors.STEPPER_BUTTON_DOWN = ColorUtils.GRAY;

        BaseColors.SLIDER_BUTTON_ACTIVE = ColorUtils.DARK_GRAY;
        BaseColors.SLIDER_BUTTON_OVER = ColorUtils.LIGHT_GRAY;
        BaseColors.SLIDER_BUTTON_DOWN = ColorUtils.GRAY;

        BaseColors.LABEL_TEXT = ColorUtils.WHITE;

        BaseColors.SCROLLBAR_BUTTON_ACTIVE = ColorUtils.DARK_GRAY;
        BaseColors.SCROLLBAR_BUTTON_OVER = ColorUtils.LIGHT_GRAY;
        BaseColors.SCROLLBAR_BUTTON_DOWN = ColorUtils.GRAY;

        BaseColors.SCROLLBAR_SLIDER_BUTTON_ACTIVE = ColorUtils.DARK_GRAY;
        BaseColors.SCROLLBAR_SLIDER_BUTTON_OVER = ColorUtils.LIGHT_GRAY;
        BaseColors.SCROLLBAR_SLIDER_BUTTON_DOWN = ColorUtils.GRAY;

        BaseColors.SCROLLSIDER_BG = ColorUtils.GRAY;
    }

}