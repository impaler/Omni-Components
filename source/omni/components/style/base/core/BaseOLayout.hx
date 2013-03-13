package omni.components.style.base.core;

import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class BaseOLayout extends OLayoutStyle
{

	public function new( )
	{
		super( );

		defaultScrollRect = false;
		
		defaultDirection = OStates.VERTICAL;
		
		defaultVerticalHAlign = OStates.MIDDLE;
		defaultHorizontalVAlign = OStates.MIDDLE;
		
		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 0;

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, BaseColors.BG_LAYOUT );
		setBackgroundBrush( bgColor );
	}
}
