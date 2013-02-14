package omni.components.theme.color.core;

import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.OBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.ComponentStyle;

class ColorButtonBase extends OButtonBaseStyle
{
	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Colors.ACTIVE );
		bgColor.setColorState( OBaseStyle.STATE_DISABLED, Colors.DISABLED );
		bgColor.setColorState( OButtonBaseStyle.STATE_OVER, Colors.OVER );
		bgColor.setColorState( OButtonBaseStyle.STATE_DOWN, Colors.DOWN );
		setBackgroundBrush( bgColor );

		defaultWidth = 300;
		defaultHeight = 60;
		minWidth = 10;
		minHeight = 10;
		maxWidth = 2000;
		maxHeight = 2000;
		defaultPadding = 0;
	}
}