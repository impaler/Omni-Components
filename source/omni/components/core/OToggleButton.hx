package omni.components.core;

import omni.components.core.signals.OSignalBool;
import omni.components.core.interfaces.IOComponent;
import omni.components.gui.text.Label;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.signals.OSignalType;
import omni.components.gui.controls.Button;
import omni.components.style.OBackgroundStyle;

class OToggleButton extends Button
{
	public var value(get, set):Bool;
	public var _value:Bool;

	public var onChange:OSignalType<OToggleButton -> Void>;
	public var onValueChange:OSignalBool;

//***********************************************************
//                  Component Core
//***********************************************************

	override public function createComponentMembers( ):Void
	{
		super.createComponentMembers( );

		onChange = new OSignalType<OToggleButton -> Void>();
		onValueChange = new OSignalBool();
	}

	override public function destroy( ):Void
	{
		onChange.destroy( );
		onValueChange.destroy( );

		super.destroy( );
	}

//***********************************************************
//                  Event Handlers
//***********************************************************

	override public function handleMouseOver( ?e:OSignalMouse ):Void
	{
		_isOver = true;
		state = getOverState( );
	}

	override public function handleMouseDown( ?e:OSignalMouse ):Void
	{
		_isDown = true;
		_value = ! _value;
		_state = getValueState( );
		invalidate( );
		onValueChange.dispatch( _value );
		onChange.dispatch( this );
	}

	override public function handleMouseUp( ?e:OSignalMouse ):Void
	{
		_isDown = false;
		_isOver ? state = getOverState( ) : state = getOutState( );
	}

	override public function handleMouseOut( ?e:OSignalMouse ):Void
	{
		_isOver = false;
		if( _isDown == false ) state = getOutState( );
	}

//***********************************************************
//                  Component Methods
//***********************************************************

	public function getValueState( ):String
	{
		return value ? state = OToggleButtonStyle.STATE_ON : OToggleButtonStyle.STATE_OFF;
	}

	private function getOutState( ):String
	{
		return value ? OToggleButtonStyle.STATE_ON : OToggleButtonStyle.STATE_OFF;
	}

	private function getOverState( ):String
	{
		return value ? OToggleButtonStyle.STATE_ON_OVER : OToggleButtonStyle.STATE_OFF_OVER;
	}

//***********************************************************
//                  Properties
//***********************************************************

	public function set( b:Bool ):Bool
	{
		return setValue( b );
	}

	public function get( ):Bool
	{
		return _value;
	}

	public function setValue( b:Bool ):Bool
	{
		if( _value != b )
		{
			_value = b;
			invalidate( );
			onValueChange.dispatch( _value );
			onChange.dispatch( this );
		}
		return _value;
	}

	public function set_Value( b:Bool ):Bool
	{
		if( _value != b )
		{
			_value = b;
			_state = getValueState( );
			invalidate( );
		}
		return _value;
	}

	public function getValue( ):Bool
	{
		return _value;
	}

//***********************************************************
//                  Style
//***********************************************************

	override public function getStyleId( ):String
	{
		return OToggleButtonStyle.styleString;
	}

}

class OToggleButtonStyle extends ButtonStyle
{

	public static var styleString:String = "OToggleButtonStyle";

	public static var STATE_ON:String = "STATE_ON";
	public static var STATE_ON_OVER:String = "STATE_ON_OVER";

	public static var STATE_OFF:String = "STATE_OFF";
	public static var STATE_OFF_OVER:String = "STATE_OFF_OVER";

	public static var STATE_DISABLED:String = "STATE_DISABLED_ON";

	public function new( )
	{
		super( );
		styleID = styleString;

	}

	override public function initStyle( value:IOComponent ):Void
	{
		super.initStyle( value );

		var styleAs = cast (value, OToggleButton);

		styleAs._value = false;
		styleAs._value ? styleAs._state = STATE_ON : styleAs._state = STATE_OFF;
	}

}

