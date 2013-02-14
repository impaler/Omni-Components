package omni.components.theme.color.core;

import omni.components.style.OBaseStyle;
import omni.components.core.OTextBase.TextBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.utils.ColorUtils;

import nme.Assets;
import nme.text.TextFormatAlign;
import nme.text.TextFieldType;

class ColorTextBase extends TextBaseStyle
{

	public function new( )
	{
		super( );

		defaultHeight = 60;
		defaultWidth = 300;

		defaultState = OBaseStyle.STATE_ACTIVE;
		defaultPadding = 0;

		var font = Assets.getFont( "assets/themes/color/text/roboto-regular.ttf" );
		fontName = font.fontName;
		selectable = false;
		multiline = false;
		wordWrap = false;
		restrict = "0-9.\\-";
		fontSize = 50;
		type = TextFieldType.DYNAMIC;
		fontColor = ColorUtils.ORANGE_BRIGHT;
		defaultText = "Orange Text";

	}

}
