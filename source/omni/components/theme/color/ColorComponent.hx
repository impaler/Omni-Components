package omni.components.theme.color;

import omni.components.style.OBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.ComponentStyle;

class ColorComponent extends ComponentStyle
{
	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Color.BG );
		setBackgroundBrush( bgColor );

		defaultWidth = 100;
		defaultHeight = 30;
		minWidth = 10;
		minHeight = 10;
		maxWidth = 2000;
		maxHeight = 2000;
		defaultPadding = 0;
		defaultState = OBaseStyle.STATE_ACTIVE;
	}
}