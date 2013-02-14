package omni.components.theme.color.layout;

import omni.components.gui.layout.TabButtonGroup.TabButtonGroupStyle;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class ColorTabButtonGroup extends TabButtonGroupStyle
{

	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Colors.BG_LAYOUT );
		setBackgroundBrush( bgColor );

//todo
//		defaultDirection = Layout.HORIZONTALLY;

		defaultWidth = 300;
		defaultHeight = 60;
		defaultPadding = 0;

	}

}
