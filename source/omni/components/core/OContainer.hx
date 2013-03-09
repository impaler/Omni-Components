package omni.components.core;

import omni.components.style.base.OBaseBackgroundStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.utils.OStates;

import nme.display.Sprite;
import nme.geom.Rectangle;

class OContainer extends OComponent
{

//***********************************************************
//                  Public Variables
//***********************************************************

	public var scrollRectEnabled(get_scrollRectEnabled, set_scrollRectEnabled):Bool;

	public var _scrollRect:Rectangle;
	public var target:Sprite;
	
//***********************************************************
//                  Style Variables
//***********************************************************

	public var _scrollRectEnabled:Bool;

//***********************************************************
//                  Component Overrides
//***********************************************************

	override public function createMembers( ):Void
	{
		super.createMembers( );

        var styleAs = cast(_style, OContainerStyle);
        _scrollRectEnabled  = styleAs.defaultScrollRect;

		_scrollRect = new Rectangle(0, 0, _width, _height);
		target = sprite;
	}

    //todo listen for child resize events with a toggle
	override public function add( comp:IOComponent ):IOComponent
	{
		super.add( comp );

		comp.drawNow( );
		invalidate( );

		return comp;
	}

	override public function draw( ):Void
	{
		if( scrollRectEnabled )
		{
			_scrollRect.width = width;
			_scrollRect.height = height;
			
			target.scrollRect = _scrollRect;
		} else {
			target.scrollRect = null;
        }

		super.draw( );
	}

//***********************************************************
//                  Properties
//***********************************************************

	public function get_scrollRectEnabled( ):Bool
	{
		return _scrollRectEnabled;
	}

	public function set_scrollRectEnabled( b:Bool ):Bool
	{
		_scrollRectEnabled = b;
		if( ! _scrollRectEnabled ) target.scrollRect = null;
		return _scrollRectEnabled;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return OContainerStyle.styleString;
	}
}

class OContainerStyle extends OBaseBackgroundStyle
{
	public static var styleString:String = "OContainer";

	public var defaultScrollRect:Bool = false;

	public function new( )
	{
		super( );
        styleID = styleString;
	}

}
	
	
