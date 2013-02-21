package omni.components.style;

import nme.display.BitmapData;
import omni.components.style.brush.BrushBitmapFill;
import omni.components.core.OStates;
import nme.Assets;
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

	public var styleID(get_styleId, setStyleID):String;

	public function get_styleId( ):String
	{
		return styleID;
	}

	public function setStyleID( value:String ):String
	{
		this.styleID = value;
		return this.styleID;
	}

	public function new( )
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

	public function initStyle( value:IOComponent ):Void
	{
		if( value._width == 0 )
			value._width = defaultWidth;

		if( value._height == 0 )
			value._height = defaultHeight;

		if( value._state == null )
			value._state = defaultState;

		if( value._padding == 0 )
			value._padding = defaultPadding;

		value.minWidth = minWidth;
		value.maxWidth = maxWidth;

		value.minHeight = minHeight;
		value.maxHeight = maxHeight;

	}

	public function update( value:IOComponent ):Void
	{
	}

	public function destroy( ):Void
	{

	}

	public function setMinSizeBitmap( BitmapBrush:BrushBitmapFill, state:String = "ACTIVE" ):Void
	{
		if (BitmapBrush.images.get(state)==null)
			throw "setMinSizeBitmap cannot find any bitmaps to determine min size in brush";
		
		var bitmap = cast(BitmapBrush.images.get(state), BitmapData);
		minWidth = bitmap.width;
		minHeight = bitmap.height;
	}
	
	public function setDefaultSize ( BitmapBrush:BrushBitmapFill, state:String = "ACTIVE" ):Void
	{
		if (BitmapBrush.images.get(state)==null)
			throw "setDefaultSize cannot find any bitmaps to determine the defaultSize in brush";
		
		var bitmap = cast(BitmapBrush.images.get(state), BitmapData);
		defaultWidth = bitmap.width;
		defaultHeight = bitmap.height;
	}

}

