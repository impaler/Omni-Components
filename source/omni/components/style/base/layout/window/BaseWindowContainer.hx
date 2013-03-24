package omni.components.style.base.layout.window;

import omni.components.core.OContainer;
import omni.components.gui.layout.window.WindowVBox;
import omni.utils.ColorUtils;
import omni.utils.OStates;
import omni.components.gui.layout.ScrollContainer;
import omni.components.gui.layout.window.WindowContentContainer.WindowContentContainerStyle;
import omni.components.style.brush.BrushColorFill;

class BaseWindowContainer extends WindowContentContainerStyle
{
	public function new( )
	{
		super( );

		defaultWidth = 300;
		defaultHeight = 300;
		defaultScrollRect = true;

		defaultLayoutType = WindowVBox;
		//defaultContainerType = OContainer;
		defaultContainerType = ScrollContainer;

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, ColorUtils.GREEN );
		setBackgroundBrush( bgColor );

	}
}
