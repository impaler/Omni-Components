package omni.components.style.base.layout;

import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.gui.layout.PagedContainer.PagedContainerStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class BaseTabbedContainer extends PagedContainerStyle
{

	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, BaseColors.BG_LAYOUT );
		//setBackgroundBrush( bgColor );
		
		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 10;

	}

}
