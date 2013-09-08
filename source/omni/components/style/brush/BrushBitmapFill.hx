package omni.components.style.brush;

import omni.components.core.interfaces.IBrush;
import omni.components.core.interfaces.IOComponent;

import openfl.Assets;
import flash.display.Graphics;
import flash.display.BitmapData;

class BrushBitmapFill implements IBrush
{
    #if haxe3
	public var images:Map<String,BitmapData>;
	#else
    public var images:Hash<BitmapData>;
    #end

    public var smooth:Bool;

    public function setBitmapState(state:String, path:String):Void
    {
        var image = loadNMEGraphic(path);
        images.set(state, image);
    }

    public function setBitmapDataState(state:String, data:BitmapData):Void
    {
        images.set(state, data);
    }

    public function loadNMEGraphic(path:String):BitmapData
    {
        return Assets.getBitmapData(path);
    }

    public function new()
    {
        smooth = false;
        #if haxe3
		images = new Map();
		#else
        images = new Hash();
        #end
    }

    public function update(drawTarget:IOComponent)
    {
        if (images.get(drawTarget.state) != null && drawTarget.sprite != null)
        {
            var bitmapData = images.get(drawTarget.state);
            var graphics:Graphics = drawTarget.sprite.graphics;

            graphics.clear();
            graphics.beginBitmapFill(bitmapData, null, false, smooth);
            graphics.drawRect(0, 0, drawTarget.width, drawTarget.height);
            graphics.endFill();
        }
    }

    public function destroy():Void
    {
        images = null;
    }

}
