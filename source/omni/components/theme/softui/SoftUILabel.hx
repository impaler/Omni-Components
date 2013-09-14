package omni.components.theme.softui;

import omni.utils.ColorUtils;
import flash.text.TextFieldType;
import openfl.Assets;
import omni.components.gui.controls.Button.ButtonLabelStyle;

class SoftUILabel extends ButtonLabelStyle
{
    public function new()
    {
        super();

        defaultHeight = 60;
        defaultWidth = 100;

        var font = Assets.getFont("assets/themes/color/text/roboto-regular.ttf");
        fontName = font.fontName;
        selectable = false;
        multiline = false;
        wordWrap = false;
        restrict = "0-9.\\-";
        fontSize = 14;
        type = TextFieldType.DYNAMIC;
        fontColor = ColorUtils.BLACK;
        defaultText = "SoftUI";
    }
}
