package omni.components.style.brush;

import flash.geom.Point;
import flash.geom.Rectangle;
import omni.components.core.OTileSheet;
import flash.display.Tilesheet;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IBrush;

import flash.display.Sprite;
import flash.display.Graphics;

class BrushDrawTiles implements IBrush
{
    public var sheetID:String;
    public var statePositions:Hash<TileDef>;

    public function new()
    {
        statePositions = new Hash();
    }

    public function addTile(state:String, rect:Rectangle, sheetID:String):Void
    {
        var tileID = OTileSheet.instance.addTileRect(sheetID, rect);

        var tile = new TileDef();
        tile.sheetID = sheetID;
        tile.tileID = tileID;
        tile.rect = rect;

        statePositions.set(state, tile);
    }

    public function update(drawTarget:IOComponent)
    {
        var TileData = statePositions.get(drawTarget.state);
        var graphicsTarget:Graphics = drawTarget.sprite.graphics;
        graphicsTarget.clear();

        var tileID = TileData.tileID;
        var tileX = 0;
        var tileY = 0;
        var tileData:Array<Float>;
        tileData = [tileX, tileY, tileID];

        var sheet = OTileSheet.instance.get(TileData.sheetID);
        sheet.drawTiles(graphicsTarget, tileData);
    }

    public function destroy():Void
    {
        statePositions = null;
    }

}
