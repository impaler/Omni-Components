package omni.components.style.brush;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IBrush;

import nme.display.Sprite;
import nme.display.Graphics;

class BrushColorFillOutline implements IBrush
{
    public var colors:Map<String, FillOutline>;

    public function new()
    {
        colors = new Map();
    }

    public function setColorState(state:String, color:FillOutline):Void
    {
        colors.set(state, color);
    }

    public function update(drawTarget:IOComponent)
    {
        if (colors.get(drawTarget.state) != null)
        {
            var color = colors.get(drawTarget.state);
            var drawingGraphics = cast (drawTarget.sprite.graphics, Graphics);
            drawingGraphics.clear();
            drawingGraphics.lineStyle(color.outlineThickness, color.outlineColor, color.outlineAlpha)
            drawingGraphics.beginFill(color.fillColor);
            drawingGraphics.drawRect(0, 0, drawTarget.width, drawTarget.height);
            drawingGraphics.endFill();
        }
    }

    public function destroy():Void
    {
        colors = null;
    }

}

typedef FillOutline = {
    var fillColor:Int;
    var outlineColor:Int;
    var outlineThickness:Float;
    var outlineAlpha:Float;
}