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

import omni.components.style.base.core.BaseODrawable;
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

import omni.components.style.base.layout.window.BaseWindowFooter;
import omni.components.style.base.layout.window.BaseWindowMiddleBG;
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

		addODrawableStyle();
		addOComponentStyle();
		addOButtonBaseStyle();
		addOLayout();
		addBaseOContainerStyle();
		addBaseOContainerContentStyle();
		addBaseOToggleButtonStyle();
		addBaseOToggleButtonGroup();
		addBaseSlideToggleStyle();
		addOTextBaseStyle();
		addWindowStyle();
		addTabButtonStyle();
		addButtonStyle();
		addCheckBoxStyle();
		addBaseOComponentButtonStyle();
		addBaseOComponentButtonLayoutStyle();
		addRadioButtonsStyle();
		addBaseHBoxStyle();
		addBaseVBoxStyle();
		addBaseContainerPageStyle();
		addBaseWindowPageStyle();
		addBaseTabbedContainerStyle();
		addBaseTabButtonGroupStyle();
		addSliderStyle();
		addScrollBarStyle();
		addListStyle();
		addBaseSelectListStyle();
		addStyleBaseIconStyle();
		addBaseProgressBarStyle();
		addNumericStepperStyle();
		addLabelStyle();
		addInputFeildStyle();
		addSpriteContainerStyle();

	}

	/**
	* Override this method for a basic color fill theme
	* @see omni.components.theme.colors.* for examples
	*
	**/
	public function setupColors():Void
	{}

	/**
	*   Override the per Component type for developing a new theme.
	*   This will let you override component types one by one while previewing the results.
	**/

	public function addRadioButtonsStyle():Void
	{
		addStyle(BaseRadioButton);
		addStyle(BaseRadioButtonGroup);
	}

	public function addScrollBarStyle():Void
	{
		addStyle(BaseScrollContainer);
		addStyle(BaseScrollSlider);
		addStyle(BaseScrollBar);
		addStyle(BaseScrollBarButton);
	}

	public function addODrawableStyle():Void
	{
		addStyle(BaseODrawable);
	}

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

	public function addTabButtonStyle():Void
	{
		addStyle(BaseTabButton);
	}

	public function addWindowStyle():Void
	{
		addStyle(BaseWindow);
		addStyle(BaseWindowHeader);
		addStyle(BaseWindowFooter);
		addStyle(BaseWindowTabbedContainer);
		addStyle(BaseWindowContainer);
		addStyle(BaseWindowVBox);
		addStyle(BaseWindowMiddleBG);
	}

	public function addListStyle():Void
	{
		addStyle(BaseList);
	}

	public function addLabelStyle():Void
	{
		addStyle(BaseLabel);
	}

	public function addInputFeildStyle():Void
	{
		addStyle(BaseInputField);
	}

	public function addSpriteContainerStyle():Void
	{
		addStyle(BaseSpriteContainer);
	}

	public function addBaseProgressBarStyle():Void
	{
		addStyle(BaseProgressBar);
	}

	public function addStyleBaseIconStyle():Void
	{
		addStyle(BaseIcon);
	}

	public function addBaseSelectListStyle():Void
	{
		addStyle(BaseSelectList);
	}

	public function addBaseTabButtonGroupStyle():Void
	{
		addStyle(BaseTabButtonGroup);
	}

	public function addBaseTabbedContainerStyle():Void
	{
		addStyle(BaseTabbedContainer);
	}

	public function addBaseWindowPageStyle():Void
	{
		addStyle(BaseWindowPage);
	}

	public function addBaseContainerPageStyle():Void
	{
		addStyle(BaseContainerPage);
	}

	public function addBaseHBoxStyle():Void
	{
		addStyle(BaseHBox);
	}

	public function addBaseVBoxStyle():Void
	{
		addStyle(BaseVBox);
	}

	public function addBaseOComponentButtonStyle():Void
	{
		addStyle(BaseOComponentButton);
	}

	public function addBaseOComponentButtonLayoutStyle():Void
	{
		addStyle(BaseOComponentButtonLayout);
	}

	public function addBaseSlideToggleStyle():Void
	{
		addStyle(BaseSlideToggle);
	}

	public function addBaseOToggleButtonGroup():Void
	{
		addStyle(BaseOToggleButtonGroup);
	}

	public function addBaseOToggleButtonStyle():Void
	{
		addStyle(BaseOToggleButton);
	}

	public function addBaseOContainerContentStyle():Void
	{
		addStyle(BaseOContainerContent);
	}

	public function addBaseOContainerStyle():Void
	{
		addStyle(BaseOContainer);
	}

}