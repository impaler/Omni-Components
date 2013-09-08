package omni.components.style.brush;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IBrush;
import omni.components.core.OTextBase;

typedef TextFormatProperties = {
    var fontSize:Int;
    var fontName:String;
    var fontColor:Int;
    var fontBold:Bool;
    var fontItalic:Bool;
    var fontUnderline:Bool;
}

class BrushTextFormat implements IBrush
{
    #if haxe3
    public var formats:Map<String, TextFormatProperties>;
    #else
    public var formats:Hash<TextFormatProperties>;
    #end

    public function new()
    {
        #if haxe3
		formats = new Map();
		#else
        formats = new Hash();
        #end
    }

    public function setTextFormatState(state:String, formatBrush:TextFormatProperties):Void
    {
        formats.set(state, formatBrush);
    }

    public function update(drawTarget:IOComponent)
    {
        var text = cast(drawTarget, OTextBase);

        if (formats.get(drawTarget.state) != null)
        {
            //var brushFormat = cast ( formats.get(drawTarget.state), TextFormatProperties);
            //text._fontSize = brushFormat.fontSize;
            //text._fontName = brushFormat.fontName;
            //text._fontColor = brushFormat.fontColor;
            //text._fontBold = brushFormat.fontBold;
            //text._fontItalic = brushFormat.fontItalic;
            //text._fontUnderline = brushFormat.fontUnderline;
        }
    }

    public function destroy():Void
    {
    }


}
