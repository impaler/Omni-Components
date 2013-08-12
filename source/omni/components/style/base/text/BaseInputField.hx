package omni.components.style.base.text;

import omni.components.style.base.BaseColors;
import omni.components.gui.text.InputField.InputFieldStyle;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.core.OTextBase.TextBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.utils.ColorUtils;

import openfl.Assets;
import flash.text.TextFormatAlign;
import flash.text.TextFieldType;

class BaseInputField extends InputFieldStyle
{

    public function new()
    {
        super();

        defaultHeight = 50;
        defaultWidth = 200;

        var font = Assets.getFont("assets/themes/color/text/roboto-regular.ttf");
        fontName = font.fontName;
        selectable = true;
        multiline = false;
        wordWrap = false;
        //		restrict = "0-9.\\-";
        fontSize = 20;
        fontColor = BaseColors.INPUT_TEXT;
        defaultText = "Orange Input Text";

    }

}
