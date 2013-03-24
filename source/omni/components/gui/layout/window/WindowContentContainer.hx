package omni.components.gui.layout.window;

import omni.components.core.OContainer;
import omni.components.core.OLayout;
import omni.components.core.OContainerContent;

class WindowContentContainer extends OContainerContent
{

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return WindowContentContainerStyle.styleString;
	}
}

class WindowContentContainerStyle extends OContainerContentStyle
{
	public static var styleString:String = "WindowContentContainerStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}