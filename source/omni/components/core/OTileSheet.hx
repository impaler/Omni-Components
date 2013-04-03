package omni.components.core;

import nme.Assets;
import nme.geom.Point;
import nme.geom.Rectangle;
import omni.components.core.interfaces.IDestroyable;

import nme.display.Tilesheet;
import nme.display.BitmapData;

class OTileSheet implements IDestroyable
{

    public var tileSheets:Hash<Tilesheet>;

    public var lastTileID:Int = 0;

    public static var instance(get_instance, null):OTileSheet;

    private static function get_instance():OTileSheet
    {
        if (instance == null)
        {
            instance = new OTileSheet();
        }
        return instance;
    }

    public function new()
    {
        tileSheets = new Hash();
    }

    public function add(id:String, path:String):Void
    {
        var bitmap = Assets.getBitmapData(path);
        var tileSheet = new Tilesheet(bitmap);
        tileSheets.set(id, tileSheet);
    }

    public function addTileRect(sheetID:String, rectangle:Rectangle, centerPoint:Point = null):Int
    {
        var tileSheet = get(sheetID);
        tileSheet.addTileRect(rectangle, centerPoint);
        var id = lastTileID;
        lastTileID ++;

        return id;
    }

    public function get(id:String):Tilesheet
    {
        return tileSheets.get(id);
    }

    public function remove(id:String):Void
    {
        tileSheets.remove(id);
    }

    public function destroy():Void
    {
        tileSheets = null;
    }

}

class TileDef
{

    public var sheetID:String;
    public var tileID:Float;
    public var rect:Rectangle;

    public function new():Void
    {
    }
}