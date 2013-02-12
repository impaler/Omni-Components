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

	public function handleSetTrue( ):Void
	{
		_isDown = true;
		_value = true;
		_state = OToggleButtonStyle.STATE_ON;
//		invalidate( );
	}

//	override public function handleMouseDown( ?e:OSignalMouse ):Void
//	{
//		_isDown = true;
//		_value = true;
//		_state = getValueState();
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
