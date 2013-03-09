package omni.components.core;

import omni.components.core.signals.OSignalBool;
import omni.components.core.interfaces.IOComponent;
import omni.components.gui.text.Label;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.signals.OSignalType;
import omni.components.gui.controls.Button;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.utils.OStates;

class OToggleButton extends Button
{

//***********************************************************
//                  Public Variables
//***********************************************************

	public var value(get_value, set_value):Bool;
	public var _value:Bool;

	public var onChange:OSignalType<OToggleButton -> Void>;
	public var onValueChange:OSignalBool;

//***********************************************************
//                  Component Overrides
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
		isOver = true;
		state = getOverState( );
	}

	override public function handleMouseDown( ?e:OSignalMouse ):Void
	{
		isDown = true;
		_value = ! _value;
		_state = getValueState( );
		invalidate( );
		onValueChange.dispatch( _value );
		onChange.dispatch( this );
	}

	override public function handleMouseUp( ?e:OSignalMouse ):Void
	{
		isDown = false;
		isOver ? state = getOverState( ) : state = getOutState( );
	}

	override public function handleMouseOut( ?e:OSignalMouse ):Void
	{
		isOver = false;
		if( isDown == false ) state = getOutState( );
	}

//***********************************************************
//                  Component Methods
//***********************************************************

	public inline function getValueState( ):String
	{
		return value ? state = OStates.ON : OStates.OFF;
	}

	private inline function getOutState( ):String
	{
		return value ? OStates.ON : OStates.OFF;
	}

	private inline function getOverState( ):String
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
	
	public function setOffState( ):Void
	{
		value = false;
		this._state = getValueState( );
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
			_state = getValueState( );
			invalidate( );
			onValueChange.dispatch( _value );
			onChange.dispatch( this );
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

