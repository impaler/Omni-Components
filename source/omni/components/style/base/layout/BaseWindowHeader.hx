package omni.components.style.base.layout;

import omni.components.gui.layout.window.WindowHeader.WindowHeaderStyle;
import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.brush.BrushColorFill;

class BaseWindowHeader extends WindowHeaderStyle
{
	public function new( )
	{
		super( );

		defaultWidth = 120;
        defaultHeight = 40;
		
		var bgColor = new BrushColorFill ();
        bgColor.setColorState( OStates.ACTIVE, BaseColors.ACTIVE );
//        bgColor.setColorState( OStates.DISABLED, BaseColors.DISABLED );
//        bgColor.setColorState( OStates.OVER, BaseColors.OVER );
//        bgColor.setColorState( OStates.DOWN, BaseColors.DOWN );
		setBackgroundBrush( bgColor );
	}
}