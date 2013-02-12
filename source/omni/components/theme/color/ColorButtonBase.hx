package omni.components.theme.color;

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
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Color.ACTIVE );
		bgColor.setColorState( OBaseStyle.STATE_DISABLED, Color.DISABLED );
		bgColor.setColorState( OButtonBaseStyle.STATE_OVER, Color.OVER );
		bgColor.setColorState( OButtonBaseStyle.STATE_DOWN, Color.DOWN );
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