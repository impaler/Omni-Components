package omni.components.style.base.layout;

import omni.utils.OStates;
import omni.components.style.base.BaseColors;
import omni.components.gui.layout.VBox.VBoxStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class BaseVBox extends VBoxStyle
{

	public function new( )
	{
		super( );
		
		defaultDirection = OStates.VERTICAL;
		defaultVerticalHAlign = OStates.MIDDLE;
		defaultScrollRect = false;
		defaultWidth = 60;
		defaultHeight = 120;
		defaultPadding = 10;

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, BaseColors.BG_VBOX );
		setBackgroundBrush( bgColor );
	}

}
