package omni.components.gui.layout;

import omni.components.gui.controls.ScrollBar;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.signals.OCoreEvent;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.OCore;
import omni.components.gui.controls.ScrollSlider;
import omni.components.core.OLayout;
import omni.utils.Tween;
import omni.utils.ComponentUtils;

import nme.display.DisplayObject;
import nme.display.DisplayObjectContainer;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.events.Event;
import nme.geom.Point;
import nme.geom.Rectangle;

class ScrollContainer extends OLayout
{
	private var h_scrollBar_enabled:Bool = true;
	private var v_scrollBar_enabled:Bool = true;

	public var hScrollBar:ScrollBar;
	public var vScrollBar:ScrollBar;

//	private var h_scrollBar:ScrollSlider;
//	private var v_scrollBar:ScrollSlider;

	public var contentComponent:IOComponent;

	private var _rect:Rectangle;

	private var _scrollStep:Int;
	private var _scrollButtonSize:Int;
	private var _xOffset:Float = 0;
	private var _yOffset:Float = 0;
	private var _scrollY:Float = 0;
	private var _scrollX:Float = 0;
	private var _down:Bool = false;
	private var _yPos:Float;
	private var _xPos:Float;
	private var _xCache:Float = 0;
	private var _yCache:Float = 0;
	private var _xSpeed:Float = 0;
	private var _ySpeed:Float = 0;
	private var _tweenBackSpeed:Int = 0;
	private var _speedLimit:Float = 0;
	private var _ratio:Float = 0;
	private var _decel:Float = 0;
	private var _drag:Bool = false;
	private var _draggingInit:Bool = false;
	private var _isLayout:Bool = false;
	private var _scrollBarMove:Bool = false;
	private var _removeAnimateYBackAnimating:Bool = false;
	private var _removeAnimateXBackAnimating:Bool = false;
	private var _xTouchOffset:Float = 0;
	private var _yTouchOffset:Float = 0;
	private var _tweenX:Bool = true;
	private var _tweenY:Bool = true;

	private var mouseTargetDown:OSignalMouse;
	private var mouseUp:OSignalMouse;
	private var mouseWheel:OSignalMouse;
	private var dragEnterFrame:OCoreEvent;

	public var tweenEnabled:Bool;

	public function setMouseChildrenOnContent( ):Void
	{
//todo use overlay blocking sprite for html5 doesnt support mouseChildren
	}

	override public function createMembers( ):Void
	{
		super.createMembers( );

//todo move all properties to style system 
//todo tween needs a refactor for initial press tolerance and better behaviour
		_scrollButtonSize = 10;
		_scrollStep = 20;
		_tweenBackSpeed = 4;
		_speedLimit = 1;
		_ratio = .8;
//		_ratio = .8;
		_decel = .96;
//		_decel = .92;

		_rect = new Rectangle(0, 0, 0, 0);

		target = new Sprite();
		target.scrollRect = _rect;
		sprite.addChild( target );

		var thisStyle = cast(_style, ScrollContainerStyle);

//		h_scrollBar = new ScrollBar( thisStyle.hScrollStyle );
		hScrollBar = new ScrollBar();
//		h_scrollBar = hScrollBar.scrollSlider;
		hScrollBar.type = OLayout.HORIZONTALLY;
//todo in style
		hScrollBar.sliderStep = _scrollStep;

//		v_scrollBar = new ScrollSlider( thisStyle.vScrollStyle );
		vScrollBar = new ScrollBar();
//		v_scrollBar = vScrollBar.scrollSlider;
		vScrollBar.type = OLayout.VERTICALLY;
		vScrollBar.sliderStep = _scrollStep;

		mouseUp = new OSignalMouse(OSignalMouse.UP, nme.Lib.stage);

	}

	override public function enableSignals( ):Void
	{
		hScrollBar.onChange.add( handleHScrollBarMove );
		vScrollBar.onChange.add( handleVScrollBarMove );

//todo
		hScrollBar.scrollSlider.button.mouseDown.add( handleHScrollBarDown );
		vScrollBar.scrollSlider.button.mouseDown.add( handleVScrollBarDown );

		mouseUp.add( handleRelease );

		enableTween( );

//todo release outside of stage for desktop?
	}

	override public function disableSignals( ):Void
	{
		hScrollBar.onChange.remove( handleHScrollBarMove );
		vScrollBar.onChange.remove( handleVScrollBarMove );

		mouseUp.remove( handleRelease );

//todo slider buttons

//		disableTween();
	}

