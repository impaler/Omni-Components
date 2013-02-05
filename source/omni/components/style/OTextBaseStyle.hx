package omni.components.style;

import omni.components.core.OTextBase;
import omni.components.utils.ComponentUtils;
import nme.text.TextFieldAutoSize;
import nme.text.TextFormatAlign;
import omni.components.core.interfaces.IBrush;
import omni.components.core.interfaces.IOComponent;

import nme.text.TextFieldType;

class OTextBaseStyle extends OBaseStyle
{

	public var background:IBrush;

	public var selectable:Bool;
	public var multiline:Bool;
	public var wordWrap:Bool;
	public var fontSize:Int;
	public var fontName:String;
	public var fontColor:Int;
	public var defaultText:String;

	//type dynamic as a workaround for flash/cpp type check inconsistency
	public var type(default, setType):Dynamic;

	//todo Restrict is not available on cpp neko yet?
	public var restrict:String;

	public override function initStyle(value:IOComponent):Void
	{
		super.initStyle(value);

		var textComponent = cast ( value, OTextBase);
		textComponent._fontName = fontName;
		textComponent._selectable = selectable;
		textComponent._multiline = multiline;
		textComponent._wordWrap = wordWrap;
		textComponent._fontSize = fontSize;
		textComponent._type = type;
		textComponent._align = ComponentUtils.convertTextAlignmentToString(TextFormatAlign.LEFT);
		textComponent._fontColor = fontColor;
		#if (flash || js)
		textComponent._restrict = restrict;
		#end
		if(defaultText != null && textComponent._text == null)
			textComponent._text = defaultText;
	}

	override public function update(value:IOComponent):Void
	{
		var textBase = cast ( value, OTextBase);

		textBase.updateTextFieldProperties();
		textBase.updateTextFormat();

		//todo TextFormatAlign is useless, so decide on fontsize/component size should relate
		textBase._width = textBase.textField.width;
		textBase._height = textBase.textField.height;

		//		if(background != null)
		//			background.update(value);
	}

	public function setType(value:Dynamic):String
	{
		type = Std.string(value);
		return type;
	}

	public function setBackgroundBrush(value:IBrush):Void
	{
		background = cast ( value, IBrush);
	}

	override public function destroy():Void
	{
		if(background != null)
		{
			background.destroy();
			background = null;
		}
	}

}