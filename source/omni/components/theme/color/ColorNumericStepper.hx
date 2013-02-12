package omni.components.theme.color;

import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.NumericStepper.NumericStepperStyle;

class ColorNumericStepper extends NumericStepperStyle
{
	public function new( )
	{
		super( );

		increaseButtonStyle = new ColorButtonBase();
		decreaseButtonStyle = new ColorButtonBase();
		textStyle = new ColorTextBase();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Color.ACTIVE );
		bgColor.setColorState( OBaseStyle.STATE_DISABLED, Color.DISABLED );
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