	override public function invalidate( recursive:Bool = true ):Void
	{
		updateScrollBars( );
		super.invalidate( recursive );
	}

	override public function draw( ):Void
	{
		coreDraw( );
	}

	public function disableChildComponentEvents( ):Void
	{

		if( _isLayout )
		{
			for( o in contentComponent.components )
			{
//todo check for save non core events that might have been added
//				o.disableSignals( );
			}
		}

	}

	public function enableChildComponentEvents( ):Void
	{

		if( _isLayout )
		{
			for( o in contentComponent.components )
			{
//				o.enableSignals( );
			}
		}

	}

	public function enableTween( ):Void
	{
		tweenEnabled = true;
		dragEnterFrame = new OCoreEvent(Event.ENTER_FRAME, nme.Lib.stage );
		dragEnterFrame.add( handleRenderDrag );
	}

	public function disableTween( ):Void
	{
		tweenEnabled = false;
		dragEnterFrame.destroy( );
	}

	public var currentLayout:OLayout;

	public function addToLayout( comp:IOComponent ):Void
	{
		if( currentLayout == null ) addVBoxLayout( );
		currentLayout.add( comp );
	}

	public function addVBoxLayout( ?style:IStyle ):VBox
	{
		if( currentLayout != null )
		{
			remove( currentLayout );
			currentLayout.destroy( );
		}

		currentLayout = new VBox(style);
		add( currentLayout );
		return cast (currentLayout, VBox);
	}

	public function addHBoxLayout( ?style:IStyle ):HBox
	{
		if( currentLayout != null )
		{
			remove( currentLayout );
			currentLayout.destroy( );
		}

		currentLayout = new HBox(style);
		add( currentLayout );
		return cast (currentLayout, HBox);
	}

//think about limiting this to on layout ????

	override public function add( comp:IOComponent ):Void
	{
		_isLayout = true;

		contentComponent = comp;

		target.addChild( comp.sprite );
		this.components.push( comp );

		if( mouseTargetDown != null ) mouseTargetDown.removeAll( );
		mouseTargetDown = new OSignalMouse (OSignalMouse.DOWN, comp.sprite);
		mouseTargetDown.add( handleDownContent );

		if( mouseWheel != null ) mouseWheel.removeAll( );
		mouseWheel = new OSignalMouse (OSignalMouse.WHEEL, comp.sprite);
		mouseWheel.add( handleMouseWheel );

		invalidate( );
	}

//***********************************************************
//                  Event Handlers
//***********************************************************

	public function handleMouseWheel( ?e:OSignalMouse ):Void
	{
		target.mouseChildren = true;
		_scrollBarMove = true;
//		if(_type == Layout.HORIZONTALLY)
//		{
//			//todo
//		}
//		else
//		{
//			 
//		}

		vScrollBar.value -= e.delta > 0 ? vScrollBar.sliderStep : - vScrollBar.sliderStep;

		if( OCore.instance.updateAfterEvent )
			e.updateAfterEvent( );
	}

	private function handleDownContent( e:OSignalMouse ):Void
	{
		nme.Lib.trace( "down" );
		_down = true;
		_drag = false;
		_xSpeed = 0;
		_xSpeed = 0;
		removeanimateXBack( );
		removeanimateYBack( );
		_xOffset = e.event.stageX - contentComponent.x;
		_yOffset = e.event.stageY - contentComponent.y;
		_xTouchOffset = nme.Lib.stage.mouseX;
		_yTouchOffset = nme.Lib.stage.mouseY;
		_drag = true;
	}

	private function handleRelease( e:OSignalMouse ):Void
	{
//		enableChildComponentEvents();

		target.mouseChildren = true;
		_draggingInit = false;
		_drag = false;

		if( tweenEnabled )
		{
			if( _down )
			{
				if( _tweenX )
					_xSpeed = (contentComponent.x - _xCache) * _ratio;

				if( _tweenY )
					_ySpeed = (contentComponent.y - _yCache) * _ratio;
			}
			_down = false;

			if( _scrollBarMove )
			{
				_xSpeed = 0;
				_ySpeed = 0;
			}
			_scrollBarMove = false;
		}
	}

