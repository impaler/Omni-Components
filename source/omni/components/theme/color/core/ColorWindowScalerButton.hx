package omni.components.theme.color.core;

import omni.components.core.OStates;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.OBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;

class ColorWindowScalerButton extends OButtonBaseStyle
{
	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, Colors.ACTIVE );
		bgColor.setColorState( OStates.DISABLED, Colors.DISABLED );
		bgColor.setColorState( OStates.OVER, Colors.OVER );
		bgColor.setColorState( OStates.DOWN, Colors.DOWN );
		setBackgroundBrush( bgColor );

		defaultWidth = 20;
		defaultHeight = 20;
		defaultPadding = 0;
	}
}