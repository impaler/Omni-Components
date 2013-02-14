package omni.components.theme.color.text;

import omni.components.gui.text.InputField.InputFieldStyle;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.style.OBaseStyle;
import omni.components.core.OTextBase.TextBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.utils.ColorUtils;

import nme.Assets;
import nme.text.TextFormatAlign;
import nme.text.TextFieldType;

class ColorInputField extends InputFieldStyle
{

	public function new( )
	{
		super( );

		defaultHeight = 50;
		defaultWidth = 200;

		var font = Assets.getFont( "assets/themes/color/text/roboto-regular.ttf" );
		fontName = font.fontName;
		selectable = true;
		multiline = false;
		wordWrap = false;
//		restrict = "0-9.\\-";
		fontSize = 20;
		fontColor = ColorUtils.ORANGE_BRIGHT;
		defaultText = "Orange Input Text";

	}

}
