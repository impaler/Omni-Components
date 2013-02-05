package omni.examples.components;

import omni.components.core.OTextBase.TextBaseStyle;
import omni.components.core.OTextBase;

class TextTest
{

	public function new()
	{

		var textStyle = new TextBaseStyle();
		textStyle.fontSize = 40;
		textStyle.fontColor = 0xff3344;
		//	    textStyle.fontName = 0xff3344;

		var text = new OTextBase(textStyle);
		nme.Lib.stage.addChild(text.sprite);
	}

}
