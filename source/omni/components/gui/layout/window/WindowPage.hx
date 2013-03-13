package omni.components.gui.layout.window;

import omni.components.core.OContainerPage;

class WindowPage extends OContainerPage
{
	
//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return WindowPageStyle.styleString;
	}
}

class WindowPageStyle extends OContainerPageStyle
{
	public static var styleString:String = "WindowPageStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}