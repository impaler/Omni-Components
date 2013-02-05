package omni.components.gui.layout;

import omni.components.core.signals.OCoreEvent;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.OCore;
import omni.components.gui.controls.ScrollBar;
import omni.components.gui.layout.Layout;
import omni.components.utils.Tween;
import omni.components.utils.ComponentUtils;

import nme.display.DisplayObject;
import nme.display.DisplayObjectContainer;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.events.Event;
import nme.geom.Point;
import nme.geom.Rectangle;

class ScrollContainer extends Layout
{
	private var h_scrollBar_enabled:Bool = true;
	private var v_scrollBar_enabled:Bool = true;

	private var h_scrollBar:ScrollBar;
	private var v_scrollBar:ScrollBar;
	public var contentComponent:IOComponent;

	private var _rect:Rectangle;

	private var scrollStep:Int;
	private var scrollButtonSize:Int;
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
	private var _isLayout:Bool = false;
	private var _scrollbarMove:Bool = false;
	public var _removeanimateYBackAnimating:Bool = false;
	public var _removeanimateXBackAnimating:Bool = false;

	private var mouseTargetDown:OSignalMouse;
	private var mouseUp:OSignalMouse;
	private var mouseWheel:OSignalMouse;
	private var mouseMove:OSignalMouse;
	private var dragEnterFrame:OCoreEvent;

	public var tweenX:Bool = true;
	public var tweenY:Bool = true;
	public var tweenEnabled:Bool;
	private var _xTouchOffset:Float = 0;
	private var _yTouchOffset:Float = 0;

	override public function createMembers():Void
	{
		super.createMembers();

		//todo move all properties to style system 
		//todo tween needs a refactor for initial press tolerance and better behaviour
		scrollButtonSize = 10;
		scrollStep = 20;
		_tweenBackSpeed = 8;
		_speedLimit = 1;
		_ratio = .5;
		_decel = .9;

		_rect = new Rectangle(0, 0, 0, 0);

		target = new Sprite();
		target.scrollRect = _rect;
		sprite.addChild(target);

		var thisStyle = cast(_style, ScrollContainerStyle);

		h_scrollBar = new ScrollBar( thisStyle.hScrollStyle );
		h_scrollBar.type = Layout.HORIZONTALLY;
		//todo in style
		h_scrollBar.step = scrollStep;

		v_scrollBar = new ScrollBar( thisStyle.vScrollStyle );
		v_scrollBar.type = Layout.VERTICALLY;
		v_scrollBar.step = scrollStep;

		mouseUp = new OSignalMouse(OSignalMouse.UP, nme.Lib.stage);

	}

	override public function enableSignals():Void
	{
		h_scrollBar.onChange.add(handleHScrollBarMove);
		v_scrollBar.onChange.add(handleVScrollBarMove);

		h_scrollBar.button.mouseDown.add(handleHScrollBarDown);
		v_scrollBar.button.mouseDown.add(handleVScrollBarDown);

		mouseUp.add(handleRelease);

		enableTween();

		//todo release outside of stage for desktop?
	}

	override public function disableSignals():Void
	{
		h_scrollBar.onChange.remove(handleHScrollBarMove);
		v_scrollBar.onChange.remove(handleVScrollBarMove);

		mouseUp.remove(handleRelease);

		//		disableTween();
	}

	public function disableChildComponentEvents():Void
	{
		if(_isLayout)
		{
			for(o in contentComponent.components)
			{
				//todo check for save non core events that might have been added
				o.disableSignals();
			}
		}
	}

	public function enableChildComponentEvents():Void
	{
		if(_isLayout)
		{
			for(o in contentComponent.components)
			{
				o.enableSignals();
			}
		}
	}

	public function enableTween():Void
	{
		tweenEnabled = true;
		dragEnterFrame = new OCoreEvent(Event.ENTER_FRAME, nme.Lib.stage );
		dragEnterFrame.add(renderDrag);
	}

	public function disableTween():Void
	{
		tweenEnabled = false;
		dragEnterFrame.destroy();
	}

	//todo 
	//addToLayout
	//addVerical
	//addHorizontal

	override public function add(comp:IOComponent):Void
	{
		_isLayout = true;

		contentComponent = comp;

		target.addChild(comp.sprite);
		this.components.push(comp);

		if(mouseTargetDown != null) mouseTargetDown.removeAll();
		mouseTargetDown = new OSignalMouse (OSignalMouse.DOWN, comp.sprite);
		mouseTargetDown.add(handleDownContent);

		if(mouseWheel != null) mouseWheel.removeAll();
		mouseWheel = new OSignalMouse (OSignalMouse.WHEEL, comp.sprite);
		mouseWheel.add(v_scrollBar.handleMouseWheel);

		mouseMove = new OSignalMouse(OSignalMouse.MOVE, comp.sprite);

		invalidate();
	}

