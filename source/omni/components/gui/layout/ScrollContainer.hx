package omni.components.gui.layout;

import omni.components.core.OStates;
import omni.components.style.OBaseStyle;
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

	public var currentLayout:OLayout;

	public var contentComponent:IOComponent;

	private var _xSpeed:Float = 0;
	private var _ySpeed:Float = 0;
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
	private var _mouseWheelV:Bool = true;
	private var _isValidTemp:Bool;
	private var tempFloat:Float;
	private var tweenEnabled:Bool;

	public var mouseTargetDown:OSignalMouse;
	public var mouseUp:OSignalMouse;
	public var mouseWheel:OSignalMouse;
	public var dragEnterFrame:OCoreEvent;

	public var hAlign:String;
	public var vAlign:String;

//***********************************************************
//                  Component Core
//***********************************************************

	override public function createMembers( ):Void
	{
		super.createMembers( );

//todo move all properties to style system 
//todo tween needs a refactor for initial press tolerance and better behaviour
		_scrollButtonSize = 10;
		_scrollStep = 20;
		_tweenBackSpeed = 2;
		_speedLimit = 1;
		_ratio = .8;
//		_ratio = .8;
		_decel = .96;
//		_decel = .92;
		_mouseWheelV = true;

		_rect = new Rectangle(0, 0, 0, 0);

		target = new Sprite();
		target.scrollRect = _rect;
		sprite.addChild( target );

		var thisStyle = cast(_style, ScrollContainerStyle);

		hScrollBar = new ScrollBar(thisStyle.hScrollStyle);
		hScrollBar.type = OStates.HORIZONTAL;
		hScrollBar.sliderStep = _scrollStep;

		vScrollBar = new ScrollBar(thisStyle.vScrollStyle);
		vScrollBar.type = OStates.VERTICAL;
		vScrollBar.sliderStep = _scrollStep;

		mouseUp = new OSignalMouse(OSignalMouse.UP, nme.Lib.stage);
	}

	override public function enableSignals( ):Void
	{
		hScrollBar.onChange.add( handleHScrollBarMove );
		vScrollBar.onChange.add( handleVScrollBarMove );

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
	}

	override public function invalidate( recursive:Bool = true ):Void
	{
		super.invalidate( recursive );

		updateScrollBars( );

		hScrollBar.drawNow( );
		vScrollBar.drawNow( );
	}

	override public function draw( ):Void
	{
		coreDraw( );
	}

