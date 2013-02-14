package omni.components.theme.color.layout;

import omni.components.gui.layout.ContainerPage.ContainerPageStyle;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class ColorContainerPage extends ContainerPageStyle
{

	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, ColorUtils.GREEN );
		setBackgroundBrush( bgColor );

//		defaultDirection = Layout.VERTICALLY;
		defaultWidth = 400;
		defaultHeight = 400;
		defaultPadding = 10;

	}

}
