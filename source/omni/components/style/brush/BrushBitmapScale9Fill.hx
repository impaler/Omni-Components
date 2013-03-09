package omni.components.style.brush;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IBrush;
import omni.utils.ComponentUtils;
import omni.utils.BitmapScaleSliceUtily;

class BrushBitmapScale9Fill extends BrushBitmapFill
{

//vertical left, vertical right, horizontal top, horizontal bottom

	public var scaleRect:Array<Int>;
	public var debuglines:Bool = false;
//todo smooth
//todo stretch
//todo cache sizes

	override public function update( drawTarget:IOComponent )
	{
        if(images.get(drawTarget.state) != null )
        {
		var bitmapdata = images.get( drawTarget.state );

		BitmapScaleSliceUtily.slice9( drawTarget.sprite, drawTarget.width, drawTarget.height, bitmapdata, scaleRect,
		                             smooth, debuglines );
        }
	}

	override public function destroy( ):Void
	{
		scaleRect = null;
		super.destroy( );
	}

}
