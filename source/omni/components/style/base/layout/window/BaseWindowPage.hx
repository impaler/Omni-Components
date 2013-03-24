package omni.components.style.base.layout.window;

import omni.components.gui.layout.window.WindowContentContainer;
import omni.components.gui.layout.window.WindowPage;
import omni.components.core.OContainerPage;
import omni.components.gui.layout.window.WindowPage.WindowPageStyle;
import omni.utils.OStates;
import omni.components.core.OContainerContent;
import omni.components.core.OContainerPage.OContainerPageStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class BaseWindowPage extends WindowPageStyle
{

	public function new( )
	{
		super( );
		
		defaultContainerType = WindowContentContainer;
		defaultWidth = 400;
		defaultHeight = 400;
		defaultPadding = 10;

	}

}
