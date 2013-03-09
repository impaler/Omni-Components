package omni.components.gui.controls;

import omni.utils.OStates;
import omni.components.core.signals.OSignalMouse;
import omni.components.gui.layout.ContainerPage;
import omni.components.core.OToggleButton;

class TabButton extends OToggleButton
{

//***********************************************************
//                  Public Variables
//***********************************************************

	public var containerPage:ContainerPage;

//***********************************************************
//                  Event Handlers
//***********************************************************

    override public function handleMouseDown( ?e:OSignalMouse ):Void
    {
        isDown = true;
        if(_value == true)
        {
            return;
        }
        _state = getValueState( );
        invalidate( );
        onValueChange.dispatch( _value );
        onChange.dispatch( this );
    }

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
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
