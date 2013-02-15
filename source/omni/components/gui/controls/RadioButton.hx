package omni.components.gui.controls;

import omni.components.core.OToggleButton;

class RadioButton extends OToggleButton
{

	override public function get_styleId( ):String
	{
		return RadioButtonStyle.styleString;
	}

}

class RadioButtonStyle extends OToggleButtonStyle
{
	public static var styleString:String = "RadioButtonStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}
