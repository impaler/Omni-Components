package omni.components.core;

import omni.utils.ComponentUtils;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.core.OContainer.OContainerStyle;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.utils.OStates;

import nme.display.Sprite;
import nme.geom.Rectangle;

//todo cache values on add/remove

class OLayout extends OContainer
{

//***********************************************************
//                  Style Variables
//***********************************************************

	public var _verticalHAlign:String;
	public var _horizontalVAlign:String;
	public var _direction:String;

	public var direction(default, set_direction):String;

//***********************************************************
//                  Public Variables
//***********************************************************

	public var highestMember:Int;
	public var widestMember:Int;

	public var horizontalVAlign(get_horizontalVAlign, set_horizontalVAlign):String;

	public var verticalHAlign(get_verticalHAlign, set_verticalHAlign):String;

//***********************************************************
//                  Component Overrides
//***********************************************************

	override public function createMembers( ):Void
	{
		super.createMembers( );

		highestMember = 0;
		widestMember = 0;
		target = this.sprite;

		_horizontalVAlign = styleAsOLayoutStyle.defaultHorizontalVAlign;
		_verticalHAlign = styleAsOLayoutStyle.defaultVerticalHAlign;
		_direction = styleAsOLayoutStyle.defaultDirection;

	}

	override public function add( comp:IOComponent ):IOComponent
	{
		super.add( comp );

		comp.drawNow( );

		calculateHighest( );
		calculateWidest( );

		invalidate( false );

		return comp;
	}

	override public function addType( comp:Class<IOComponent>, ?style:IStyle = null ):Dynamic
	{
		var instance = super.addType( comp, style );
		
		var type = cast (instance, IOComponent);
		type.drawNow( );

		calculateHighest( );
		calculateWidest( );

		invalidate( false );

		return instance;
	}

	override public function draw( ):Void
	{
		var last:Float = padding;

		for( i in 0...members.length )
		{
			var current = cast (members[i], IOComponent);

			if( _direction == OStates.HORIZONTAL )
			{
				current.x = last;
				if( i == 0 )current.x += current.padding;
				last = current.x + current.width + padding + current.padding;

				if( _scrollRectEnabled )
				{
					if( _horizontalVAlign == OStates.MIDDLE )
					{
						if( highestMember < _height )
							current.y = ((_height * .5) - (current.height * .5));

					}
					else if( _horizontalVAlign == OStates.TOP )
					{
						current.y = 0;
					}
					else if( _horizontalVAlign == OStates.BOTTOM )
					{
						if( highestMember < _height )
							current.y = _height - current.height;
					}
				} 
				else 
				{
					current.y = 0;
				}
			}
			else if( _direction == OStates.VERTICAL )
			{
				current.y = last;
				if( i == 0 )current.y += current.padding;
				last = (current.y + current.height) + current.padding + padding;
//todo
				if( _scrollRectEnabled )
				{
					if( _verticalHAlign == OStates.LEFT )
					{
						current.x = 0;
					}
					else if( _verticalHAlign == OStates.MIDDLE )
					{
						//if( widestMember > _width )
							current.x = ((_width * .5) - (current.width * .5));
					}
					else if( _verticalHAlign == OStates.RIGHT )
					{
						//if( widestMember > _width )
							current.x = _width - current.width;
					}
				}
			}
		}

		super.draw( );
	}

//***********************************************************
//                  Component Methods
//***********************************************************

	public inline function calculateHighest( ):Int
	{
//todo avoid loop on add
		var heights = [];

		for( i in 0...members.length )
		{
			var current = cast (members[i], IOComponent);
			heights.push( current.height + current.padding * 2 );
		}

		var last = 0;

		for( i in 0...heights.length )
		{
			if( heights[i] > last )
				last = Std.int( heights[i] );
		}

		highestMember = last;

		return highestMember;
	}

	public inline function calculateWidest( ):Int
	{
		var widths = [];

		for( i in 0...members.length )
		{
			var current = cast (members[i], IOComponent);
			widths.push( current.width + (current.padding * 2) );
		}

		var last = 0;

		if( _direction == OStates.VERTICAL )
		{
			for( i in 0...widths.length )
			{
				if( widths[i] > last )
					last = Std.int( widths[i] );
			}
		}

		widestMember = last;

		return widestMember;
	}

	public function validateHorizontalVAlign( value:String ):Bool
	{
		var validAlignments:Array<String>;
		validAlignments = [OStates.TOP, OStates.MIDDLE, OStates.BOTTOM];
		if( Lambda.exists( validAlignments, function( alignment )
		{ return alignment == value; } ) )
		{
			return true;
		}
		else
		{
			ComponentUtils.throwAlignmentError( validAlignments, value );
			return false;
		}
	}

	public function validateVerticalHAlign( value:String ):Bool
	{
		var validAlignments:Array<String>;
		validAlignments = [OStates.LEFT, OStates.MIDDLE, OStates.RIGHT];
		if( Lambda.exists( validAlignments, function( alignment )
		{ return alignment == value; } ) )
		{
			return true;
		}
		else
		{
			ComponentUtils.throwAlignmentError( validAlignments, value );
			return false;
		}
	}

//***********************************************************
//                  Properties
//***********************************************************

	public function set_horizontalVAlign( value:String ):String
	{
		if( value != _horizontalVAlign && validateHorizontalVAlign( value ) )
		{
			_horizontalVAlign = value;
			invalidate( );
		}

		return _horizontalVAlign;
	}

	public function get_horizontalVAlign( ):String
	{
		return _horizontalVAlign;
	}

	public function set_verticalHAlign( value:String ):String
	{
		if( value != _verticalHAlign && validateVerticalHAlign( value ) )
		{
			_verticalHAlign = value;
			invalidate( );
		}

		return _verticalHAlign;
	}

	public function get_verticalHAlign( ):String
	{
		return _verticalHAlign;
	}

	override public function get_height( ):Float
	{
		if( ! _scrollRectEnabled )
		{
			var last = 0;

			for( i in 0...members.length )
			{
				var current = cast (members[i], IOComponent);

				if( _direction == OStates.HORIZONTAL )
				{
					last = highestMember;
				}
				else
				{
					var paddingValue = padding + current.padding;

					if( i == (members.length - 1) )
					{
						paddingValue += padding + current.padding;
					}

					last = Std.int( last + current.height + paddingValue );
				}
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

			if( _direction == OStates.VERTICAL )
			{
				last = widestMember;
			}
			
			if( _direction == OStates.HORIZONTAL )
			{
				for( i in 0...members.length )
				{
					var current = cast (members[i], IOComponent);
					last += current.width + (current.padding * 2);
				}
				last += (padding * members.length + padding);
			}

			return set__width( last );
		}
		else
		{
			return super.get_width( );
		}
	}

	public function set_direction( value:String ):String
	{
		_direction = value;
		invalidate( );

		return _direction;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	private var styleAsOLayoutStyle(get_styleAsOLayoutStyle, null):OLayoutStyle;

	private function get_styleAsOLayoutStyle( ):OLayoutStyle
	{
		return cast(_style, OLayoutStyle);
	}

	override public function get_styleId( ):String
	{
		return OLayoutStyle.styleString;
	}
}

class OLayoutStyle extends OContainerStyle
{
	public static var styleString:String = "OLayoutStyle";

	public var defaultDirection:String;
	public var defaultHorizontalVAlign:String;
	public var defaultVerticalHAlign:String;

	public function new( )
	{
		super( );
		styleID = styleString;
	}

}


