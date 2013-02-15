package omni.components.style;

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

	public static var STATE_ACTIVE:String = "Active";
	public static var STATE_DISABLED:String = "Disabled";

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
		defaultState = OBaseStyle.STATE_ACTIVE;
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
	}

	public function update( value:IOComponent ):Void
	{
	}

	public function destroy( ):Void
	{

	}

	public function setMinSizeBitmap( path:String ):Void
	{
		var bitmap = Assets.getBitmapData( path );
		minWidth = bitmap.width;
		minHeight = bitmap.height;
	}

}

