package omni.components.style.base;

import omni.components.style.base.controls.BaseSelectList;
import omni.components.style.base.controls.BaseButton;
import omni.components.style.base.controls.BaseProgressBar;
import omni.components.style.base.controls.BaseNumericStepper;
import omni.components.style.base.controls.BaseScrollSlider;
import omni.components.style.base.controls.BaseRadioButton;
import omni.components.style.base.controls.BaseTabButton;
import omni.components.style.base.controls.BaseScrollBarButton;
import omni.components.style.base.controls.BaseSlider;
import omni.components.style.base.controls.BaseCheckBox;
import omni.components.style.base.controls.BaseScrollBar;
import omni.components.style.base.controls.BaseSliderButton;
import omni.components.style.base.controls.BaseNumericStepperButton;
import omni.components.style.base.controls.BaseSlideToggle;

import omni.components.style.base.core.BaseOContainer;
import omni.components.style.base.core.BaseOComponent;
import omni.components.style.base.core.BaseOContainerContent;
import omni.components.style.base.core.BaseOToggleButton;
import omni.components.style.base.core.BaseOTextBase;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.style.base.core.BaseOToggleButtonGroup;
import omni.components.style.base.core.BaseOComponentButton;
import omni.components.style.base.core.BaseOButtonBase;
import omni.components.style.base.core.BaseOLayout;

import omni.components.style.base.layout.window.BaseWindowPage;
import omni.components.style.base.layout.BaseContainerPage;
import omni.components.style.base.layout.BaseTabButtonGroup;
import omni.components.style.base.layout.window.BaseWindow;
import omni.components.style.base.layout.window.BaseWindowHeader;
import omni.components.style.base.layout.window.BaseWindowTabbedContainer;
import omni.components.style.base.layout.BaseRadioButtonGroup;
import omni.components.style.base.layout.BaseTabbedContainer;
import omni.components.style.base.layout.BaseHBox;
import omni.components.style.base.layout.BaseVBox;
import omni.components.style.base.layout.BaseIcon;
import omni.components.style.base.layout.BaseSpriteContainer;
import omni.components.style.base.layout.BaseScrollContainer;
import omni.components.style.base.layout.window.BaseWindowVBox;
import omni.components.style.base.layout.window.BaseWindowContainer;
import omni.components.style.base.layout.BaseList;

import omni.components.style.base.text.BaseLabel;
import omni.components.style.base.text.BaseInputField;
import omni.components.style.base.text.BaseButtonLabel;

import omni.components.core.OTheme;

class BaseTheme extends OTheme
{

    public function new()
    {
        super();

        setupColors();

        addOComponentStyle();
        addOButtonBaseStyle();
        addOLayout();

        addStyle(BaseOContainer);
        addStyle(BaseOContainerContent);
        addStyle(BaseOToggleButton);
        addStyle(BaseOToggleButtonGroup);
        addStyle(BaseSlideToggle);

        addOTextBaseStyle();

        addStyle(BaseWindow);
        addStyle(BaseWindowHeader);
        addStyle(BaseWindowTabbedContainer);
        addStyle(BaseWindowContainer);
        addStyle(BaseWindowVBox);

        addButtonStyle();
        addCheckBoxStyle();

        addStyle(BaseOComponentButton);
        addStyle(BaseOComponentButtonLayout);

        addStyle(BaseRadioButton);
        addStyle(BaseRadioButtonGroup);

        addStyle(BaseHBox);
        addStyle(BaseVBox);
        addStyle(BaseContainerPage);
        addStyle(BaseWindowPage);
        addStyle(BaseTabbedContainer);
        addStyle(BaseTabButton);
        addStyle(BaseTabButtonGroup);

        addSliderStyle();
        addSliderButtonStyle();

        addStyle(BaseScrollSlider);
        addStyle(BaseScrollBar);
        addStyle(BaseScrollBarButton);
        addStyle(BaseScrollContainer);

        addStyle(BaseList);

        addStyle(BaseSelectList);

        addStyle(BaseIcon);
        addStyle(BaseProgressBar);

        addNumericStepperStyle();

        addStyle(BaseLabel);
        addStyle(BaseInputField);

        addStyle(BaseSpriteContainer);

    }

    /**
* Override these helper functions for previewing themes in dev without null errors
* 
**/

    public function addOComponentStyle():Void
    {
        addStyle(BaseOComponent);
    }

    public function addOButtonBaseStyle():Void
    {
        addStyle(BaseOButtonBase);
    }

    public function addOLayout():Void
    {
        addStyle(BaseOLayout);
    }

    public function addOTextBaseStyle():Void
    {
        addStyle(BaseOTextBase);
    }

    public function addButtonStyle():Void
    {
        addStyle(BaseButton);
        addStyle(BaseButtonLabel);
    }

    public function addSliderStyle():Void
    {
        addStyle(BaseSlider);
    }

    public function addSliderButtonStyle():Void
    {
        addStyle(BaseSliderButton);
    }

    public function addNumericStepperStyle():Void
    {
        addStyle(BaseNumericStepper);
        addStyle(BaseNumericStepperButton);
    }

    public function addCheckBoxStyle():Void
    {
        addStyle(BaseCheckBox);
    }

    public function setupColors():Void
    {
        //set your overrides on the static Base values
    }

}