	//***********************************************************
	//                  Event Handlers
	//***********************************************************

	private function handleDownContent(e:OSignalMouse):Void
	{
		_down = true;
		_drag = false;
		_xSpeed = 0;
		_xSpeed = 0;
		removeanimateXBack();
		removeanimateYBack();
		_xOffset = e.event.stageX - contentComponent.x;
		_yOffset = e.event.stageY - contentComponent.y;

		mouseMove.removeAll();
		_drag = true;
		//		disableChildComponentEvents();
	}

	private function handleRelease(e:OSignalMouse):Void
	{
		mouseMove.removeAll();
		_drag = false;

		if(tweenEnabled)
		{
			if(_down)
			{
				if(tweenX)
					_xSpeed = (contentComponent.x - _xCache) * _ratio;

				if(tweenY)
					_ySpeed = (contentComponent.y - _yCache) * _ratio;
			}

			if(_scrollbarMove)
			{
				_xSpeed = 0;
				_ySpeed = 0;
			}
		}

		_down = false;
		_scrollbarMove = false;

		//		enableChildComponentEvents();
	}

	private function renderDrag(e:OCoreEvent):Void
	{
		if(! _scrollbarMove)
		{
			removeanimateYBack();
			removeanimateXBack();

			if(! _drag)
			{
				limitSpeed();

				if(tweenX)
					contentComponent.x += (_xSpeed *= _decel);
				if(tweenY)
					contentComponent.y += (_ySpeed *= _decel);

				//				nme.Lib.trace (Math.round(_xSpeed));
				//				nme.Lib.trace (Math.round(_ySpeed));
				if(! isTweening())
				{
					checkYPosition();
					checkXPosition();
				}
			}
			else
			{
				_xCache = contentComponent.x;
				_yCache = contentComponent.y;
				if(tweenX)
					contentComponent.x = nme.Lib.stage.mouseX - _xOffset;
				if(tweenY)
					contentComponent.y = nme.Lib.stage.mouseY - _yOffset;
			}
			updateScrollBarsFromChange();
		}
	}

	private function isTweening():Bool
	{
		var limit = 1;
		if(Math.round(_ySpeed) < limit || Math.round(_xSpeed) < limit)
		{
			return false;
		}
		else
		{
			return true;
		}
	}

	public function handleHScrollBarDown(e:OSignalMouse):Void
	{
		//		disableChildComponentEvents();
	}

	public function handleVScrollBarDown(e:OSignalMouse):Void
	{
		//		disableChildComponentEvents();
	}

	private function handleVScrollBarMove(e:Dynamic = null):Void
	{
		_scrollbarMove = true;

		if(v_scrollBar_enabled)
		{
			contentComponent.y = - v_scrollBar.value;
		}

		checkXPosition(false);
		removeanimateYBack();
	}

	private function handleHScrollBarMove(e:Dynamic = null):Void
	{
		_scrollbarMove = true;

		if(h_scrollBar_enabled)
		{
			contentComponent.x = - h_scrollBar.value;
		}

		checkYPosition(false);
		removeanimateXBack();
	}

	public function handleDragNoTween(e:OSignalMouse):Void
	{

		if(v_scrollBar_enabled)
		{
			contentComponent.y = e.event.stageY - _yOffset;
			_scrollY = - contentComponent.y;

			//todo shouldnt need this as _value clamp should take care in scrollbar???
			if(_scrollY < 0) _scrollY = 0;

			v_scrollBar._value = Std.int(_scrollY);
			v_scrollBar.refreshButton();
		}

		if(h_scrollBar_enabled)
		{
			contentComponent.x = e.event.stageX - _xOffset;
			_scrollX = - contentComponent.x;
			if(_scrollX < 0) _scrollX = 0;

			h_scrollBar._value = Std.int(_scrollX);
			h_scrollBar.refreshButton();
		}

		checkXPosition(false);
		checkYPosition(false);

		e.updateAfterEvent();
	}

	//***********************************************************
	//                  Component Methods
	//***********************************************************

