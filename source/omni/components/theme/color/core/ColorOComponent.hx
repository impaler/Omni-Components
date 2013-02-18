package omni.components.theme.color.core;

import omni.components.core.OStates;
import omni.components.style.OBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;

class ColorOComponent extends OComponentStyle
{
	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, Colors.BG );
		setBackgroundBrush( bgColor );

		defaultWidth = 100;
		defaultHeight = 30;
		minWidth = 0;
		minHeight = 0;
		maxWidth = 2000;
		maxHeight = 2000;
		defaultPadding = 0;
		defaultState = OStates.ACTIVE;
	}
}