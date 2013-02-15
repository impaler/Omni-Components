package omni.components.gui.text;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.OTextBase;

import nme.text.TextFieldType;
import nme.text.TextFieldAutoSize;

class Label extends OTextBase
{

	override public function createMembers( ):Void
	{
		super.createMembers( );

		textField.autoSize = TextFieldAutoSize.LEFT;
		textField.type = TextFieldType.DYNAMIC;
		textField.mouseEnabled = false;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return LabelStyle.styleString;
	}
}

class LabelStyle extends TextBaseStyle
{

	public static var styleString:String = "LabelStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}

	override public function update( value:IOComponent ):Void
	{
		var textBase = cast ( value, OTextBase);

		textBase.updateTextFieldProperties( );
		textBase.updateTextFormat( );

		textBase._width = textBase.textField.width;
		textBase._height = textBase.textField.height;
	}

}