	private inline function limitSpeed():Void
	{
		//if the content is out of bounds limit it's speed
		if(! isValidY())
		{
			if(_ySpeed > _speedLimit) _ySpeed = _speedLimit;
			if(_ySpeed < - _speedLimit) _ySpeed = - _speedLimit;
		}

		if(! isValidX())
		{
			if(_xSpeed > _speedLimit) _xSpeed = _speedLimit;
			if(_xSpeed < - _speedLimit) _xSpeed = - _speedLimit;
		}
	}

	public function animateToxPos():Void
	{
		if(! _removeanimateXBackAnimating && tweenX)
		{
			_removeanimateXBackAnimating = true;
			nme.Lib.stage.addEventListener(Event.ENTER_FRAME, animateXBack);
		}
	}

	public function animateXBack(e:Event):Void
	{
		contentComponent.x += (_xPos - contentComponent.x) / _tweenBackSpeed;

		if(contentComponent.x == _xPos)
		{
			removeanimateXBack();
		}
	}

	public function removeanimateXBack():Void
	{
		if(_removeanimateXBackAnimating)
		{
			nme.Lib.stage.removeEventListener(Event.ENTER_FRAME, animateXBack);
			_removeanimateXBackAnimating = false;
		}
	}

	public function animateToYPos():Void
	{
		if(! _removeanimateYBackAnimating && tweenY)
		{
			_removeanimateYBackAnimating = true;
			nme.Lib.stage.addEventListener(Event.ENTER_FRAME, animateYBack);
		}
	}

	public function animateYBack(e:Event):Void
	{
		contentComponent.y += (_yPos - contentComponent.y) / _tweenBackSpeed;

		if(contentComponent.y == _yPos)
		{
			removeanimateYBack();
		}
	}

	public function removeanimateYBack():Void
	{
		if(_removeanimateYBackAnimating)
		{
			_removeanimateYBackAnimating = false;
			nme.Lib.stage.removeEventListener(Event.ENTER_FRAME, animateYBack);
		}
	}

	public function updateScrollBarsFromChange():Void
	{
		if(v_scrollBar_enabled)
		{
			_scrollY = - contentComponent.y;
			//todo shouldnt need this as _value clamp should take care in scrollbar???
			if(_scrollY < 0) _scrollY = 0;

			v_scrollBar._value = Std.int(_scrollY);
			v_scrollBar.refreshButton();
		}

		if(h_scrollBar_enabled)
		{
			_scrollX = - contentComponent.x;
			if(_scrollX < 0) _scrollX = 0;

			h_scrollBar._value = Std.int(_scrollX);
			h_scrollBar.refreshButton();
		}
	}

	public function checkYPosition(animate:Bool = true):Void
	{
		var isValid = isValidY();

		if(! isValid)
		{
			animate ? animateToYPos() : contentComponent.y = _yPos;
		}
	}

	private inline function isValidY():Bool
	{
		var isValid = true;
		if(contentComponent.y > 0)
		{
			_yPos = 0;
			isValid = false;
		}

		var ylimit = - (contentComponent.height - _rect.height);

		if(contentComponent.y < ylimit)
		{
			isValid = false;
			v_scrollBar.barNeeded ? _yPos = ylimit : _yPos = 0;
		}

		return isValid;
	}

	public function checkXPosition(animate:Bool = true):Void
	{
		var isValid = isValidX();

		if(! isValid)
		{
			animate ? animateToxPos() : contentComponent.x = _xPos;
		}
	}

	private function isValidX():Bool
	{
		var isValid = true;
		if(contentComponent.x > 0)
		{
			_xPos = 0;
			isValid = false;
		}

		var xlimit = - (contentComponent.width - _rect.width);

		if(contentComponent.x < xlimit)
		{
			isValid = false;
			h_scrollBar.barNeeded ? _xPos = xlimit : _xPos = 0;
		}
		return isValid;
	}

	override public function setDirection(value:Int):Int
	{
		_direction = value;

		if(_direction == Layout.VERTICALLY)
		{
			h_scrollBar_enabled = false;
			v_scrollBar_enabled = true;
		}
		else if(_direction == Layout.HORIZONTALLY)
		{
			h_scrollBar_enabled = true;
			v_scrollBar_enabled = false;
		}

		invalidate();

		return _direction;
	}

