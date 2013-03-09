package omni.components.style.base.core;

import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponentButton.OComponentButtonStyle;

class BaseOComponentButton extends OComponentButtonStyle
{
	public function new( )
	{
		super( );
		
		defaultSizeMethodWidth = OStates.AUTO;
		defaultSizeMethodHeight = OStates.AUTO;
		
		defaultWidth = 100;
		defaultHeight = 20;
		defaultPadding = 0;

        layoutStyle = new BaseOComponentButtonLayout();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, BaseColors.ACTIVE );
		bgColor.setColorState( OStates.DISABLED, BaseColors.DISABLED );
		bgColor.setColorState( OStates.OVER, BaseColors.OVER );
		bgColor.setColorState( OStates.DOWN, BaseColors.DOWN );
		setBackgroundBrush( bgColor );

	}
}