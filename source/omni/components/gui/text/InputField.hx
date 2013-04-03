package omni.components.gui.text;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.OTextBase;

import nme.text.TextFieldType;
import nme.text.TextFieldAutoSize;

class InputField extends OTextBase
{

    override public function createComponentMembers():Void
    {
        super.createComponentMembers();

        textField.autoSize = TextFieldAutoSize.NONE;
        textField.type = TextFieldType.INPUT;
        textField.selectable = true;

    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return InputFieldStyle.styleString;
    }
}

class InputFieldStyle extends TextBaseStyle
{

    public static var styleString:String = "InputFieldStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }

    override public function update(value:IOComponent):Void
    {
        var textBase = cast ( value, OTextBase);

        textBase.updateTextFieldProperties();
        textBase.updateTextFormat();

        textBase.textField.width = textBase._width;
        textBase.textField.height = textBase._height;
    }

}