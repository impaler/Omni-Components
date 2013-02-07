package omni.examples.components;

import nme.installer.Assets;
import nme.text.TextFormat;
import nme.text.TextFieldAutoSize;
import nme.text.TextFieldType;
import nme.text.TextField;
import omni.components.gui.text.InputField;
import omni.components.gui.text.Label;
import omni.components.core.OCore;
import omni.components.core.OTextBase.TextBaseStyle;
import omni.components.core.OTextBase;

class TextTest
{

	public function new()
	{

		//		var textStyle = new TextBaseStyle();
		//		textStyle.fontSize = 40;
		//		textStyle.fontColor = 0xff3344;
		//	    textStyle.fontName = 0xff3344;

		//		var text = new OTextBase(textStyle);

		var text = new OTextBase();
		OCore.addChild(text);

		var text = new Label();
		text.y = 60;
		OCore.addChild(text);

		var input = new InputField();
		input.y = 120;
		OCore.addChild(input);

		//		input.textField.selectable = true;
		//		input.buttonMode = true;
		//		input.sprite.mouseEnabled = true;
		//		input.sprite.mouseChildren = true;
		//		input.textField.mouseEnabled = true;
		////		input.textField.mouseEnabled = true;

		//		
		//		var textTest = new TextField();
		//		textTest.text = "INPUT";
		//		textTest.type = TextFieldType.INPUT;
		//		textTest.autoSize = TextFieldAutoSize.LEFT;
		//		textTest.y = 200;
		//		var fonty = Assets.getFont("assets/themes/orange/text/roboto-regular.ttf");
		//		textTest.embedFonts= true;
		//		var formaty = new TextFormat();
		//		formaty.font = fonty.fontName;
		//		formaty.size = 50;
		//		textTest.setTextFormat(formaty);
		//		input.sprite.addChild(textTest);
		////		nme.Lib.stage.addChild(textTest);
		//		input.x = 30;
		//		
	}

}
