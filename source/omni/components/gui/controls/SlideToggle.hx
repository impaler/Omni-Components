package omni.components.gui.controls;

import omni.utils.OStates;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OButtonBase;
import omni.components.core.OComponentButton;
import omni.components.core.OToggleButton;
import omni.utils.signals.OSignalMouse;

import nme.geom.Rectangle;

class SlideToggle extends OToggleButton
{

	private var _dragRect:Rectangle;

	public var button:OButtonBase;
	public var onTolerancePercentage:Float;
	public var _sliding:Bool;

	override public function createMembers( ):Void
	{
		//super.createMembers();
		_sliding = false;

		button = new OButtonBase();
		add( button );
		button.onMouseDown.add( handleButtonMouseDown );
		button.onMouseUp.add( handleButtonMouseUp );

		onTolerancePercentage = 0.4;

		_dragRect = new Rectangle(0, 0, _width, _height);
	}

	override public function add( comp:IOComponent ):IOComponent
	{
		this.members.push( comp );
		coreAdd( comp );
		return comp;
	}

	public function handleButtonMouseDown( e:OSignalMouse ):Void
	{
		onMouseUp.removeAll();
		
		_sliding = true;
		_dragRect = new Rectangle(0, 0, _width - button._width, _height - button._height);
		button.startDrag( false, _dragRect );
		
	}

	public function handleButtonMouseUp( e:OSignalMouse ):Void
	{
		onMouseUp.add( handleMouseUp );
		_sliding = false;
	
		if( button.x == 0 )
		{
			value = false;
		}
		else if( button.x > (_width - button._width) - onToleranceValue( ) )
		{
			value = true;
			moveToOnPosition( );
		}
		else
		{
			value = false;
			moveToOffPosition( );
		}
		button.stopDrag( );
		
	
	}

	public inline function onToleranceValue( ):Float
	{
		return ((_width / 100) * onTolerancePercentage) * 100;
	}

	public inline function moveToOffPosition( ):Void
	{
		button.x = 0;
	}

	public inline function moveToOnPosition( ):Void
	{
		button.x = _width - button._width;
	}

	override public function handleMouseOver( ?e:OSignalMouse ):Void
	{
//isOver = true;
//state = getOverState( );
	}

	override public function handleMouseDown( ?e:OSignalMouse ):Void
	{
//isDown = true;
//_value = ! _value;
//_state = getValueState( );
//invalidate( );
//onValueChange.dispatch( _value );
//onChange.dispatch( this );
	}

	override public function handleMouseUp( ?e:OSignalMouse ):Void
	{
//isDown = false;
		_value == true ? value = false : value = true;
		
		if( value == true )
		{
			moveToOnPosition( );
		}
		else
		{
			moveToOffPosition( );
		}
		
		nme.Lib.trace(_value);
	}

	override public function handleMouseOut( ?e:OSignalMouse ):Void
	{
//isOver = false;
//if( isDown == false ) state = getOutState( );
	}

	override public function draw( ):Void
	{
		coreDraw( );
	}

	override public function drawMembers( ):Void
	{
		super.drawMembers( );
		button.height = _height;
	}

//***********************************************************
//                  Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return SlideToggleStyle.styleString;
	}

}

class SlideToggleStyle extends OToggleButtonStyle
{

	public static var styleString:String = "SlideToggleStyle";

	public function new( )
	{
		super( );
		styleID = styleString;

	}
}

