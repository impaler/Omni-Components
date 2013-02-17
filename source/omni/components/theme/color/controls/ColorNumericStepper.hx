package omni.components.theme.color.controls;

import omni.components.core.OStates;
import omni.components.theme.color.core.ColorOTextBase;
import omni.components.theme.color.core.ColorOButtonBase;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.NumericStepper.NumericStepperStyle;

class ColorNumericStepper extends NumericStepperStyle
{
	public function new( )
	{
		super( );

		var buttonStyle = new OButtonBaseStyle();
		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, Colors.STEPPER_BUTTON_ACTIVE );
		bgColor.setColorState( OStates.DISABLED, Colors.DISABLED );
		bgColor.setColorState( OStates.OVER, Colors.STEPPER_BUTTON_OVER );
		bgColor.setColorState( OStates.DOWN, Colors.STEPPER_BUTTON_DOWN );
		buttonStyle.setBackgroundBrush( bgColor );

		defaultWidth = 20;
		defaultHeight = 10;
		buttonStyle.minWidth = 0;
		buttonStyle.minHeight = 10;

		increaseButtonStyle = buttonStyle;
		decreaseButtonStyle = buttonStyle;

		textStyle = new ColorOTextBase();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, Colors.ACTIVE );
		bgColor.setColorState( OStates.DISABLED, Colors.DISABLED );
		setBackgroundBrush( bgColor );

		defaultWidth = 200;
		defaultHeight = 50;
		minWidth = 10;
		minHeight = 10;
		maxWidth = 2000;
		maxHeight = 2000;
		defaultPadding = 0;
	}
}