package omni.components.gui.layout;

import omni.components.core.OContainer;
import omni.utils.OStates;
import omni.components.style.base.OBaseStyle;
import omni.components.gui.controls.ScrollBar;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.utils.signals.OSignalEvent;
import omni.utils.signals.OSignalMouse;
import omni.components.core.OCore;
import omni.components.gui.controls.ScrollSlider;
import omni.components.core.OLayout;
import omni.utils.ComponentUtils;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.Lib;

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
    public var dragEnterFrame:OSignalEvent;

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
	private var _wheelScrollSpeed : Float = 2;
	private var _wheelValue : Float = 0;

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

        dragEnterFrame = OCore.instance.onStageEnterFrame;
    }

    override public function add(comp:IOComponent):IOComponent
    {
        _isLayout = true;

        contentComponent = comp;

        target.addChild(comp.sprite);
        this.members.push(comp);
        target.buttonMode = true;

        if (mouseTargetDown != null)
        {
            mouseTargetDown.destroy();
            mouseTargetDown = null;
        }

        //mouseTargetDown = new OSignalMouse (OSignalMouse.MOUSE_DOWN, Lib.current.stage);
        //mouseTargetDown = new OSignalMouse (OSignalMouse.MOUSE_DOWN, parentComponent.sprite);
        mouseTargetDown = new OSignalMouse (OSignalMouse.MOUSE_DOWN, comp.sprite);

        //if(_listening && !mouseTargetDown.exists(handleDownContent))
            mouseTargetDown.add(handleDownContent);

        if (mouseWheel != null) mouseWheel.removeAll();
            mouseWheel = new OSignalMouse (OSignalMouse.MOUSE_WHEEL, parentComponent.sprite);

        if (mouseWheel != null)
        {
            mouseWheel.removeAll();
            mouseWheel.add(handleMouseWheel);
        }

        isValidPosition();
        drawNow();


        return comp;
    }

    override public function enableSignals():Void
    {
        if (!_listening)
        {
            dragEnterFrame.add(handleRenderDrag);

            hScrollBar.enableSignals();
            vScrollBar.enableSignals();

            hScrollBar.onChange.add(handleHScrollBarMove);
            vScrollBar.onChange.add(handleVScrollBarMove);
            hScrollBar.scrollSlider.button.onMouseDown.add(handleScrollBarsDown);
            vScrollBar.scrollSlider.button.onMouseDown.add(handleScrollBarsDown);
            hScrollBar.scrollSlider.button.onMouseUp.add(handleScrollBarsUp);
            vScrollBar.scrollSlider.button.onMouseUp.add(handleScrollBarsUp);
            mouseUp.add(handleRelease);

            if (mouseWheel != null)
                mouseWheel.add(handleMouseWheel);

            if (mouseTargetDown != null)
            {
                mouseTargetDown.enable();
                mouseTargetDown.add(handleDownContent);
            }

            _listening = true;
        }
    }

    override public function disableSignals():Void
    {
        if (_listening)
        {
            dragEnterFrame.remove(handleRenderDrag);

            hScrollBar.disableSignals();
            vScrollBar.disableSignals();

            hScrollBar.onChange.remove(handleHScrollBarMove);
            vScrollBar.onChange.remove(handleVScrollBarMove);
            hScrollBar.scrollSlider.button.onMouseDown.remove(handleScrollBarsDown);
            vScrollBar.scrollSlider.button.onMouseDown.remove(handleScrollBarsDown);
            hScrollBar.scrollSlider.button.onMouseUp.remove(handleScrollBarsUp);
            vScrollBar.scrollSlider.button.onMouseUp.remove(handleScrollBarsUp);
            mouseUp.remove(handleRelease);
            _xSpeed = 0;
            _ySpeed = 0;

            if (mouseWheel != null)
                mouseWheel.remove(handleMouseWheel);

            if (mouseTargetDown != null)
            {
                mouseTargetDown.disable();
                mouseTargetDown.remove(handleDownContent);
            }

            _listening = false;
        }
    }

    override public function draw():Void
    {
        if (contentComponent != null)
        {
            super.draw();

            contentComponent._size(width, height);
            contentComponent.drawNow();

            updateScrollBars();

            hScrollBar.drawNow();
            vScrollBar.drawNow();

            isValidPosition();
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
    }

    public function disableTween():Void
    {
        _tweenEnabled = false;
    }

    //***********************************************************
    //                  Event Handlers
    //***********************************************************

    public function handleMouseWheel(?e:OSignalMouse):Void
    {
        if (!OCore.instance.disableScrolling)
        {
            _scrollBarMove = true;
	        _wheelValue = e.delta * _wheelScrollSpeed;

            if (_mouseWheelV)
            {
	            if( _wheelValue >= _wheelScrollSpeed) vScrollBar.value -= vScrollBar.sliderStep;
	            if( _wheelValue <= -_wheelScrollSpeed) vScrollBar.value += vScrollBar.sliderStep;
            }
            else
            {
	            if( _wheelValue >= _wheelScrollSpeed) hScrollBar.value -= hScrollBar.sliderStep;
	            if( _wheelValue <= -_wheelScrollSpeed) hScrollBar.value += hScrollBar.sliderStep;
            }

	        _wheelValue = 0;
            _xSpeed = 0;
            _ySpeed = 0;
            _xCache = contentComponent.x;
            _yCache = contentComponent.y;
            _scrollBarMove = false;

            if (OCore.instance.updateAfterEvent)
                e.updateAfterEvent();
        }
    }

    private function handleDownContent(e:OSignalMouse):Void
    {
        if (!OCore.instance.disableScrolling)
        {
            _down = true;
            _xSpeed = 0;
            _ySpeed = 0;
            _xOffset = e.event.stageX - contentComponent.x;
            _yOffset = e.event.stageY - contentComponent.y;
            _xTouchOffset = Lib.current.stage.mouseX;
            _yTouchOffset = Lib.current.stage.mouseY;
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
            //isValidPosition();
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

    private function handleRenderDrag(e:OSignalEvent):Void
    {
        if (!OCore.instance.disableScrolling)
        {

            if (!_scrollBarMove)
            {
                if (!_drag)
                {

                    if (_tweenX)
                        contentComponent.x += (_xSpeed *= _decel);
                    if (_tweenY)
                        contentComponent.y += (_ySpeed *= _decel);

                }
                else if (!OCore.instance.disableScrolling)
                {
                    _xCache = contentComponent.x;
                    _yCache = contentComponent.y;

                    if (h_scrollBar_enabled && _tweenX)
                        contentComponent.x = Lib.current.stage.mouseX - _xOffset;

                    if (v_scrollBar_enabled && _tweenY)
                        contentComponent.y = Lib.current.stage.mouseY - _yOffset;
                }
                isValidPosition();
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
        isValidPosition();
    }

    private function handleHScrollBarMove(e:Dynamic = null):Void
    {
        _scrollBarMove = true;
        if (h_scrollBar_enabled)
        {
            contentComponent.x = -hScrollBar.value;
        }
        isValidPosition();
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

            isValidPosition();

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
        isValidPosition();
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


    public function isValidPosition():Void
    {
        validateXPos();
        validateYPos();
    }

    private inline function validateYPos():Void
    {
        var currentYPos:Float = contentComponent.y;
        var yPos:Float = currentYPos;

        if (_rect.height > contentComponent._height)
        {
            if (contentComponent.y > 0)
            {
                yPos = 0;
            }
            else if (contentComponent.y < -(0))
            {
                yPos = 0;
            }
        }
        else
        {
            if (contentComponent.y > 0)
            {
                yPos = 0;
            }
            else if (contentComponent.y < -(contentComponent.height - _rect.height))
            {
                yPos = -(contentComponent.height - _rect.height);
            }
        }
        contentComponent.y = yPos;
    }

    private inline function validateXPos():Void
    {
        var currentXPos:Float = contentComponent.x;
        var hAlignMentPos:Float = 0;

        if (_hContentAlign == OStates.LEFT)
        {
            hAlignMentPos = 0;
        }
        else if (_hContentAlign == OStates.MIDDLE)
        {
            hAlignMentPos = (_rect.width * .5 - contentComponent._width * .5);
        }
        var xPos:Float = currentXPos;

        if (_rect.width < contentComponent._width)
        {
            if (contentComponent.x > 0)
            {
                xPos = 0;
            }
            else if (contentComponent.x < -(contentComponent.width - _rect.width))
            {
                xPos = (_rect.width - contentComponent._width);
            }
        }
        else
        {
            if (contentComponent.x != hAlignMentPos)
                xPos = hAlignMentPos;
        }
        contentComponent.x = xPos;
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
    }
}


