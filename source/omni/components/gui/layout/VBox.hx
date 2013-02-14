package omni.components.gui.layout;

import omni.components.core.OLayout;
import omni.components.core.OLayout.OLayoutStyle;

class VBox extends OLayout
{
	override public function getStyleId( ):String
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
		defaultDirection = OLayout.VERTICALLY;
	}

}