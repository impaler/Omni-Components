package omni.components.theme.color.layout;

import omni.components.gui.layout.VBox.VBoxStyle;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class ColorVBox extends VBoxStyle
{

	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Colors.BG_LAYOUT );
		setBackgroundBrush( bgColor );

		defaultScrollRect = false;
		defaultDirection = OLayout.VERTICALLY;
		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 10;

	}

}
