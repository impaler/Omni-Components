package omni.components.gui.layout;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.style.OBackgroundStyle;

import nme.display.Sprite;

class Layout extends OComponent
{
	public var direction(default, setDirection):Int;
	public var _direction:Int;

	public var target:Sprite;

	public static var VERTICALLY:Int = 0;
	public static var HORIZONTALLY:Int = 1;

	override public function add( comp:IOComponent ):Void
	{
		super.add( comp );
		comp.drawNow( );
		invalidate( false );
	}

	override public function getHeight( ):Float
	{
		var last = 0;
		var heights = [];

		for( i in 0...components.length )
		{
			var current = cast (components[i], IOComponent);
			if( _direction == HORIZONTALLY )
			{
				heights.push( current.height + current.padding * 2 );
			}
			else
			{
				var paddingValue = padding + current.padding;

				if( i == (components.length - 1) )
				{
					paddingValue += padding + current.padding;
				}

				last = Std.int( last + current.height + paddingValue );
			}
		}

		if( _direction == HORIZONTALLY )
		{
			for( i in 0...heights.length )
			{
				if( heights[i] > last )
					last = Std.int( heights[i] );
			}
			last = Std.int( last + padding * 2 );
		}

		return set_Height( last );
	}

	override public function getWidth( ):Float
	{
		var last:Float = 0;
		var widths = [];

		for( i in 0...components.length )
		{
			var current = cast (components[i], IOComponent);
			widths.push( current.width + (current.padding * 2) + padding * 2 );
		}

		if( _direction == VERTICALLY )
		{
			for( i in 0...widths.length )
			{
				if( widths[i] > last )
					last = Std.int( widths[i] );
			}
		}

		if( _direction == HORIZONTALLY )
		{
			for( i in 0...widths.length )
			{
				var current = cast (components[i], IOComponent);
				last += current.width + (current.padding * 2);
//					last += Std.int(widths[i]);
			}
			last += (padding * widths.length + padding);
		}

		return set_Width( last );
	}

	override public function createMembers( ):Void
	{
		target = this.sprite;
	}

	override public function draw( ):Void
	{
		var last:Float = padding;

		for( i in 0...components.length )
		{
			var current = cast (components[i], IOComponent);

			if( _direction == HORIZONTALLY )
			{
				current.y = padding + current.padding;
				current.x = last;
				if( i == 0 )current.x += current.padding;
				last = current.x + current.width + padding + current.padding;
			}
			else if( _direction == VERTICALLY )
			{
				current.x = current.padding + padding;
				current.y = last;
				if( i == 0 )current.y += current.padding;
				last = (current.y + current.height) + current.padding + padding;
			}
		}

		super.draw( );
	}

	public function setDirection( value:Int ):Int
	{
		_direction = value;
		invalidate( );

		return _direction;
	}

	override public function getStyleId( ):String
	{
		return LayoutStyle.styleString;
	}
}

class LayoutStyle extends OBackgroundStyle
{

	public static var styleString:String = "LayoutStyle";
	public var defaultDirection:Int;

	public function new( )
	{
		super( );
		defaultDirection = Layout.VERTICALLY;
		styleID = styleString;
	}

	override public function initStyle( value:IOComponent ):Void
	{
		var styleAs = cast (value, Layout);

		styleAs._direction = defaultDirection;

		super.initStyle( value );
	}

}