	private function handleRenderDrag( e:OCoreEvent ):Void
	{
		if( ! _scrollBarMove )
		{
			removeanimateYBack( );
			removeanimateXBack( );

			if( ! _drag )
			{
				limitSpeed( );

				if( _tweenX )
					contentComponent.x += (_xSpeed *= _decel);
				if( _tweenY )
					contentComponent.y += (_ySpeed *= _decel);

//				nme.Lib.trace (Math.round(_xSpeed));
//				nme.Lib.trace (Math.round(_ySpeed));
				if( ! isTweening( ) )
				{
					checkYPosition( );
					checkXPosition( );
				}
			}
			else
			{
				_xCache = contentComponent.x;
				_yCache = contentComponent.y;

				var touchTolerance = 6;

				if( _draggingInit == true || isTweening( ) )
				{
					if( _tweenX )
						contentComponent.x = nme.Lib.stage.mouseX - _xOffset;
					if( _tweenY )
						contentComponent.y = nme.Lib.stage.mouseY - _yOffset;

				}
				else
//				if( _ySpeed < 2 && _ySpeed < 2 )
				{
					if(
					_xTouchOffset - nme.Lib.stage.mouseX > touchTolerance
					|| _xTouchOffset - nme.Lib.stage.mouseX < - touchTolerance
					|| _yTouchOffset - nme.Lib.stage.mouseY > touchTolerance
					|| _yTouchOffset - nme.Lib.stage.mouseY < - touchTolerance )
					{
						_draggingInit = true;
						target.mouseChildren = false;
//					disableChildComponentEvents( );
					}

				}
//				else
//				{
//					_draggingInit = true;
//					target.mouseChildren = false;
////					disableChildComponentEvents( );
//				}

			}

//			nme.Lib.trace(_ySpeed + " - " +_ySpeed);
//			nme.Lib.trace(Std.int(Math.abs(_ySpeed*1000)) + " - " + Std.int(Math.abs(_ySpeed*1000)));

			updateScrollBarsFromChange( );
		}
	}

	public function handleHScrollBarDown( e:OSignalMouse ):Void
	{
		_scrollBarMove = true;
		target.mouseChildren = false;
//		disableChildComponentEvents( );
	}

	public function handleVScrollBarDown( e:OSignalMouse ):Void
	{
		_scrollBarMove = true;
		target.mouseChildren = false;
//		disableChildComponentEvents( );
	}

	private function handleVScrollBarMove( e:Dynamic = null ):Void
	{
		_scrollBarMove = true;

		if( v_scrollBar_enabled )
		{
			contentComponent.y = - vScrollBar.value;
		}

		checkXPosition( false );
		removeanimateYBack( );
	}

	private function handleHScrollBarMove( e:Dynamic = null ):Void
	{
		_scrollBarMove = true;

		if( h_scrollBar_enabled )
		{
			contentComponent.x = - hScrollBar.value;
		}

		checkYPosition( false );
		removeanimateXBack( );
	}

	public function handleDragNoTween( e:OSignalMouse ):Void
	{

		if( v_scrollBar_enabled )
		{
			contentComponent.y = e.event.stageY - _yOffset;
			_scrollY = - contentComponent.y;

//todo shouldnt need this as _value clamp should take care in scrollbar???
			if( _scrollY < 0 ) _scrollY = 0;

			vScrollBar._value = Std.int( _scrollY );
//todo
			vScrollBar.scrollSlider.refreshButton( );
		}

		if( h_scrollBar_enabled )
		{
			contentComponent.x = e.event.stageX - _xOffset;
			_scrollX = - contentComponent.x;
			if( _scrollX < 0 ) _scrollX = 0;

			hScrollBar._value = Std.int( _scrollX );
//todo
			hScrollBar.scrollSlider.refreshButton( );
		}

		checkXPosition( false );
		checkYPosition( false );

		if( OCore.instance.updateAfterEvent )
			e.updateAfterEvent( );
	}

//***********************************************************
//                  Component Methods
//***********************************************************

	private inline function limitSpeed( ):Void
	{
		_speedLimit = 4;

//if the content is out of bounds limit it's speed
		if( ! isValidY( ) )
		{
			if( _ySpeed > _speedLimit ) _ySpeed = _speedLimit;
			if( _ySpeed < - _speedLimit ) _ySpeed = - _speedLimit;
		}

		if( ! isValidX( ) )
		{
			if( _xSpeed > _speedLimit ) _xSpeed = _speedLimit;
			if( _xSpeed < - _speedLimit ) _xSpeed = - _speedLimit;
		}
	}

