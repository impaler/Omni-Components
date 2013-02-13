package omni.components.gui.controls;

import omni.components.core.signals.OSignalMouse;
import omni.components.gui.layout.ContainerPage;
import omni.components.core.OToggleButton;

class TabButton extends OToggleButton
{
	public var containerPage:ContainerPage;

//***********************************************************
//                  Event Handlers
//***********************************************************

//	override public function handleMouseOver( ?e:OSignalMouse ):Void
//	{
//		_isOver = true;
//		state = getOverState( );
//	}
//
//	override public function handleMouseDown( ?e:OSignalMouse ):Void
//	{
//		_isDown = true;
//		_state = getValueState( );
//		value = ! _value;
//	}
//
//	override public function handleMouseUp( ?e:OSignalMouse ):Void
//	{
//		_isDown = false;
//		_isOver ? state = getOverState( ) : state = getOutState( );
//	}
//
//	override public function handleMouseOut( ?e:OSignalMouse ):Void
//	{
//		_isOver = false;
//		if( _isDown == false ) state = getOutState( );
//	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function getStyleId( ):String
	{
		return TabButtonStyle.styleString;
	}

}

class TabButtonStyle extends OToggleButtonStyle
{
	public static var styleString:String = "TabButtonStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}
