package omni.components.gui.layout.list;

import omni.components.core.OComponent.OComponentStyle;

class ListItem extends OComponent
{
	
//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return ListItemStyle.styleString;
	}
}

class ListItemStyle extends OComponentStyle
{
	public static var styleString:String = "ListStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}