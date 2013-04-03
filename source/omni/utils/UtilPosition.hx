package omni.utils;

import nme.display.Graphics;
import nme.display.Sprite;
import omni.components.core.interfaces.IOComponent;
import nme.display.DisplayObject;

class UtilPosition
{

    public static inline function VCentreAlignStage(moving:IOComponent):Void
    {
        VCentreAlignStageDisplayObject(moving.sprite);
    }

    public static inline function HCentreAlignStage(moving:IOComponent):Void
    {
        HCentreAlignStageDisplayObject(moving.sprite);
    }

    public static inline function VCentreAlignStageDisplayObject(moving:DisplayObject):Void
    {
        moving.y = (nme.Lib.stage.stageWidth * .5) - (moving.height * .5);
    }

    public static inline function HCentreAlignStageDisplayObject(moving:DisplayObject):Void
    {
        moving.x = (nme.Lib.stage.stageWidth * .5) - (moving.width * .5);
    }

    public static inline function VAlignToOther(moving:IOComponent, target:IOComponent):Void
    {
        moving.y = (target._height * .5) - (moving._height * .5);
    }

    public static inline function VAlignDisplayObjectToOther(moving:DisplayObject, target:DisplayObject):Void
    {
        moving.y = (target.height * .5) - (moving.height * .5);
    }

    public static inline function HAlignToOther(moving:IOComponent, target:IOComponent):Void
    {
        moving.x = (target._width * .5) - (moving._width * .5);
    }

    public static inline function HAlignDisplayObjectToOther(moving:DisplayObject, target:DisplayObject):Void
    {
        moving.x = (target.width * .5) - (moving.width * .5);
    }

    public static inline function setRegistrationPoint(parent:Sprite, regx:Float, regy:Float, color:Float = 0xffffff, line:Float = .2):Void
    {

        var markReg:Sprite = new Sprite();
        markReg.graphics.clear();
        markReg.graphics.lineStyle(line, color);
        markReg.graphics.moveTo(-5, -5);
        markReg.graphics.lineTo(5, 5);
        markReg.graphics.moveTo(-5, 5);
        markReg.graphics.lineTo(5, -5);
        markReg.graphics.endFill();
        parent.addChild(markReg);
        markReg.x = regx;
        markReg.y = regy;
    }

    public static inline function drawYRegLine(parent:Sprite, regy:Float, color:Int = 0xffffff, line:Float = .2):Void
    {
        var markReg:Sprite = new Sprite();
        markReg.graphics.clear();
        markReg.graphics.lineStyle(line, color);
        markReg.graphics.moveTo(0, regy);
        markReg.graphics.lineTo(nme.Lib.stage.stageWidth, regy);
        markReg.graphics.endFill();
        parent.addChild(markReg);
    }

    public static inline function drawXRegLine(parent:Sprite, regx:Float, color:Int = 0xffffff, line:Float = .2):Void
    {
        var markReg:Sprite = new Sprite();
        markReg.graphics.clear();
        markReg.graphics.lineStyle(line, color);
        markReg.graphics.moveTo(regx, 0);
        markReg.graphics.lineTo(regx, nme.Lib.stage.stageHeight);
        markReg.graphics.endFill();
        parent.addChild(markReg);
    }

    public static inline function drawBoxLine(?targetGraphics:Graphics, target:Sprite, color:Int = 0xffffff, line:Float = .4):Void
    {
        if (targetGraphics == null)
        {
            var markReg:Sprite = new Sprite();
            target.addChild(markReg);
            targetGraphics = markReg.graphics;
        }

        //		targetGraphics.clear( );
        targetGraphics.lineStyle(line, color);
        targetGraphics.drawRect(target.x, target.y, target.width, target.height);
        targetGraphics.endFill();

    }
}
