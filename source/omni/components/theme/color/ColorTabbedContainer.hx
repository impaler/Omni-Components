package omni.components.theme.color;

import omni.components.gui.layout.TabbedContainer.TabbedContainerStyle;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.Layout.LayoutStyle;
import omni.components.gui.layout.Layout;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class ColorTabbedContainer extends TabbedContainerStyle
{

	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Color.BG_LAYOUT );
		setBackgroundBrush( bgColor );

//		defaultDirection = Layout.VERTICALLY;
		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 10;

	}

}
