package omni.components.style.base.controls;

import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.gui.controls.NumericStepperButton.NumericStepperButtonStyle;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponentButton.OComponentButtonStyle;

class BaseNumericStepperButton extends NumericStepperButtonStyle
{
	public function new( )
	{
		super( );

        layoutStyle = new BaseOComponentButtonLayout();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, BaseColors.ACTIVE );
		bgColor.setColorState( OStates.DISABLED, BaseColors.DISABLED );
		bgColor.setColorState( OStates.OVER, BaseColors.OVER );
		bgColor.setColorState( OStates.DOWN, BaseColors.DOWN );
		setBackgroundBrush( bgColor );
		
		defaultSizeMethodWidth = OStates.FIXED;
		defaultSizeMethodHeight = OStates.FIXED;
	}
}