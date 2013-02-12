package omni.utils;

import omni.components.core.interfaces.IOComponent;
import nme.display.DisplayObject;

class UtilPosition
{

	public static inline function VCentreAlignStage( moving:IOComponent ):Void
	{
		VCentreAlignStageDisplayObject( moving.sprite );
	}

	public static inline function HCentreAlignStage( moving:IOComponent ):Void
	{
		HCentreAlignStageDisplayObject( moving.sprite );
	}

	public static inline function VCentreAlignStageDisplayObject( moving:DisplayObject ):Void
	{
		moving.y = (nme.Lib.stage.stageWidth * .5) - (moving.height * .5);
	}

	public static inline function HCentreAlignStageDisplayObject( moving:DisplayObject ):Void
	{
		moving.x = (nme.Lib.stage.stageWidth * .5) - (moving.width * .5);
	}

	public static inline function VAlignToOther( moving:IOComponent, target:IOComponent ):Void
	{
		moving.y = (target._height * .5) - (moving._height * .5);
	}

	public static inline function VAlignDisplayObjectToOther( moving:DisplayObject, target:DisplayObject ):Void
	{
		moving.y = (target.height * .5) - (moving.height * .5);
	}

	public static inline function HAlignToOther( moving:IOComponent, target:IOComponent ):Void
	{
		moving.x = (target._width * .5) - (moving._width * .5);
	}

	public static inline function HAlignDisplayObjectToOther( moving:DisplayObject, target:DisplayObject ):Void
	{
		moving.x = (target.width * .5) - (moving.width * .5);
	}

}
