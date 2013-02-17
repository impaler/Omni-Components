package omni.components.core;

import nme.geom.Rectangle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.style.OBackgroundStyle;

import nme.display.Sprite;

class OLayout extends OComponent
{
	public var direction(default, set_direction):String;
	public var _direction:String;

	public var scrollRectEnabled(get_scrollRectEnabled, set_scrollRectEnabled):Bool;
	public var _scrollRectEnabled:Bool = false;

	public var _scrollRect:Rectangle;

	public var target:Sprite;

	override public function createMembers( ):Void
	{
		super.createMembers( );

		_scrollRect = new Rectangle(0, 0, _width, _height);
		target = this.sprite;
	}

	override public function add( comp:IOComponent ):IOComponent
	{
		super.add( comp );
		comp.drawNow( );
		invalidate( false );

		return comp;
	}

	override public function get_height( ):Float
	{
		if( ! _scrollRectEnabled )
		{
			var last = 0;
			var heights = [];

			for( i in 0...components.length )
			{
				var current = cast (components[i], IOComponent);
				if( _direction == OStates.HORIZONTAL )
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

			if( _direction == OStates.HORIZONTAL )
			{
				for( i in 0...heights.length )
				{
					if( heights[i] > last )
						last = Std.int( heights[i] );
				}
				last = Std.int( last + padding * 2 );
			}

			return set__height( last );
		}
		else
		{
			return super.get_height( );
		}
	}

	override public function get_width( ):Float
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

			if( _direction == OStates.VERTICAL )
			{
				for( i in 0...widths.length )
				{
					if( widths[i] > last )
						last = Std.int( widths[i] );
				}
			}

			if( _direction == OStates.HORIZONTAL )
			{
				for( i in 0...widths.length )
				{
					var current = cast (components[i], IOComponent);
					last += current.width + (current.padding * 2);
//					last += Std.int(widths[i]);
				}
				last += (padding * widths.length + padding);
			}

			return set__width( last );

		}
		else
		{
			return super.get_width( );
		}
	}

	override public function draw( ):Void
	{
		var last:Float = padding;

		for( i in 0...components.length )
		{
			var current = cast (components[i], IOComponent);

			if( _direction == OStates.HORIZONTAL )
			{
				current.y = padding + current.padding;
				current.x = last;
				if( i == 0 )current.x += current.padding;
				last = current.x + current.width + padding + current.padding;
			}
			else if( _direction == OStates.VERTICAL )
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

	public function set_direction( value:String ):String
	{
		_direction = value;
		invalidate( );

		return _direction;
	}

	public function get_scrollRectEnabled( ):Bool
	{
		return _scrollRectEnabled;
	}

	public function set_scrollRectEnabled( b:Bool ):Bool
	{
		_scrollRectEnabled = b;
		if( ! _scrollRectEnabled ) sprite.scrollRect = null;
		return _scrollRectEnabled;
	}

	override public function get_styleId( ):String
	{
		return OLayoutStyle.styleString;
	}
}

class OLayoutStyle extends OBackgroundStyle
{

	public static var styleString:String = "LayoutStyle";
	public var defaultDirection:String;
	public var defaultScrollRect:Bool;

	public function new( )
	{
		super( );
		defaultDirection = OStates.VERTICAL;
		defaultScrollRect = false;
		styleID = styleString;
	}

	override public function initStyle( value:IOComponent ):Void
	{
		var styleAs = cast (value, OLayout);

		styleAs._direction = defaultDirection;
		styleAs._scrollRectEnabled = defaultScrollRect;

		super.initStyle( value );
	}

}


