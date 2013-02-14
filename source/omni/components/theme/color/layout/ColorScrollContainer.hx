package omni.components.theme.color.layout;

import omni.components.core.OLayout;
import omni.components.theme.color.controls.ColorScrollBar;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.ScrollContainer.ScrollContainerStyle;
import omni.components.core.OLayout.OLayoutStyle;
import nme.geom.Rectangle;
import omni.utils.ColorUtils;

class ColorScrollContainer extends ScrollContainerStyle
{

	public function new( )
	{
		super( );

		hScrollStyle = new ColorScrollBar();
		vScrollStyle = new ColorScrollBar();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Colors.BG );
		setBackgroundBrush( bgColor );

		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 20;

	}

}