//***********************************************************
//                  Component Methods
//***********************************************************

	override public function add( comp:IOComponent ):IOComponent
	{
		_isLayout = true;

		contentComponent = comp;

		target.buttonMode = true;
		target.addChild( comp.sprite );
		this.components.push( comp );

		if( mouseTargetDown != null ) mouseTargetDown.removeAll( );
		mouseTargetDown = new OSignalMouse (OSignalMouse.DOWN, comp.sprite);
		mouseTargetDown.add( handleDownContent );

		if( mouseWheel != null ) mouseWheel.removeAll( );
		mouseWheel = new OSignalMouse (OSignalMouse.WHEEL, comp.sprite);
		mouseWheel.add( handleMouseWheel );

		invalidate( );

		return comp;
	}

	public function setMouseChildrenOnContent( ):Void
	{
//todo use overlay blocking sprite for html5 doesnt support mouseChildren
	}

	public function disableChildComponentEvents( ):Void
	{
		if( _isLayout )
		{
			for( o in contentComponent.components )
			{
//todo check for save non core events that might have been added
//				o.disableSignals( );
				o.setActiveState( );
			}
		}
	}

	public function enableChildComponentEvents( ):Void
	{
		if( _isLayout )
		{
			for( o in contentComponent.components )
			{
//todo
//o.enableSignals( );
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

//***********************************************************
//                  Event Handlers
//***********************************************************

	public function handleMouseWheel( ?e:OSignalMouse ):Void
	{
		target.mouseChildren = true;

		_scrollBarMove = true;

		if( _mouseWheelV )
		{
			vScrollBar.value -= e.delta > 0 ? vScrollBar.sliderStep : - vScrollBar.sliderStep;
		}
		else
		{
			hScrollBar.value -= e.delta > 0 ? hScrollBar.sliderStep : - hScrollBar.sliderStep;
		}

		if( OCore.instance.updateAfterEvent )
			e.updateAfterEvent( );
	}

	private function handleDownContent( e:OSignalMouse ):Void
	{
		if( ! OCore.instance.disableScrolling )
		{
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
		else
		{
			resetPosition( );
		}
	}

	private function handleRelease( e:OSignalMouse ):Void
	{
		if( OCore.instance.disableScrolling )
		{
			resetPosition( );
		}
		else
		{
			enableChildComponentEvents( );

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
	}

	private function handleRenderDrag( e:OCoreEvent ):Void
	{
		if( ! OCore.instance.disableScrolling )
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

					if( ! isTweening( ) )
					{
						checkYPosition( );
						checkXPosition( );
					}

					roundSpeed( );
				}
				else if( ! OCore.instance.disableScrolling )
				{
					_xCache = contentComponent.x;
					_yCache = contentComponent.y;

					var touchTolerance = 10;

					if( _draggingInit == true || isTweening( ) )
					{
						if( h_scrollBar_enabled && _tweenX )
							contentComponent.x = nme.Lib.stage.mouseX - _xOffset;

						if( v_scrollBar_enabled && _tweenY )
							contentComponent.y = nme.Lib.stage.mouseY - _yOffset;

					}
					else if( Std.int( _ySpeed * 10 ) == 0 && Std.int( _xSpeed * 10 ) == 0 )
					{
						if(
						_xTouchOffset - nme.Lib.stage.mouseX > touchTolerance
						|| _xTouchOffset - nme.Lib.stage.mouseX < - touchTolerance
						|| _yTouchOffset - nme.Lib.stage.mouseY > touchTolerance
						|| _yTouchOffset - nme.Lib.stage.mouseY < - touchTolerance
						)
						{
							_draggingInit = true;
							target.mouseChildren = false;
							disableChildComponentEvents( );
						}
					}
					else
					{
						_draggingInit = true;
						target.mouseChildren = false;
					}
				}

				updateScrollBarsFromChange( );
			}
		}
		else
		{
			resetPosition( );
		}
	}

	public function handleHScrollBarDown( e:OSignalMouse ):Void
	{
		_scrollBarMove = true;
		target.mouseChildren = false;
		disableChildComponentEvents( );
	}

	public function handleVScrollBarDown( e:OSignalMouse ):Void
	{
		_scrollBarMove = true;
		target.mouseChildren = false;
		disableChildComponentEvents( );
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
		if( ! OCore.instance.disableScrolling )
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
	}

//***********************************************************
//                  Component Methods
//***********************************************************

	public inline function resetPosition( ):Void
	{
		_xSpeed = 0;
		_ySpeed = 0;
		removeanimateXBack( );
		removeanimateYBack( );
		checkXPosition( false );
		checkYPosition( false );
	}

	private inline function limitSpeed( ):Void
	{
		_speedLimit = 10;

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

	public inline function roundSpeed( ):Void
	{
		if( Std.int( _xSpeed * 10 ) == 0 )
		{
			_xSpeed = 0;
		}

		if( Std.int( _ySpeed * 10 ) == 0 )
		{
			_ySpeed = 0;
		}

	}

	private inline function isTweening( ):Bool
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

	private inline function tween( currentValue:Float, targetValue:Float, tweenValue:Float = 0.4 ):Float
	{
		if( currentValue != targetValue )
		{
			tempFloat = targetValue - currentValue;
			currentValue += tempFloat * tweenValue;
			tempFloat = tempFloat < 0 ? - tempFloat : tempFloat;
			if( tempFloat < 1 )
			{
				currentValue = targetValue;
			}
			return currentValue;
		}
		else
		{
			return currentValue;
		}
	}

	public inline function animateToxPos( ):Void
	{
		if( ! _removeAnimateXBackAnimating && _tweenX )
		{
			_removeAnimateXBackAnimating = true;
			nme.Lib.stage.addEventListener( Event.ENTER_FRAME, animateXBack );
		}
	}

	public inline function animateXBack( e:Event ):Void
	{
		contentComponent.x = tween( contentComponent.x, _xPos );
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

	public inline function animateToYPos( ):Void
	{
		if( ! _removeAnimateYBackAnimating && _tweenY )
		{
			_removeAnimateYBackAnimating = true;
			nme.Lib.stage.addEventListener( Event.ENTER_FRAME, animateYBack );
		}
	}

	public inline function animateYBack( e:Event ):Void
	{
		contentComponent.y = tween( contentComponent.y, _yPos );
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

	public inline function updateScrollBarsFromChange( ):Void
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

	public inline function checkYPosition( animate:Bool = true ):Void
	{
		var isValid = isValidY( );

		if( ! isValid )
		{
			animate ? animateToYPos( ) : contentComponent.y = _yPos;
		}
	}

	private inline function isValidY( ):Bool
	{
		_isValidTemp = true;

		if( contentComponent.y > 0 )
		{
			_yPos = 0;
			_isValidTemp = false;
		}

		tempFloat = - (contentComponent.height - _rect.height);

		if( contentComponent.y < tempFloat )
		{
			_isValidTemp = false;
			vScrollBar.barNeeded ? _yPos = tempFloat : _yPos = 0;
		}

		return _isValidTemp;
	}

	public inline function checkXPosition( animate:Bool = true ):Void
	{
		_isValidTemp = isValidX( );

		if( ! _isValidTemp )
		{
			animate ? animateToxPos( ) : contentComponent.x = _xPos;
		}
	}

	private function isValidX( ):Bool
	{
		_isValidTemp = true;
		if( contentComponent.x > 0 )
		{
			_xPos = 0;
			_isValidTemp = false;
		}

		tempFloat = - (contentComponent.width - _rect.width);

		if( contentComponent.x < tempFloat )
		{
			_isValidTemp = false;
			hScrollBar.barNeeded ? _xPos = tempFloat : _xPos = 0;
//            todo align center???			
//            hScrollBar.barNeeded ? _xPos = tempFloat : _xPos =  _width*.5 - contentComponent._width*.5;

		}
		return _isValidTemp;
	}

	override public function set_direction( value:String ):String
	{
		_direction = value;

		if( _direction == OStates.VERTICAL )
		{
			h_scrollBar_enabled = false;
			v_scrollBar_enabled = true;
		}
		else if( _direction == OStates.HORIZONTAL )
		{
			h_scrollBar_enabled = true;
			v_scrollBar_enabled = false;
		}

		invalidate( );

		return _direction;
	}

	public inline function updateScrollBars( ):Void
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

	public inline function updateContentSize( ):Void
	{
		if( contentComponent != null )
		{
			hScrollBar.contentSize = Std.int( contentComponent.width );
			vScrollBar.contentSize = Std.int( contentComponent.height );
		}
	}

//***********************************************************
//                  Properties
//***********************************************************

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

	public var hScrollStyle:ScrollBarStyle;
	public var vScrollStyle:ScrollBarStyle;

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}


