package omni.components.style.base.core;

import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.core.OTextBase.TextBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.utils.ColorUtils;

import openfl.Assets;
import flash.text.TextFormatAlign;
import flash.text.TextFieldType;

class BaseOTextBase extends TextBaseStyle
{

    public function new()
    {
        super();

        defaultHeight = 60;
        defaultWidth = 300;

        defaultState = OStates.ACTIVE;
        defaultPadding = 0;

        var font = Assets.getFont("assets/themes/color/text/roboto-regular.ttf");
        fontName = font.fontName;
        selectable = false;
        multiline = false;
        wordWrap = false;
        restrict = "0-9.\\-";
        fontSize = 50;
        type = TextFieldType.DYNAMIC;
        fontColor = BaseColors.LABEL_TEXT;
        defaultText = "Orange Text";

    }

}
