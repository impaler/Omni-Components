package omni.components.style.brush;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IBrush;
import omni.components.core.OTextBase;

import nme.display.Sprite;
import nme.display.Graphics;

typedef TextFormatBrush = {
	var fontSize:Int;
	var fontName:String;
	var fontColor:Int;
	var fontBold:Bool;
	var fontItalic:Bool;
	var fontUnderline:Bool;
}

class BrushTextFormat implements IBrush
{
	public var formats:Hash<TextFormatBrush>;

	public function new( )
	{
	}

	public function setTextFormatState( state:String, formatBrush:TextFormatBrush ):Void
	{
		formats.set( state, formatBrush );
	}

	public function update( drawTarget:IOComponent )
	{
		var text = cast(drawTarget, OTextBase);

		if( formats.get( drawTarget.state ) != null )
		{
			var brushFormat = formats.get( drawTarget.state );
			text.fontSize = brushFormat.fontSize;
			text.fontName = brushFormat.fontName;
			text.fontColor = brushFormat.fontColor;
			text.fontBold = brushFormat.fontBold;
			text.fontItalic = brushFormat.fontItalic;
			text.fontUnderline = brushFormat.fontUnderline;
		}
	}
}
