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
	public var value(get_value, set_value):Bool;
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
		return value ? state = OStates.ON : OStates.OFF;
	}

	private function getOutState( ):String
	{
		return value ? OStates.ON : OStates.OFF;
	}

	private function getOverState( ):String
	{
		return value ? OStates.ON_OVER : OStates.OFF_OVER;
	}

//***********************************************************
//                  Properties
//***********************************************************

	override public function setActiveState( ):Void
	{
		this._state = getOutState( );
		invalidate( );
	}

	public function set_value( b:Bool ):Bool
	{
		return setValue( b );
	}

	public function get_value( ):Bool
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

	override public function get_styleId( ):String
	{
		return OToggleButtonStyle.styleString;
	}

}

class OToggleButtonStyle extends ButtonStyle
{

	public static var styleString:String = "OToggleButtonStyle";

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
		styleAs._value ? styleAs._state = OStates.ON : styleAs._state = OStates.OFF;
	}

}

