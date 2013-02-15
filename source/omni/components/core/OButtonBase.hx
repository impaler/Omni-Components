package omni.components.core;

import omni.components.core.signals.OSignalType;
import omni.components.core.interfaces.IStyle;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.signals.OCoreEvent;
import omni.components.style.OBaseStyle;
import omni.components.core.OCore;
import omni.components.style.OBackgroundStyle;

import nme.events.Event;
import nme.events.MouseEvent;

/**
* OButtonBase
* 
* @description A Generic Button Component intended to be extended upon
*
*/
class OButtonBase extends OComponent
{
	public var mouseOut:OSignalMouse;
	public var mouseOver:OSignalMouse;
	public var mouseDown:OSignalMouse;
	public var mouseUp:OSignalMouse;
	public var mouseClick:OSignalMouse;

	public var onClick:OSignalType<OButtonBase -> Void>;

	private var _isOver:Bool = false;
	private var _isDown:Bool = false;

//***********************************************************
//                  Component Core
//***********************************************************

	override public function createComponentMembers( ):Void
	{
		super.createComponentMembers( );

		buttonMode = true;

		mouseOut = new OSignalMouse(OSignalMouse.OUT, this.sprite);
		mouseOver = new OSignalMouse(OSignalMouse.OVER, this.sprite);
		mouseDown = new OSignalMouse(OSignalMouse.DOWN, this.sprite);
		mouseUp = new OSignalMouse(OSignalMouse.UP, this.sprite);
		mouseClick = new OSignalMouse(OSignalMouse.CLICK, this.sprite);

		onClick = new OSignalType<OButtonBase -> Void>();
	}

	override public function enableSignals( ):Void
	{
		if( ! _listening )
		{
			mouseOut.add( handleMouseOut );
			mouseOver.add( handleMouseOver );
			mouseDown.add( handleMouseDown );
			mouseUp.add( handleMouseUp );
			mouseClick.add( handleMouseClick );
			OCore.instance.onStageMouseUp.add( handleMouseUp );

			_listening = true;
		}
	}

	override public function disableSignals( ):Void
	{
		if( _listening )
		{
			state = OBaseStyle.STATE_ACTIVE;

			_isDown = false;
			_isOver = false;

			mouseOut.removeAll( );
			mouseOver.removeAll( );
			mouseDown.removeAll( );
			mouseUp.removeAll( );
			mouseClick.removeAll( );
			OCore.instance.onStageMouseUp.remove( handleMouseUp );

			_listening = false;
		}
	}

	override public function destroy( ):Void
	{
		mouseOut.destroy( );
		mouseOver.destroy( );
		mouseDown.destroy( );
		mouseUp.destroy( );
		onClick.destroy( );
		OCore.instance.onStageMouseUp.remove( handleMouseUp );

		super.destroy( );
	}

//***********************************************************
//                  Event Handlers
//***********************************************************

	public function handleMouseClick( ?e:OSignalMouse ):Void
	{
		onClick.dispatch( this );
	}

	public function handleMouseDown( ?e:OSignalMouse ):Void
	{
		_isDown = true;
		state = OButtonBaseStyle.STATE_DOWN;
	}

	public function handleMouseUp( ?e:OSignalMouse ):Void
	{
		_isDown = false;
		state = OBaseStyle.STATE_ACTIVE;
		_isOver ? state = OButtonBaseStyle.STATE_OVER : state = OBaseStyle.STATE_ACTIVE;
	}

	public function handleMouseOut( ?e:OSignalMouse ):Void
	{
		_isOver = false;

		if( _isDown == false )
			state = OBaseStyle.STATE_ACTIVE;
	}

	public function handleMouseOver( ?e:OSignalMouse ):Void
	{
		_isOver = true;
		state = OButtonBaseStyle.STATE_OVER;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return OButtonBaseStyle.styleString;
	}
}

class OButtonBaseStyle extends OBackgroundStyle
{
	public static var styleString:String = "OButtonBaseStyle";

	public static var STATE_OVER:String = "STATE_OVER";
	public static var STATE_DOWN:String = "STATE_DOWN";

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}