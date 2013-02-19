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
	public var onMouseOut:OSignalMouse;
	public var onMouseOver:OSignalMouse;
	public var onMouseDown:OSignalMouse;
	public var onMouseUp:OSignalMouse;
	public var onMouseClick:OSignalMouse;

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

		onMouseOut = new OSignalMouse(OSignalMouse.OUT, this.sprite);
		onMouseOver = new OSignalMouse(OSignalMouse.OVER, this.sprite);
		onMouseDown = new OSignalMouse(OSignalMouse.DOWN, this.sprite);
		onMouseUp = new OSignalMouse(OSignalMouse.UP, this.sprite);
		onMouseClick = new OSignalMouse(OSignalMouse.CLICK, this.sprite);

		onClick = new OSignalType<OButtonBase -> Void>();
	}

	override public function enableSignals( ):Void
	{
		if( ! _listening )
		{
			onMouseOut.add( handleMouseOut );
			onMouseOver.add( handleMouseOver );
			onMouseDown.add( handleMouseDown );
			onMouseUp.add( handleMouseUp );
			onMouseClick.add( handleMouseClick );
			OCore.instance.onStageMouseUp.add( handleMouseUp );

			_listening = true;
		}
	}

	override public function disableSignals( ):Void
	{
		if( _listening )
		{
			_isDown = false;
			_isOver = false;

			onMouseOut.removeAll( );
			onMouseOver.removeAll( );
			onMouseDown.removeAll( );
			onMouseUp.removeAll( );
			onMouseClick.removeAll( );
			OCore.instance.onStageMouseUp.remove( handleMouseUp );

			_listening = false;
		}
	}

	override public function destroy( ):Void
	{
		onMouseOut.destroy( );
		onMouseOver.destroy( );
		onMouseDown.destroy( );
		onMouseUp.destroy( );
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
		state = OStates.DOWN;
	}

	public function handleMouseUp( ?e:OSignalMouse ):Void
	{
		_isDown = false;
		state = OStates.ACTIVE;
		_isOver ? state = OStates.OVER : state = OStates.ACTIVE;
	}

	public function handleMouseOut( ?e:OSignalMouse ):Void
	{
		_isOver = false;

		if( _isDown == false )
			state = OStates.ACTIVE;
	}

	public function handleMouseOver( ?e:OSignalMouse ):Void
	{
		_isOver = true;
		state = OStates.OVER;
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

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}