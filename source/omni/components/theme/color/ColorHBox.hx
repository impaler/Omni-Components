package omni.components.theme.color;

import omni.components.gui.layout.HBox.HBoxStyle;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.Layout;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class ColorHBox extends HBoxStyle
{

	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Color.BG_LAYOUT );
		setBackgroundBrush( bgColor );
		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 10;

	}

}
