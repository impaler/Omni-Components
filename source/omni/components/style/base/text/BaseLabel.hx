package omni.components.style.base.text;

import omni.components.style.base.BaseColors;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.core.OTextBase.TextBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.utils.ColorUtils;

import nme.Assets;
import nme.text.TextFormatAlign;
import nme.text.TextFieldType;

class BaseLabel extends LabelStyle
{
    public function new()
    {
        super();

        defaultHeight = 60;
        defaultWidth = 300;

        var font = Assets.getFont("assets/themes/color/text/roboto-regular.ttf");
        fontName = font.fontName;
        selectable = false;
        multiline = false;
        wordWrap = false;
        restrict = "0-9.\\-";
        fontSize = 50;
        type = TextFieldType.DYNAMIC;
        fontColor = BaseColors.LABEL_TEXT;
        defaultText = "Orange";

    }

}
