package omni.components.gui.layout.window;

import omni.components.gui.layout.VBox.VBoxStyle;

class WindowVBox extends VBox
{

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return WindowVBoxStyle.styleString;
	}
}

class WindowVBoxStyle extends VBoxStyle
{
	public static var styleString:String = "WindowVBoxStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}

}