package omni.components.theme.color;

import omni.components.theme.color.layout.ColorWindow;
import omni.components.theme.color.controls.ColorSliderButton;
import omni.components.theme.color.controls.ColorScrollBar;
import omni.components.core.OTheme;
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

		addStyle( ColorOToggleButton );
		addStyle( ColorOToggleButtonGroup );
		addStyle( ColorOTextBase );

		addStyle( ColorWindow );

		addStyle( ColorButton );
		addStyle( ColorCheckBox );
		addStyle( ColorRadioButton );
		addStyle( ColorRadioButtonGroup );

		addStyle( ColorHBox );
		addStyle( ColorVBox );
		addStyle( ColorContainerPage );
		addStyle( ColorTabbedContainer );
		addStyle( ColorTabButton );
		addStyle( ColorTabButtonGroup );

		addStyle( ColorSlider );
		addStyle( ColorScrollSlider );
		addStyle( ColorSliderButton );
		addStyle( ColorScrollBar );
		addStyle( ColorScrollBarButton );
		addStyle( ColorScrollContainer );

		addStyle( ColorIcon );
		addStyle( ColorProgressBar );

		addStyle( ColorNumericStepper );

		addStyle( ColorLabel );
		addStyle( ColorInputField );

	}

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

	public function setupColors( ):Void
	{

	}

}