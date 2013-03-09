package omni.components.core;

import omni.components.core.OContainer.OContainerStyle;
import omni.components.core.interfaces.IStyle;
import omni.components.core.OCore;
import omni.components.core.signals.OSignalType;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.signals.OCoreEvent;
import omni.components.style.base.OBaseStyle;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.utils.OStates;

import nme.geom.Rectangle;
import nme.events.Event;
import nme.events.MouseEvent;

/**
* OButtonBase
* 
* @description A Generic Button Component intended to be extended upon
*
*/
class OButtonBase extends OContainer
{

//***********************************************************
//                  Public Variables
//***********************************************************

	public var onMouseOut:OSignalMouse;
	public var onMouseOver:OSignalMouse;
	public var onMouseDown:OSignalMouse;
	public var onMouseUp:OSignalMouse;
	public var onMouseClick:OSignalMouse;

	public var onClick:OSignalType<OButtonBase -> Void>;

	public var isOver:Bool = false;
	public var isDown:Bool = false;

//***********************************************************
//                  Component Overrides
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
		
		size(width, height);
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
			isDown = false;
			isOver = false;

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
		isDown = true;
		state = OStates.DOWN;
	}

	public function handleMouseUp( ?e:OSignalMouse ):Void
	{
		isDown = false;
		state = OStates.ACTIVE;
		isOver ? state = OStates.OVER : state = OStates.ACTIVE;
	}

	public function handleMouseOut( ?e:OSignalMouse ):Void
	{
		isOver = false;

		if( isDown == false )
			state = OStates.ACTIVE;
	}

	public function handleMouseOver( ?e:OSignalMouse ):Void
	{
		isOver = true;
		state = OStates.OVER;
	}

//***********************************************************
//                  Properties
//***********************************************************

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return OButtonBaseStyle.styleString;
	}
}

class OButtonBaseStyle extends OContainerStyle
{
	public static var styleString:String = "OButtonBaseStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}