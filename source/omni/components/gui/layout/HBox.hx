package omni.components.gui.layout;

import omni.components.core.OLayout;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OLayout.OLayoutStyle;

class HBox extends OLayout
{
	override public function getStyleId( ):String
	{
		return HBoxStyle.styleString;
	}

}

class HBoxStyle extends OLayoutStyle
{
	public static var styleString:String = "HBoxStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
		defaultDirection = OLayout.HORIZONTALLY;
	}
}