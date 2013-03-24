package omni.components.style.base.layout.window;

import omni.components.gui.layout.window.WindowVBox.WindowVBoxStyle;
import omni.utils.OStates;
import omni.components.style.base.BaseColors;
import omni.components.gui.layout.VBox.VBoxStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class BaseWindowVBox extends WindowVBoxStyle
{

	public function new( )
	{
		super( );
		
		defaultDirection = OStates.VERTICAL;
		defaultVerticalHAlign = OStates.MIDDLE;
		defaultScrollRect = false;

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, ColorUtils.RED );
		setBackgroundBrush( bgColor );
	}

}
