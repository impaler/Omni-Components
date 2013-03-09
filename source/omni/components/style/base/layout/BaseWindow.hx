package omni.components.style.base.layout;

import omni.components.style.base.controls.BaseWindowScalerButton;
import omni.components.style.base.core.BaseOButtonBase;
import omni.components.style.base.BaseColors;
import omni.components.gui.layout.Window.WindowStyle;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class BaseWindow extends WindowStyle
{

	public function new( )
	{
		super( );

		header = new BaseOButtonBase();
		footer = new BaseOButtonBase();

		scalerButton = new BaseWindowScalerButton();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, BaseColors.ACTIVE );
		setBackgroundBrush( bgColor );

		defaultWidth = 300;
		defaultHeight = 300;
		
		maxWidth = 680;
		maxHeight = 680;
		minHeight = 200;
		minWidth = 200;
	}

}
