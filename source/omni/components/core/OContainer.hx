package omni.components.core;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.style.OBackgroundStyle;

import nme.display.Sprite;
import nme.geom.Rectangle;

class OContainer extends OComponent
{

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

	override public function draw( ):Void
	{
		if( _scrollRectEnabled )
		{
			_scrollRect.width = width;
			_scrollRect.height = height;
			sprite.scrollRect = _scrollRect;
		}

		super.draw( );
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
		return OContainerStyle.styleString;
	}
}

class OContainerStyle extends OBackgroundStyle
{

	public static var styleString:String = "OContainer";
	public var defaultScrollRect:Bool;

	public function new( )
	{
		super( );
		defaultScrollRect = false;
		styleID = styleString;
	}

	override public function initStyle( value:IOComponent ):Void
	{
		var styleAs = cast (value, OContainer);

		styleAs._scrollRectEnabled = defaultScrollRect;

		super.initStyle( value );
	}

}
	
	
