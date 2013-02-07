package omni.components.gui.controls;

import omni.components.core.interfaces.IBrush;
import omni.components.core.interfaces.IOComponent;
import omni.components.gui.layout.Icon.IconStyle;
import omni.components.gui.layout.Icon;
import omni.components.utils.ComponentUtils;
import omni.components.gui.text.Label;
import omni.components.core.OButtonBase;

import nme.Assets;
import nme.display.Sprite;
import nme.display.Bitmap;

class Button extends OButtonBase
{

	public var label:Label;

	public var labelText(getLabelText, setLabelText):String;
	public var _labelText:String = "";

	public var icon:Icon;

	private var _paddingLeft:Int;

	override public function createMembers():Void
	{
		super.createMembers();

		label = new Label(buttonStyle.labelText);
		add(label);

		icon = new Icon(buttonStyle.icon);
		add(icon);

		_paddingLeft = 20;

	}

	public function setLabelText(value:String):String
	{
		if(_labelText != value)
		{
			_labelText = value;
			label.text = _labelText;
		}
		return _labelText;
	}

	public function getLabelText():String
	{
		return _labelText;
	}

	override public function draw():Void
	{
		coreDraw();

		arrangeMembers();
	}

	public function arrangeMembers():Void
	{

		if(icon != null)
		{
			icon.x = _paddingLeft;
			ComponentUtils.VAlignToOther(icon, this);
		}

		if(label != null)
		{
			label.x = icon.x + icon._width + _paddingLeft;
			ComponentUtils.VAlignToOther(label, this);
		}

	}

	//***********************************************************
	//                  Component Style
	//***********************************************************

	public var buttonStyle(getButtonStyle, null):ButtonStyle;

	public function getButtonStyle():ButtonStyle
	{
		return cast(_style, ButtonStyle);
	}

	override public function getStyleId():String
	{
		return ButtonStyle.styleString;
	}
}

import omni.components.style.OBackgroundStyle;

class ButtonStyle extends OButtonBaseStyle
{
	public static var styleString:String = "ButtonStyle";

	public var labelText:LabelStyle;
	public var icon:IconStyle;

	public function new()
	{
		super();
		styleID = styleString;
	}

	override public function update(value:IOComponent):Void
	{
		super.update(value);

		var button = cast(value, Button);

		if(labelText != null)
			labelText.update(button.label);

		if(icon != null)
			icon.update(button.icon);

	}

}