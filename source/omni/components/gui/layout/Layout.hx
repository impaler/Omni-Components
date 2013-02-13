package omni.components.gui.layout;

import nme.geom.Rectangle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.style.OBackgroundStyle;

import nme.display.Sprite;

class Layout extends OComponent
{
	public var direction(default, setDirection):Int;
	public var _direction:Int;

	public var scrollRectEnabled(getScrollRectEnabled, setScrollRectEnabled):Bool;
	public var _scrollRectEnabled:Bool = false;

	public var _scrollRect:Rectangle;

	public var target:Sprite;

	public static var VERTICALLY:Int = 0;
	public static var HORIZONTALLY:Int = 1;

	override public function createMembers( ):Void
	{
		super.createMembers( );

		_scrollRect = new Rectangle(0, 0, _width, _height);
		target = this.sprite;
	}

	override public function add( comp:IOComponent ):Void
	{
		super.add( comp );
		comp.drawNow( );
		invalidate( false );
	}

	override public function getHeight( ):Float
	{
		if( ! _scrollRectEnabled )
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
		else
		{
			return super.getHeight( );
		}
	}

	override public function getWidth( ):Float
	{
		if( ! _scrollRectEnabled )
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
		else
		{
			return super.getWidth( );
		}
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

		if( _scrollRectEnabled )
		{
			_scrollRect.width = width;
			_scrollRect.height = height;
			sprite.scrollRect = _scrollRect;
		}

		super.draw( );
	}

	public function setDirection( value:Int ):Int
	{
		_direction = value;
		invalidate( );

		return _direction;
	}

	public function getScrollRectEnabled( ):Bool
	{
		return _scrollRectEnabled;
	}

	public function setScrollRectEnabled( b:Bool ):Bool
	{
		_scrollRectEnabled = b;
		if( ! _scrollRectEnabled ) sprite.scrollRect = null;
		return _scrollRectEnabled;
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
	public var defaultScrollRect:Bool;

	public function new( )
	{
		super( );
		defaultDirection = Layout.VERTICALLY;
		defaultScrollRect = false;
		styleID = styleString;
	}

	override public function initStyle( value:IOComponent ):Void
	{
		var styleAs = cast (value, Layout);

		styleAs._direction = defaultDirection;
		styleAs._scrollRectEnabled = defaultScrollRect;

		super.initStyle( value );
	}

}


