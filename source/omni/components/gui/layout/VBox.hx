package omni.components.gui.layout;

import omni.components.gui.layout.Layout.LayoutStyle;

class VBox extends Layout
{
	override public function getStyleId( ):String
	{
		return VBoxStyle.styleString;
	}

}

class VBoxStyle extends LayoutStyle
{
	public static var styleString:String = "VBoxStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
		defaultDirection = Layout.VERTICALLY;
	}

}