	public function updateScrollBars():Void
	{
		h_scrollBar.move(0, _height - scrollButtonSize);
		v_scrollBar.move(_width - scrollButtonSize, 0);

		updateContentSize();

		if(h_scrollBar_enabled)
		{
			if(v_scrollBar_enabled)
			{
				_rect.width = _width - scrollButtonSize;
				h_scrollBar.pageSize = Std.int(_rect.width);
				_rect.height = _height - scrollButtonSize;
				v_scrollBar.pageSize = Std.int(_rect.height);

				h_scrollBar._size(_width - scrollButtonSize, scrollButtonSize);
				v_scrollBar._size(scrollButtonSize, _height - scrollButtonSize);

				if(! v_scrollBar.barNeeded)
				{
					if(v_scrollBar.sprite.parent != null) sprite.removeChild(v_scrollBar.sprite);
					_rect.width = _width;
					h_scrollBar.pageSize = Std.int(_rect.width);
					h_scrollBar._size(_width, scrollButtonSize);
				}
				else
				{
					if(v_scrollBar.sprite.parent == null) sprite.addChild(v_scrollBar.sprite);
				}

				if(! h_scrollBar.barNeeded)
				{
					if(h_scrollBar.sprite.parent != null) sprite.removeChild(h_scrollBar.sprite);
					_rect.height = _height;
					v_scrollBar.pageSize = Std.int(_rect.height);
					v_scrollBar._size(scrollButtonSize, _height);
				}
				else
				{
					if(h_scrollBar.sprite.parent == null) sprite.addChild(h_scrollBar.sprite);
				}
			}
			else
			{
				_rect.width = _width;
				h_scrollBar.pageSize = Std.int(_rect.width);
				_rect.height = _height - scrollButtonSize;
				v_scrollBar.pageSize = Std.int(_rect.height);
				h_scrollBar._size(_width, scrollButtonSize);

				v_scrollBar._size(0, 0);

				if(v_scrollBar.sprite.parent != null) sprite.removeChild(v_scrollBar.sprite);

				if(! h_scrollBar.barNeeded)
				{
					if(h_scrollBar.sprite.parent != null) sprite.removeChild(h_scrollBar.sprite);
					_rect.height = _height;
					v_scrollBar.pageSize = Std.int(_rect.height);
				}
				else
				{
					if(h_scrollBar.sprite.parent == null) sprite.addChild(h_scrollBar.sprite);
				}
			}
		}
		else
		{
			if(v_scrollBar_enabled)
			{
				_rect.width = _width - scrollButtonSize;
				h_scrollBar.pageSize = Std.int(_rect.width);
				_rect.height = _height;
				v_scrollBar.pageSize = Std.int(_rect.height);

				h_scrollBar._size(0, 0);
				v_scrollBar._size(scrollButtonSize, _height);

				if(! v_scrollBar.barNeeded)
				{
					if(v_scrollBar.sprite.parent != null) sprite.removeChild(v_scrollBar.sprite);
					_rect.width = _width;
					h_scrollBar.pageSize = Std.int(_rect.width);
				}
				else
				{
					if(v_scrollBar.sprite.parent == null) sprite.addChild(v_scrollBar.sprite);
				}
			}
			else
			{
				_rect.width = _width;
				h_scrollBar.pageSize = Std.int(_rect.width);
				_rect.height = _height;
				v_scrollBar.pageSize = Std.int(_rect.height);

				h_scrollBar._size(0, 0);
				v_scrollBar._size(0, 0);

				if(! v_scrollBar.barNeeded)
				{
					if(v_scrollBar.sprite.parent != null) sprite.removeChild(v_scrollBar.sprite);
				}
				else
				{
					if(v_scrollBar.sprite.parent == null) sprite.addChild(v_scrollBar.sprite);
				}
			}

			if(h_scrollBar.sprite.parent != null) sprite.removeChild(h_scrollBar.sprite);
		}

		target.scrollRect = _rect;
	}

	public function updateContentSize():Void
	{
		if(contentComponent != null)
		{
			var height = Std.int(contentComponent.height);
			var width = Std.int(contentComponent.width);

			h_scrollBar.contentSize = width;
			v_scrollBar.contentSize = height;
		}
	}

	override public function invalidate(recursive:Bool = true):Void
	{
		updateScrollBars();

		h_scrollBar.invalidate();
		v_scrollBar.invalidate();

		super.invalidate(false);
	}

	override public function draw():Void
	{
		coreDraw();
	}

	override public function getHeight():Float
	{
		return _height;
	}

	override public function getWidth():Float
	{
		return _width;
	}

	//***********************************************************
	//                  Component Style
	//***********************************************************

	override public function getStyleId():String
	{
		return ScrollContainerStyle.styleString;
	}
}

class ScrollContainerStyle extends LayoutStyle
{

	public static var styleString:String = "ScrollContainerStyle";

	public var hScrollStyle:ScrollBarStyle;
	public var vScrollStyle:ScrollBarStyle;

	public function new()
	{
		super();
		styleID = styleString;
	}
}


