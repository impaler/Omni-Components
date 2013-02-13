package omni.components.gui.layout;

import omni.components.core.OToggleButtonGroup;
import omni.components.core.interfaces.IStyle;
import omni.components.gui.layout.Layout.LayoutStyle;
import omni.components.gui.controls.RadioButton;
import omni.components.core.signals.OSignalType;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OToggleButton;
import omni.components.core.OComponent;
import omni.components.style.OBackgroundStyle;

class RadioButtonGroup extends OToggleButtonGroup
{

//***********************************************************
//                  Component Core
//***********************************************************

//***********************************************************
//                  Event Handlers
//***********************************************************

//***********************************************************
//                  Component Methods
//***********************************************************

	override public function addButton( style:IStyle = null ):RadioButton
	{
		var button = new RadioButton(style);
		button.onChange.add( handleButtonChange );
		this.components.push( button );
		layout.add( button );

		return button;
	}

//***********************************************************
//                  Properties
//***********************************************************

//***********************************************************
//                  Component Style
//***********************************************************

	override public function getStyleId( ):String
	{
		return RadioButtonGroupStyle.styleString;
	}
}

class RadioButtonGroupStyle extends OToggleButtonGroupStyle
{
	public static var styleString:String = "RadioButtonGroupStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}

}