package omni.components.style.base.layout;

import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.gui.layout.HBox.HBoxStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class BaseHBox extends HBoxStyle
{

	public function new( )
	{
		super( );
		
		defaultDirection = OStates.HORIZONTAL;
		defaultHorizontalVAlign = OStates.MIDDLE;
		defaultScrollRect = false;
		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 10;
		
		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, BaseColors.BG_LAYOUT );
		setBackgroundBrush( bgColor );
	}

}
