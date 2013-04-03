package omni.components.gui.layout;

import omni.components.core.OContainer;
import omni.utils.OStates;
import omni.components.style.base.OBaseStyle;
import omni.components.gui.controls.ScrollBar;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.utils.signals.OCoreEvent;
import omni.utils.signals.OSignalMouse;
import omni.components.core.OCore;
import omni.components.gui.controls.ScrollSlider;
import omni.components.core.OLayout;
import omni.utils.ComponentUtils;

import nme.display.DisplayObject;
import nme.display.DisplayObjectContainer;
import nme.display.Sprite;
import nme.events.MouseEvent;
import nme.events.Event;
import nme.geom.Point;
import nme.geom.Rectangle;

class ScrollContainer extends OContainer
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    private var h_scrollBar_enabled:Bool = true;
    private var v_scrollBar_enabled:Bool = true;

    public var hScrollBar:ScrollBar;
    public var vScrollBar:ScrollBar;

    public var contentComponent:IOComponent;

    public var mouseTargetDown:OSignalMouse;
    public var mouseUp:OSignalMouse;
    public var mouseWheel:OSignalMouse;
    public var dragEnterFrame:OCoreEvent;

    //***********************************************************
    //                  Style Variables
    //***********************************************************

    private var _scrollStep:Int;
    private var _scrollButtonSize:Int;
    private var _tweenBackSpeed:Int;
    private var _tweenEnabled:Bool;
    private var _speedLimit:Float;
    private var _ratio:Float;
    private var _decel:Float;
    private var _mouseWheelV:Bool;
    private var _touchTolerance:Int;
    private var _hContentAlign:String;
    //todo
    public var _direction:String;

    //***********************************************************
    //                  Private Variables
    //***********************************************************

    private var _xSpeed:Float = 0;
    private var _ySpeed:Float = 0;
    private var _rect:Rectangle;
    private var _xOffset:Float = 0;
    private var _yOffset:Float = 0;
    private var _scrollY:Float = 0;
    private var _scrollX:Float = 0;
    private var _down:Bool = false;
    private var _yPos:Float;
    private var _xPos:Float;
    private var _xCache:Float = 0;
    private var _yCache:Float = 0;
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
    private var _isValidTemp:Bool;
    private var _tempFloat:Float;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        _scrollButtonSize = styleAsScrollContainer.scrollButtonSize;
        _scrollStep = styleAsScrollContainer.scrollStep;
        _tweenBackSpeed = styleAsScrollContainer.tweenBackSpeed;
        _speedLimit = styleAsScrollContainer.speedLimit;
        _ratio = styleAsScrollContainer.ratio;
        _decel = styleAsScrollContainer.decel;
        _mouseWheelV = styleAsScrollContainer.mouseWheelV;
        _touchTolerance = styleAsScrollContainer.touchTolerance;
        _tweenEnabled = styleAsScrollContainer.tweenEnabled;
        _hContentAlign = styleAsScrollContainer.hContentAlign;

        _rect = new Rectangle(0, 0, 0, 0);

        target = new Sprite();
        target.scrollRect = _rect;
        sprite.addChild(target);

        hScrollBar = new ScrollBar(styleAsScrollContainer.hScrollStyle);
        hScrollBar.type = OStates.HORIZONTAL;
        hScrollBar.sliderStep = _scrollStep;

        vScrollBar = new ScrollBar(styleAsScrollContainer.vScrollStyle);
        vScrollBar.type = OStates.VERTICAL;
        vScrollBar.sliderStep = _scrollStep;

        mouseUp = OCore.instance.onStageMouseUp;
    }

    override public function add(comp:IOComponent):IOComponent
    {
        _isLayout = true;

        contentComponent = comp;

        target.addChild(comp.sprite);
        this.members.push(comp);

        if (_tweenEnabled)
        {
            target.buttonMode = true;

            if (mouseTargetDown != null) mouseTargetDown.removeAll();
            mouseTargetDown = new OSignalMouse (OSignalMouse.MOUSE_DOWN, comp.sprite);
            mouseTargetDown.add(handleDownContent);
        }

        //if (mouseWheel != null) mouseWheel.removeAll();
        mouseWheel = new OSignalMouse (OSignalMouse.MOUSE_WHEEL, comp.sprite);
        mouseWheel.add(handleMouseWheel);

        invalidate();

        return comp;
    }

    override public function enableSignals():Void
    {
        hScrollBar.onChange.add(handleHScrollBarMove);
        vScrollBar.onChange.add(handleVScrollBarMove);

        hScrollBar.scrollSlider.button.onMouseDown.add(handleScrollBarsDown);
        vScrollBar.scrollSlider.button.onMouseDown.add(handleScrollBarsDown);
        hScrollBar.scrollSlider.button.onMouseUp.add(handleScrollBarsUp);
        vScrollBar.scrollSlider.button.onMouseUp.add(handleScrollBarsUp);

        mouseUp.add(handleRelease);

        if (_tweenEnabled)
            enableTween();

        //todo release outside of stage for desktop?
    }

    override public function disableSignals():Void
    {
        hScrollBar.onChange.remove(handleHScrollBarMove);
        vScrollBar.onChange.remove(handleVScrollBarMove);

        mouseUp.remove(handleRelease);
    }

    override public function draw():Void
    {

        if (contentComponent != null)
        {
            super.draw();

            contentComponent.size(width, height);
            contentComponent.drawNow();

            updateScrollBars();

            hScrollBar.drawNow();
            vScrollBar.drawNow();

            if (!_tweenEnabled)
            {
                isValidX(true);
                isValidY(true);
            }

        }

    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public function setMouseChildrenOnContent():Void
    {
        //todo use overlay blocking sprite for html5? doesnt support mouseChildren
    }

    public function enableTween():Void
    {
        _tweenEnabled = true;
        dragEnterFrame = new OCoreEvent(Event.ENTER_FRAME, nme.Lib.stage );
        dragEnterFrame.add(handleRenderDrag);
    }

    public function disableTween():Void
    {
        _tweenEnabled = false;
        dragEnterFrame.destroy();
    }

    //***********************************************************
    //                  Event Handlers
    //***********************************************************

    public function handleMouseWheel(?e:OSignalMouse):Void
    {
        //target.mouseChildren = true;

        _scrollBarMove = true;

        //if( ! OCore.instance.disableScrolling )
        //{

        if (_mouseWheelV)
        {
            vScrollBar.value -= e.delta > 0 ? vScrollBar.sliderStep : -vScrollBar.sliderStep;
        }
        else
        {
            hScrollBar.value -= e.delta > 0 ? hScrollBar.sliderStep : -hScrollBar.sliderStep;
        }

        if (OCore.instance.updateAfterEvent)
            e.updateAfterEvent();

        //}
    }

    private function handleDownContent(e:OSignalMouse):Void
    {
        if (!OCore.instance.disableScrolling)
        {
            _down = true;
            _drag = false;
            _xSpeed = 0;
            _xSpeed = 0;
            removeanimateXBack();
            removeanimateYBack();
            _xOffset = e.event.stageX - contentComponent.x;
            _yOffset = e.event.stageY - contentComponent.y;
            _xTouchOffset = nme.Lib.stage.mouseX;
            _yTouchOffset = nme.Lib.stage.mouseY;
            _drag = true;
        }
        else
        {
            resetPosition();
        }
    }

    private function handleRelease(e:OSignalMouse):Void
    {
        target.mouseChildren = true;

        if (OCore.instance.disableScrolling)
        {
            resetPosition();
        }
        else
        {
            _draggingInit = false;
            _drag = false;

            if (_tweenEnabled)
            {
                if (_down)
                {
                    if (_tweenX)
                        _xSpeed = (contentComponent.x - _xCache) * _ratio;

                    if (_tweenY)
                        _ySpeed = (contentComponent.y - _yCache) * _ratio;
                }
                _down = false;

                if (_scrollBarMove)
                {
                    _xSpeed = 0;
                    _ySpeed = 0;
                }
                _scrollBarMove = false;
            }
        }
    }

    private function handleRenderDrag(e:OCoreEvent):Void
    {
        if (!OCore.instance.disableScrolling)
        {

            if (!_scrollBarMove)
            {
                removeanimateYBack();
                removeanimateXBack();

                if (!_drag)
                {
                    limitSpeed();

                    if (_tweenX)
                        contentComponent.x += (_xSpeed *= _decel);
                    if (_tweenY)
                        contentComponent.y += (_ySpeed *= _decel);

                    if (!isTweening())
                    {
                        checkYPosition();
                        checkXPosition();
                    }

                    roundSpeed();
                }
                else if (!OCore.instance.disableScrolling)
                {
                    _xCache = contentComponent.x;
                    _yCache = contentComponent.y;

                    if (_draggingInit == true || isTweening())
                    {
                        if (h_scrollBar_enabled && _tweenX)
                            contentComponent.x = nme.Lib.stage.mouseX - _xOffset;

                        if (v_scrollBar_enabled && _tweenY)
                            contentComponent.y = nme.Lib.stage.mouseY - _yOffset;

                    }
                    else if (Std.int(_ySpeed * 10) == 0 && Std.int(_xSpeed * 10) == 0)
                    {
                        if (_xTouchOffset - nme.Lib.stage.mouseX > _touchTolerance || _xTouchOffset - nme.Lib.stage.mouseX < -_touchTolerance || _yTouchOffset - nme.Lib.stage.mouseY > _touchTolerance || _yTouchOffset - nme.Lib.stage.mouseY < -_touchTolerance)
                        {
                            _draggingInit = true;
                            target.mouseChildren = false;
                            //							disableChildComponentEvents( );
                        }
                    }
                    else
                    {
                        _draggingInit = true;
                        target.mouseChildren = false;
                    }
                }

                updateScrollBarsFromChange();
            }
        }
        else
        {
            resetPosition();
        }
    }

    public function handleScrollBarsDown(e:OSignalMouse):Void
    {
        _scrollBarMove = true;
        target.mouseChildren = false;
    }

    public function handleScrollBarsUp(e:OSignalMouse):Void
    {
        _scrollBarMove = false;
        target.mouseChildren = true;
    }

    private function handleVScrollBarMove(e:Dynamic = null):Void
    {
        _scrollBarMove = true;

        if (v_scrollBar_enabled)
        {
            contentComponent.y = -vScrollBar.value;
        }

        checkXPosition(false);
        removeanimateYBack();
    }

    private function handleHScrollBarMove(e:Dynamic = null):Void
    {
        _scrollBarMove = true;

        if (h_scrollBar_enabled)
        {
            contentComponent.x = -hScrollBar.value;
        }

        checkYPosition(false);
        removeanimateXBack();
    }

    public function handleDragNoTween(e:OSignalMouse):Void
    {
        if (!OCore.instance.disableScrolling)
        {

            if (v_scrollBar_enabled)
            {
                contentComponent.y = e.event.stageY - _yOffset;
                _scrollY = -contentComponent.y;

                //todo shouldnt need this as _value clamp should take care in scrollbar???
                if (_scrollY < 0) _scrollY = 0;

                vScrollBar._value = Std.int(_scrollY);
                //todo
                vScrollBar.scrollSlider.refreshButton();
            }

            if (h_scrollBar_enabled)
            {
                contentComponent.x = e.event.stageX - _xOffset;
                _scrollX = -contentComponent.x;
                if (_scrollX < 0) _scrollX = 0;

                hScrollBar._value = Std.int(_scrollX);
                //todo
                hScrollBar.scrollSlider.refreshButton();
            }

            checkXPosition(false);
            checkYPosition(false);

            if (OCore.instance.updateAfterEvent)
                e.updateAfterEvent();

        }
    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public inline function resetPosition():Void
    {
        _xSpeed = 0;
        _ySpeed = 0;
        removeanimateXBack();
        removeanimateYBack();
        checkXPosition(false);
        checkYPosition(false);
    }

    private inline function limitSpeed():Void
    {
        _speedLimit = 10;

        if (!isValidY())
        {
            if (_ySpeed > _speedLimit) _ySpeed = _speedLimit;
            if (_ySpeed < -_speedLimit) _ySpeed = -_speedLimit;
        }

        if (!isValidX())
        {
            if (_xSpeed > _speedLimit) _xSpeed = _speedLimit;
            if (_xSpeed < -_speedLimit) _xSpeed = -_speedLimit;
        }
    }

    public inline function roundSpeed():Void
    {
        if (Std.int(_xSpeed * 10) == 0)
        {
            _xSpeed = 0;
        }

        if (Std.int(_ySpeed * 10) == 0)
        {
            _ySpeed = 0;
        }

    }

    private inline function isTweening():Bool
    {
        var limit = 10;
        if (Math.round(_ySpeed) < limit || Math.round(_xSpeed) < limit)
        {
            return false;
        }
        else
        {
            return true;
        }
    }

    private inline function tween(currentValue:Float, targetValue:Float, tweenValue:Float = 0.4):Float
    {
        if (currentValue != targetValue)
        {
            _tempFloat = targetValue - currentValue;
            currentValue += _tempFloat * tweenValue;
            _tempFloat = _tempFloat < 0 ? -_tempFloat : _tempFloat;
            if (_tempFloat < 1)
            {
                currentValue = targetValue;
            }
            currentValue = Math.floor(currentValue);
            return currentValue;
        }
        else
        {
            return currentValue;
        }
    }

    public inline function animateToxPos():Void
    {
        if (!_removeAnimateXBackAnimating && _tweenX)
        {
            _removeAnimateXBackAnimating = true;
            nme.Lib.stage.addEventListener(Event.ENTER_FRAME, animateXBack);
        }
    }

    public inline function animateXBack(e:Event):Void
    {
        contentComponent.x = tween(contentComponent.x, _xPos);
        if (contentComponent.x == _xPos)
        {
            removeanimateXBack();
        }
    }

    public function removeanimateXBack():Void
    {
        if (_removeAnimateXBackAnimating)
        {
            nme.Lib.stage.removeEventListener(Event.ENTER_FRAME, animateXBack);
            _removeAnimateXBackAnimating = false;
        }
    }

    public inline function animateToYPos():Void
    {
        if (!_removeAnimateYBackAnimating && _tweenY)
        {
            _removeAnimateYBackAnimating = true;
            nme.Lib.stage.addEventListener(Event.ENTER_FRAME, animateYBack);
        }
    }

    public inline function animateYBack(e:Event):Void
    {
        contentComponent.y = tween(contentComponent.y, _yPos);
        if (contentComponent.y == _yPos)
        {
            removeanimateYBack();
        }
    }

    public function removeanimateYBack():Void
    {
        if (_removeAnimateYBackAnimating)
        {
            _removeAnimateYBackAnimating = false;
            nme.Lib.stage.removeEventListener(Event.ENTER_FRAME, animateYBack);
        }
    }

    public inline function updateScrollBarsFromChange():Void
    {
        if (v_scrollBar_enabled)
        {
            _scrollY = -contentComponent.y;
            //todo shouldnt need this as _value clamp should take care in scrollbar???
            if (_scrollY < 0) _scrollY = 0;

            vScrollBar._value = Std.int(_scrollY);
            //todo
            vScrollBar.refreshButton();
        }

        if (h_scrollBar_enabled)
        {
            _scrollX = -contentComponent.x;
            if (_scrollX < 0) _scrollX = 0;

            hScrollBar._value = Std.int(_scrollX);
            //todo null
            hScrollBar.refreshButton();
        }
    }

    public inline function checkYPosition(animate:Bool = true):Void
    {
        var isValid = isValidY();

        if (!isValid)
        {
            animate ? animateToYPos() : contentComponent.y = _yPos;
        }
    }

    private inline function isValidY(?move:Bool = false):Bool
    {
        _isValidTemp = true;

        if (contentComponent.y > 0)
        {
            _yPos = 0;
            _isValidTemp = false;
        }

        _tempFloat = -(contentComponent.height - _rect.height);

        if (contentComponent.y < _tempFloat)
        {
            _isValidTemp = false;
            vScrollBar.barNeeded ? _yPos = _tempFloat : _yPos = 0;
        }

        if (move && !_isValidTemp)
            contentComponent.y = _yPos;

        return _isValidTemp;
    }

    public inline function checkXPosition(animate:Bool = true):Void
    {
        _isValidTemp = isValidX();

        if (!_isValidTemp)
        {
            animate ? animateToxPos() : contentComponent.x = _xPos;
        }
    }

    private function isValidX(?move:Bool = false):Bool
    {
        _isValidTemp = true;
        if (contentComponent.x > 0)
        {
            _xPos = 0;
            _isValidTemp = false;
        }

        _tempFloat = -Math.floor(contentComponent.width - _rect.width);

        if (contentComponent.x < _tempFloat)
        {
            _isValidTemp = false;

            if (_hContentAlign == OStates.MIDDLE)
            {
                hScrollBar.barNeeded ? _xPos = _tempFloat : _xPos = _rect.width * .5 - contentComponent._width * .5;
            }
            else if (_hContentAlign == OStates.LEFT)
            {
                hScrollBar.barNeeded ? _xPos = _tempFloat : _xPos = 0;
            }
            //            else if (_hContentAlign == OStates.RIGHT)
            //            {
            //                if (contentComponent.x == Math.floor(_rect.width - contentComponent._width))
            //                {
            //                    _isValidTemp = true;
            //                } else {
            //todo 1px bug issue
            //                    hScrollBar.barNeeded ? _xPos = _tempFloat : _xPos = Math.floor(_rect.width - contentComponent._width) -1;
            //                }
            //            }
        }

        if (move && !_isValidTemp)
            contentComponent.x = _xPos;

        return _isValidTemp;
    }

    public function set_direction(value:String):String
    {
        _direction = value;

        if (_direction == OStates.VERTICAL)
        {
            h_scrollBar_enabled = false;
            v_scrollBar_enabled = true;
        }
        else if (_direction == OStates.HORIZONTAL)
        {
            h_scrollBar_enabled = true;
            v_scrollBar_enabled = false;
        }

        invalidate();

        return _direction;
    }

    public inline function updateScrollBars():Void
    {
        hScrollBar.move(0, _height - _scrollButtonSize);
        vScrollBar.move(_width - _scrollButtonSize, 0);

        updateContentSize();

        hScrollBar.pageSize = Std.int(contentComponent._width);
        hScrollBar.contentSize = Std.int(contentComponent._width);

        if (h_scrollBar_enabled)
        {
            if (v_scrollBar_enabled)
            {
                _rect.width = _width - _scrollButtonSize;
                hScrollBar.pageSize = Std.int(_rect.width);
                _rect.height = _height - _scrollButtonSize;
                vScrollBar.pageSize = Std.int(_rect.height + _scrollButtonSize);

                hScrollBar._size(_width - _scrollButtonSize, _scrollButtonSize);
                vScrollBar._size(_scrollButtonSize, _height - _scrollButtonSize);

                if (!vScrollBar.barNeeded)
                {
                    if (vScrollBar.sprite.parent != null) sprite.removeChild(vScrollBar.sprite);
                    _rect.width = _width;
                    hScrollBar.pageSize = Std.int(_rect.width);
                    hScrollBar._size(_width, _scrollButtonSize);
                }
                else
                {
                    if (vScrollBar.sprite.parent == null) sprite.addChild(vScrollBar.sprite);
                }

                if (!hScrollBar.barNeeded)
                {
                    if (hScrollBar.sprite.parent != null) sprite.removeChild(hScrollBar.sprite);
                    _rect.height = _height;
                    vScrollBar.pageSize = Std.int(_rect.height);
                    vScrollBar._size(_scrollButtonSize, _height);
                }
                else
                {
                    if (hScrollBar.sprite.parent == null) sprite.addChild(hScrollBar.sprite);
                }
            }
            else
            {
                _rect.width = _width;
                hScrollBar.pageSize = Std.int(_rect.width);
                _rect.height = _height - _scrollButtonSize;
                vScrollBar.pageSize = Std.int(_rect.height);
                hScrollBar._size(_width, _scrollButtonSize);

                vScrollBar._size(0, 0);

                if (vScrollBar.sprite.parent != null) sprite.removeChild(vScrollBar.sprite);

                if (!hScrollBar.barNeeded)
                {
                    if (hScrollBar.sprite.parent != null) sprite.removeChild(hScrollBar.sprite);
                    _rect.height = _height;
                    vScrollBar.pageSize = Std.int(_rect.height);
                }
                else
                {
                    if (hScrollBar.sprite.parent == null) sprite.addChild(hScrollBar.sprite);
                }
            }
        }
        else
        {
            if (v_scrollBar_enabled)
            {
                _rect.width = _width - _scrollButtonSize;
                hScrollBar.pageSize = Std.int(_rect.width);
                _rect.height = _height;
                vScrollBar.pageSize = Std.int(_rect.height);

                hScrollBar._size(0, 0);
                vScrollBar._size(_scrollButtonSize, _height);

                if (!vScrollBar.barNeeded)
                {
                    if (vScrollBar.sprite.parent != null) sprite.removeChild(vScrollBar.sprite);
                    _rect.width = _width;
                    hScrollBar.pageSize = Std.int(_rect.width);
                }
                else
                {
                    if (vScrollBar.sprite.parent == null) sprite.addChild(vScrollBar.sprite);
                }
            }
            else
            {
                _rect.width = _width;
                hScrollBar.pageSize = Std.int(_rect.width);
                _rect.height = _height;
                vScrollBar.pageSize = Std.int(_rect.height);

                hScrollBar._size(0, 0);
                vScrollBar._size(0, 0);

                if (!vScrollBar.barNeeded)
                {
                    if (vScrollBar.sprite.parent != null) sprite.removeChild(vScrollBar.sprite);
                }
                else
                {
                    if (vScrollBar.sprite.parent == null) sprite.addChild(vScrollBar.sprite);
                }
            }

            if (hScrollBar.sprite.parent != null) sprite.removeChild(hScrollBar.sprite);
        }

        target.scrollRect = _rect;
    }

    public inline function updateContentSize():Void
    {
        if (contentComponent != null)
        {
            hScrollBar.contentSize = Std.int(contentComponent.width);
            vScrollBar.contentSize = Std.int(contentComponent.height);
        }
    }

    //***********************************************************
    //                  Properties
    //***********************************************************

    override public function get_height():Float
    {
        return _height;
    }

    override public function get_width():Float
    {
        return _width;
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    public var styleAsScrollContainer(get_styleAsScrollContainer, null):ScrollContainerStyle;

    public function get_styleAsScrollContainer():ScrollContainerStyle
    {
        return cast(_style, ScrollContainerStyle);
    }

    override public function get_styleId():String
    {
        return ScrollContainerStyle.styleString;
    }
}

class ScrollContainerStyle extends OLayoutStyle
{

    public static var styleString:String = "ScrollContainerStyle";

    public var hScrollStyle:ScrollBarStyle;
    public var vScrollStyle:ScrollBarStyle;

    public var scrollStep:Int;
    public var scrollButtonSize:Int;
    public var tweenBackSpeed:Int;
    public var speedLimit:Float;
    public var ratio:Float;
    public var decel:Float;
    public var tweenEnabled:Bool;
    public var mouseWheelV:Bool;
    public var touchTolerance:Int;
    public var hContentAlign:String;

    public function new()
    {
        super();
        styleID = styleString;

        hContentAlign = OStates.MIDDLE;
        scrollButtonSize = 10;
        scrollStep = 20;
        tweenEnabled = true;
        tweenBackSpeed = 2;
        speedLimit = 1;
        ratio = .8;
        decel = .96;
        mouseWheelV = true;
        touchTolerance = 10;
    }
}


