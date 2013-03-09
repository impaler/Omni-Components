package omni.components.gui.layout;

import omni.utils.OStates;
import omni.components.core.OLayout;
import omni.components.core.OLayout.OLayoutStyle;

class VBox extends OLayout
{

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return VBoxStyle.styleString;
	}
}

class VBoxStyle extends OLayoutStyle
{
	public static var styleString:String = "VBoxStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}

}