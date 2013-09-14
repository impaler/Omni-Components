package omni.components.style.brush;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IBrush;

import flash.display.Sprite;
import flash.display.Graphics;

class BrushColorFill implements IBrush
{
    #if haxe3
	public var colors:Map<String,Int>;
	#else
    public var colors:Hash<Int>;
    #end

    public function new()
    {
        #if haxe3
		colors = new Map();
		#else
        colors = new Hash();
        #end
    }

    public function setColorState(state:String, color:Int):Void
    {
        colors.set(state, color);
    }

    public function update(drawTarget:IOComponent)
    {
        if (colors.get(drawTarget.state) != null && drawTarget.sprite != null)
        {
            var color = colors.get(drawTarget.state);
            var graphics:Graphics = drawTarget.sprite.graphics;
            graphics.clear();
            graphics.beginFill(color, (color >> 24) & 255);
            graphics.drawRect(0, 0, drawTarget.width, drawTarget.height);
            graphics.endFill();
        }
    }

    public function destroy():Void
    {
        colors = null;
    }

}
