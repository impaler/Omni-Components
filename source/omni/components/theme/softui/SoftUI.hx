package omni.components.theme.softui;

import omni.components.theme.softui.scrollBar.SoftUIScrollBar;
import omni.components.theme.softui.scrollBar.SoftUIScrollBarButton;
import omni.components.theme.softui.scrollBar.SoftUIScrollContainer;
import omni.components.theme.softui.scrollBar.SoftUIScrollSlider;
import omni.components.style.base.layout.window.BaseWindowVBox;
import omni.components.style.base.layout.window.BaseWindowContainer;
import omni.components.style.base.BaseTheme;
import omni.components.style.base.BaseColors;
import omni.utils.ColorUtils;

class SoftUI extends BaseTheme
{

    override public function setupColors()
    {
        BaseColors.TRANS = ColorUtils.TRANSPARENT;
        BaseColors.DISABLED = ColorUtils.LIGHT_ORANGE;
        BaseColors.ACTIVE = ColorUtils.ORANGE;
        BaseColors.OVER = ColorUtils.ORANGE_BRIGHT;
        BaseColors.DOWN = ColorUtils.ORANGE;

        BaseColors.ON = ColorUtils.GREEN;
        BaseColors.ON_OVER = ColorUtils.DARKER_ORANGE;

        BaseColors.OFF = ColorUtils.HALO_ORANGE;
        BaseColors.OFF_OVER = ColorUtils.DARKER_ORANGE;

        BaseColors.BG = ColorUtils.GRAY;
        BaseColors.BG_LAYOUT = ColorUtils.WHITE;
        BaseColors.BG_HBOX = ColorUtils.WHITE;
        BaseColors.BG_VBOX = ColorUtils.WHITE;

        BaseColors.STEPPER_BUTTON_ACTIVE = ColorUtils.HALO_ORANGE;
        BaseColors.STEPPER_BUTTON_OVER = ColorUtils.LIGHT_GRAY;
        BaseColors.STEPPER_BUTTON_DOWN = ColorUtils.DARKER_ORANGE;

        BaseColors.SLIDER_BUTTON_ACTIVE = ColorUtils.HALO_ORANGE;
        BaseColors.SLIDER_BUTTON_OVER = ColorUtils.GREEN;
        BaseColors.SLIDER_BUTTON_DOWN = ColorUtils.PINK;

        BaseColors.LABEL_TEXT = ColorUtils.BLACK;

        BaseColors.SCROLLBAR_BUTTON_ACTIVE = ColorUtils.HALO_ORANGE;
        BaseColors.SCROLLBAR_BUTTON_OVER = ColorUtils.BLUE;
        BaseColors.SCROLLBAR_BUTTON_DOWN = ColorUtils.GREEN_LIGHT;

        BaseColors.SCROLLBAR_SLIDER_BUTTON_ACTIVE = ColorUtils.HALO_ORANGE;
        BaseColors.SCROLLBAR_SLIDER_BUTTON_OVER = ColorUtils.HALO_ORANGE;
        BaseColors.SCROLLBAR_SLIDER_BUTTON_DOWN = ColorUtils.HALO_ORANGE;

        BaseColors.SCROLLSIDER_BG = ColorUtils.GRAY;
    }

    override public function addScrollBarStyle():Void
    {
        addStyle(SoftUIScrollContainer);
        addStyle(SoftUIScrollSlider);
        addStyle(SoftUIScrollBarButton);
        addStyle(SoftUIScrollBar);
    }

    override public function addButtonStyle():Void
    {
        addStyle(SoftUIButton);
    }

    override public function addTabButtonStyle():Void
    {
        addStyle(SoftUITabButton);
    }

    override public function addSliderStyle():Void
    {
        addStyle(SoftUISlider);
        addStyle(SoftUISliderButton);
    }

    override public function addCheckBoxStyle():Void
    {
        addStyle(SoftUICheckBox);
    }

    override public function addRadioButtonsStyle():Void {
        addStyle(SoftUIRadioButton);
        addStyle(SoftUIRadioButtonGroup);
    }

    override public function addWindowStyle():Void
    {
        addStyle(SoftUIWindow);
        addStyle(SoftUIWindowHeader);
        addStyle(SoftUIWindowFooter);
        addStyle(SoftUIWindowTabbedContainer);
        addStyle(SoftUIWindowMiddleBG);
	    addStyle(SoftUIWindowScalerButton);

	    addStyle(BaseWindowContainer);
	    addStyle(BaseWindowVBox);
    }

    override public function addNumericStepperStyle():Void
    {
        addStyle(SoftUINumericStepper);
        addStyle(SoftUINumericStepperButton);
    }

}
