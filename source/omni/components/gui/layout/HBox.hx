package omni.components.gui.layout;

import omni.components.core.interfaces.IOComponent;
import omni.components.gui.layout.Layout.LayoutStyle;

class HBox extends Layout
{
	override public function getStyleId( ):String
	{
		return HBoxStyle.styleString;
	}

}

class HBoxStyle extends LayoutStyle
{
	public static var styleString:String = "HBoxStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
		defaultDirection = Layout.HORIZONTALLY;
	}
}