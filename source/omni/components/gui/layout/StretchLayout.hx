package omni.components.gui.layout;

import omni.components.core.OLayout;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.style.base.OBaseBackgroundStyle;

import nme.display.Sprite;

class StretchLayout extends OLayout
{

	override public function add( comp:IOComponent ):Void
	{
		super.add( comp );
		invalidate( );
	}

	override public function getHeight( ):Float
	{
		return _height;
	}

	override public function getWidth( ):Float
	{
		return _width;
	}

	override public function draw( ):Void
	{

		for( i in 0...members.length )
		{
			var current = cast (members[i], IOComponent);

//			current._width = current.widthPercent / components.length / _width

		}

		super.draw( );
	}

	public function setDirection( value:Int ):Int
	{
		_direction = value;
		invalidate( );

		return _direction;
	}

	override public function get_styleId( ):String
	{
		return StretchLayoutStyle.styleString;
	}
}

/**
* StretchLayoutStyle
*/
class StretchLayoutStyle extends OLayoutStyle
{

	public static var styleString:String = "StretchLayoutStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}


