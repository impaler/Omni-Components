package omni.components.theme.color.layout;

import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class ColorLayout extends OLayoutStyle
{

	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Colors.BG_LAYOUT );
		setBackgroundBrush( bgColor );

		defaultDirection = OLayout.VERTICALLY;
		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 10;

	}

}