	private function isTweening( ):Bool
	{
		var limit = 10;
		if( Math.round( _ySpeed ) < limit || Math.round( _xSpeed ) < limit )
		{
			return false;
		}
		else
		{
			return true;
		}
	}

	public function animateToxPos( ):Void
	{
		if( ! _removeAnimateXBackAnimating && _tweenX )
		{
			_removeAnimateXBackAnimating = true;
			nme.Lib.stage.addEventListener( Event.ENTER_FRAME, animateXBack );
		}
	}

	public function animateXBack( e:Event ):Void
	{
		contentComponent.x += (_xPos - contentComponent.x) / _tweenBackSpeed;

		if( contentComponent.x == _xPos )
		{
			removeanimateXBack( );
		}
	}

	public function removeanimateXBack( ):Void
	{
		if( _removeAnimateXBackAnimating )
		{
			nme.Lib.stage.removeEventListener( Event.ENTER_FRAME, animateXBack );
			_removeAnimateXBackAnimating = false;
		}
	}

	public function animateToYPos( ):Void
	{
		if( ! _removeAnimateYBackAnimating && _tweenY )
		{
			_removeAnimateYBackAnimating = true;
			nme.Lib.stage.addEventListener( Event.ENTER_FRAME, animateYBack );
		}
	}

	public function animateYBack( e:Event ):Void
	{
		contentComponent.y += (_yPos - contentComponent.y) / _tweenBackSpeed;

		if( contentComponent.y == _yPos )
		{
			removeanimateYBack( );
		}
	}

	public function removeanimateYBack( ):Void
	{
		if( _removeAnimateYBackAnimating )
		{
			_removeAnimateYBackAnimating = false;
			nme.Lib.stage.removeEventListener( Event.ENTER_FRAME, animateYBack );
		}
	}

	public function updateScrollBarsFromChange( ):Void
	{
		if( v_scrollBar_enabled )
		{
			_scrollY = - contentComponent.y;
//todo shouldnt need this as _value clamp should take care in scrollbar???
			if( _scrollY < 0 ) _scrollY = 0;

			vScrollBar._value = Std.int( _scrollY );
//todo
			vScrollBar.refreshButton( );
		}

		if( h_scrollBar_enabled )
		{
			_scrollX = - contentComponent.x;
			if( _scrollX < 0 ) _scrollX = 0;

			hScrollBar._value = Std.int( _scrollX );
//todo null
			hScrollBar.refreshButton( );
		}
	}

	public function checkYPosition( animate:Bool = true ):Void
	{
		var isValid = isValidY( );

		if( ! isValid )
		{
			animate ? animateToYPos( ) : contentComponent.y = _yPos;
		}
	}

	private inline function isValidY( ):Bool
	{
		var isValid = true;
		if( contentComponent.y > 0 )
		{
			_yPos = 0;
			isValid = false;
		}

		var ylimit = - (contentComponent.height - _rect.height);

		if( contentComponent.y < ylimit )
		{
			isValid = false;
			vScrollBar.barNeeded ? _yPos = ylimit : _yPos = 0;
		}

		return isValid;
	}

	public function checkXPosition( animate:Bool = true ):Void
	{
		var isValid = isValidX( );

		if( ! isValid )
		{
			animate ? animateToxPos( ) : contentComponent.x = _xPos;
		}
	}

	private function isValidX( ):Bool
	{
		var isValid = true;
		if( contentComponent.x > 0 )
		{
			_xPos = 0;
			isValid = false;
		}

		var xlimit = - (contentComponent.width - _rect.width);

		if( contentComponent.x < xlimit )
		{
			isValid = false;
			hScrollBar.barNeeded ? _xPos = xlimit : _xPos = 0;
		}
		return isValid;
	}

	override public function set_direction( value:Int ):Int
	{
		_direction = value;

		if( _direction == OLayout.VERTICALLY )
		{
			h_scrollBar_enabled = false;
			v_scrollBar_enabled = true;
		}
		else if( _direction == OLayout.HORIZONTALLY )
		{
			h_scrollBar_enabled = true;
			v_scrollBar_enabled = false;
		}

		invalidate( );

		return _direction;
	}

