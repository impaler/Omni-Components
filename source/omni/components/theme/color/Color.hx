package omni.components.theme.color;

import omni.components.theme.color.controls.ColorScrollBar;
import omni.components.core.OTheme;
import omni.components.theme.color.text.ColorLabel;
import omni.components.theme.color.text.ColorInputField;
import omni.components.theme.color.controls.ColorScrollBarButton;
import omni.components.theme.color.core.ColorOToggleButtonGroup;
import omni.components.theme.color.core.ColorOToggleButton;
import omni.components.theme.color.core.ColorTextBase;
import omni.components.theme.color.core.ColorComponent;
import omni.components.theme.color.core.ColorButtonBase;
import omni.components.theme.color.layout.ColorVBox;
import omni.components.theme.color.layout.ColorTabButtonGroup;
import omni.components.theme.color.layout.ColorTabbedContainer;
import omni.components.theme.color.layout.ColorScrollContainer;
import omni.components.theme.color.layout.ColorIcon;
import omni.components.theme.color.layout.ColorRadioButtonGroup;
import omni.components.theme.color.layout.ColorHBox;
import omni.components.theme.color.layout.ColorContainerPage;
import omni.components.theme.color.layout.ColorLayout;
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

		addStyle( ColorComponent );

		addStyle( ColorButtonBase );
		addStyle( ColorButton );
		addStyle( ColorOToggleButton );
		addStyle( ColorCheckBox );
		addStyle( ColorRadioButton );
		addStyle( ColorRadioButtonGroup );

		addStyle( ColorLayout );
		addStyle( ColorHBox );
		addStyle( ColorVBox );
		addStyle( ColorContainerPage );
		addStyle( ColorTabbedContainer );
		addStyle( ColorTabButton );
		addStyle( ColorTabButtonGroup );

		addStyle( ColorOToggleButtonGroup );

		addStyle( ColorSlider );
		addStyle( ColorScrollSlider );
		addStyle( ColorScrollBar );
		addStyle( ColorScrollBarButton );
		addStyle( ColorScrollContainer );

		addStyle( ColorIcon );
		addStyle( ColorProgressBar );

		addStyle( ColorNumericStepper );

		addStyle( ColorTextBase );
		addStyle( ColorLabel );
		addStyle( ColorInputField );

	}

	public function setupColors( ):Void
	{

	}
}