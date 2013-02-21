package omni.components.theme.color;

import omni.components.core.OTheme;
import omni.components.theme.color.core.ColorOContainer;
import omni.components.theme.color.layout.ColorWindow;
import omni.components.theme.color.controls.ColorSliderButton;
import omni.components.theme.color.controls.ColorScrollBar;
import omni.components.theme.color.text.ColorLabel;
import omni.components.theme.color.text.ColorInputField;
import omni.components.theme.color.controls.ColorScrollBarButton;
import omni.components.theme.color.core.ColorOToggleButtonGroup;
import omni.components.theme.color.core.ColorOToggleButton;
import omni.components.theme.color.core.ColorOTextBase;
import omni.components.theme.color.core.ColorOComponent;
import omni.components.theme.color.core.ColorOButtonBase;
import omni.components.theme.color.layout.ColorVBox;
import omni.components.theme.color.layout.ColorTabButtonGroup;
import omni.components.theme.color.layout.ColorTabbedContainer;
import omni.components.theme.color.layout.ColorScrollContainer;
import omni.components.theme.color.layout.ColorIcon;
import omni.components.theme.color.layout.ColorRadioButtonGroup;
import omni.components.theme.color.layout.ColorHBox;
import omni.components.theme.color.layout.ColorContainerPage;
import omni.components.theme.color.layout.ColorOLayout;
import omni.components.theme.color.controls.ColorTabButton;
import omni.components.theme.color.controls.ColorSlider;
import omni.components.theme.color.controls.ColorScrollSlider;
import omni.components.theme.color.controls.ColorRadioButton;
import omni.components.theme.color.controls.ColorNumericStepper;
import omni.components.theme.color.controls.ColorCheckBox;
import omni.components.theme.color.controls.ColorProgressBar;
import omni.components.theme.color.controls.ColorButton;

class Color extends OTheme
{

	public function new( )
	{
		super( );

		setupColors( );

		addOComponentStyle( );
		addOButtonBaseStyle( );
		addOLayout( );

		addStyle( ColorOContainer );
		addStyle( ColorOToggleButton );
		addStyle( ColorOToggleButtonGroup );
		
		addOTextBaseStyle();

		addStyle( ColorWindow );

		addButtonStyle();
		addCheckBoxStyle();
		
		addStyle( ColorRadioButton );
		addStyle( ColorRadioButtonGroup );

		addStyle( ColorHBox );
		addStyle( ColorVBox );
		addStyle( ColorContainerPage );
		addStyle( ColorTabbedContainer );
		addStyle( ColorTabButton );
		addStyle( ColorTabButtonGroup );

		addSliderStyle();
		addSliderButtonStyle();



		addStyle( ColorScrollSlider );
		addStyle( ColorScrollBar );
		addStyle( ColorScrollBarButton );
		addStyle( ColorScrollContainer );

		addStyle( ColorIcon );
		addStyle( ColorProgressBar );

		addNumericStepperStyle();

		addStyle( ColorLabel );
		addStyle( ColorInputField );

	}

/**
* Override these helper functions for previewing themes in dev without null errors
* 
**/
	public function addOComponentStyle( ):Void
	{
		addStyle( ColorOComponent );
	}

	public function addOButtonBaseStyle( ):Void
	{
		addStyle( ColorOButtonBase );
	}

	public function addOLayout( ):Void
	{
		addStyle( ColorOLayout );
	}

	public function addOTextBaseStyle( ):Void
	{
		addStyle( ColorOTextBase );
	}
	
	public function addButtonStyle( ):Void
	{
		addStyle( ColorButton );
	}

	public function addSliderStyle( ):Void
	{
		addStyle( ColorSlider );
	}
	
	public function addSliderButtonStyle( ):Void
	{
		addStyle( ColorSliderButton );
	}
	
	public function addNumericStepperStyle( ):Void
	{
		addStyle( ColorNumericStepper );
	}
	
	public function addCheckBoxStyle( ):Void
	{
		addStyle( ColorCheckBox );
	}
	
	public function setupColors( ):Void
	{
		//set your overrides on the static color values
	}

}