	public function updateScrollBars( ):Void
	{
		hScrollBar.move( 0, _height - _scrollButtonSize );
		vScrollBar.move( _width - _scrollButtonSize, 0 );

		updateContentSize( );

		if( h_scrollBar_enabled )
		{
			if( v_scrollBar_enabled )
			{
				_rect.width = _width - _scrollButtonSize;
				hScrollBar.pageSize = Std.int( _rect.width );
				_rect.height = _height - _scrollButtonSize;
				vScrollBar.pageSize = Std.int( _rect.height );

				hScrollBar._size( _width - _scrollButtonSize, _scrollButtonSize );
				vScrollBar._size( _scrollButtonSize, _height - _scrollButtonSize );

				if( ! vScrollBar.barNeeded )
				{
					if( vScrollBar.sprite.parent != null ) sprite.removeChild( vScrollBar.sprite );
					_rect.width = _width;
					hScrollBar.pageSize = Std.int( _rect.width );
					hScrollBar._size( _width, _scrollButtonSize );
				}
				else
				{
					if( vScrollBar.sprite.parent == null ) sprite.addChild( vScrollBar.sprite );
				}

				if( ! hScrollBar.barNeeded )
				{
					if( hScrollBar.sprite.parent != null ) sprite.removeChild( hScrollBar.sprite );
					_rect.height = _height;
					vScrollBar.pageSize = Std.int( _rect.height );
					vScrollBar._size( _scrollButtonSize, _height );
				}
				else
				{
					if( hScrollBar.sprite.parent == null ) sprite.addChild( hScrollBar.sprite );
				}
			}
			else
			{
				_rect.width = _width;
				hScrollBar.pageSize = Std.int( _rect.width );
				_rect.height = _height - _scrollButtonSize;
				vScrollBar.pageSize = Std.int( _rect.height );
				hScrollBar._size( _width, _scrollButtonSize );

				vScrollBar._size( 0, 0 );

				if( vScrollBar.sprite.parent != null ) sprite.removeChild( vScrollBar.sprite );

				if( ! hScrollBar.barNeeded )
				{
					if( hScrollBar.sprite.parent != null ) sprite.removeChild( hScrollBar.sprite );
					_rect.height = _height;
					vScrollBar.pageSize = Std.int( _rect.height );
				}
				else
				{
					if( hScrollBar.sprite.parent == null ) sprite.addChild( hScrollBar.sprite );
				}
			}
		}
		else
		{
			if( v_scrollBar_enabled )
			{
				_rect.width = _width - _scrollButtonSize;
				hScrollBar.pageSize = Std.int( _rect.width );
				_rect.height = _height;
				vScrollBar.pageSize = Std.int( _rect.height );

				hScrollBar._size( 0, 0 );
				vScrollBar._size( _scrollButtonSize, _height );

				if( ! vScrollBar.barNeeded )
				{
					if( vScrollBar.sprite.parent != null ) sprite.removeChild( vScrollBar.sprite );
					_rect.width = _width;
					hScrollBar.pageSize = Std.int( _rect.width );
				}
				else
				{
					if( vScrollBar.sprite.parent == null ) sprite.addChild( vScrollBar.sprite );
				}
			}
			else
			{
				_rect.width = _width;
				hScrollBar.pageSize = Std.int( _rect.width );
				_rect.height = _height;
				vScrollBar.pageSize = Std.int( _rect.height );

				hScrollBar._size( 0, 0 );
				vScrollBar._size( 0, 0 );

				if( ! vScrollBar.barNeeded )
				{
					if( vScrollBar.sprite.parent != null ) sprite.removeChild( vScrollBar.sprite );
				}
				else
				{
					if( vScrollBar.sprite.parent == null ) sprite.addChild( vScrollBar.sprite );
				}
			}

			if( hScrollBar.sprite.parent != null ) sprite.removeChild( hScrollBar.sprite );
		}

		target.scrollRect = _rect;
	}

	public function updateContentSize( ):Void
	{
		if( contentComponent != null )
		{
			var height = Std.int( contentComponent.height );
			var width = Std.int( contentComponent.width );

			hScrollBar.contentSize = width;
			vScrollBar.contentSize = height;
		}
	}

	override public function get_height( ):Float
	{
		return _height;
	}

	override public function get_width( ):Float
	{
		return _width;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return ScrollContainerStyle.styleString;
	}
}

class ScrollContainerStyle extends OLayoutStyle
{

	public static var styleString:String = "ScrollContainerStyle";

	public var hScrollStyle:ScrollSliderStyle;
	public var vScrollStyle:ScrollSliderStyle;

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}


