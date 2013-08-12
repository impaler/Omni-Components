package omni.components.style.base;

import flash.display.BitmapData;
import omni.components.style.brush.BrushBitmapFill;
import omni.utils.OStates;
import openfl.Assets;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IStyle;

class OBaseStyle implements IStyle
{

    public var defaultWidth:Float;
    public var minWidth:Float;
    public var maxWidth:Float;

    public var defaultHeight:Float;
    public var minHeight:Float;
    public var maxHeight:Float;

    public var defaultPadding:Float;
    public var defaultState:String;

    #if haxe3 @:isVar #end public var styleID(get_styleID, set_styleID):String;

    public function get_styleID():String
    {
        return styleID;
    }

    public function set_styleID(value:String):String
    {
        this.styleID = value;
        return this.styleID;
    }

    public function new()
    {
        defaultWidth = 100;
        defaultHeight = 100;
        maxHeight = Math.POSITIVE_INFINITY;
        maxWidth = Math.POSITIVE_INFINITY;
        minWidth = 0;
        minHeight = 0;
        defaultPadding = 0;
        defaultState = OStates.ACTIVE;
    }

    public function initStyle(value:IOComponent):Void
    {
        value.minWidth = minWidth;
        value.maxWidth = maxWidth;

        value.minHeight = minHeight;
        value.maxHeight = maxHeight;

        if (value._width == 0)
            value._width = defaultWidth;

        if (value._height == 0)
            value._height = defaultHeight;

        if (value._state == null)
            value._state = defaultState;

        if (value._padding == 0)
            value._padding = defaultPadding;
    }

    public function initStyleComponent(value:IOComponent):Void
    {

    }

    public function update(value:IOComponent):Void
    {
    }

    public function destroy():Void
    {

    }

    public function setMinSizeBitmap(BitmapBrush:BrushBitmapFill, state:String = "ACTIVE"):Void
    {
        if (BitmapBrush.images.get(state) == null)
            throw "setMinSizeBitmap cannot find any bitmaps to determine min size in brush";

        var bitmap = cast(BitmapBrush.images.get(state), BitmapData);
        minWidth = bitmap.width;
        minHeight = bitmap.height;
    }

    public function setDefaultSize(BitmapBrush:BrushBitmapFill, state:String = "ACTIVE"):Void
    {
        if (BitmapBrush.images.get(state) == null)
            throw "setDefaultSize cannot find any bitmaps to determine the defaultSize in brush";

        var bitmap = cast(BitmapBrush.images.get(state), BitmapData);
        defaultWidth = bitmap.width;
        defaultHeight = bitmap.height;
    }

}

