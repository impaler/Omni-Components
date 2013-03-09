package omni.components.style.base.core;

import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.gui.layout.VBox;
import omni.components.gui.layout.ScrollContainer;
import omni.components.gui.layout.ContainerContent.ContainerContentStyle;
import omni.components.style.brush.BrushColorFill;

class BaseContentContainer extends ContainerContentStyle
{
	public function new( )
	{
		super( );

		defaultWidth = 300;
		defaultHeight = 300;
		defaultScrollRect = true;
		
		//todo Vbox object for Content Containers
		defaultLayoutType = VBox;
		defaultContainerType = ScrollContainer;

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, BaseColors.BG );
		setBackgroundBrush( bgColor );
	
	}
}