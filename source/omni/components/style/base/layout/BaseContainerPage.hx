package omni.components.style.base.layout;

import omni.utils.OStates;
import omni.components.gui.layout.ContainerContent;
import omni.components.gui.layout.ContainerPage.ContainerPageStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class BaseContainerPage extends ContainerPageStyle
{

	public function new( )
	{
		super( );
		
		defaultContainerType = ContainerContent;

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, ColorUtils.GREEN );
		setBackgroundBrush( bgColor );

		defaultWidth = 400;
		defaultHeight = 400;
		defaultPadding = 10;

	}

}
