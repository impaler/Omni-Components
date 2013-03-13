package omni.components.gui.controls;

import omni.utils.signals.OSignalMouse;
import omni.components.core.OToggleButton;

class RadioButton extends OToggleButton
{

	public var currentSelection:Bool = false;

	override public function handleMouseDown( ?e:OSignalMouse ):Void
	{
		if( !_value )
		{
			isDown = true;
			_value = ! _value;
			_state = getValueState( );
			invalidate( );
			onValueChange.dispatch( _value );
			onChange.dispatch( this );
		}
	}

//***********************************************************
//                  Component Style
//***********************************************************

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
