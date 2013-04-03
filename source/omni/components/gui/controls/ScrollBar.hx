package omni.components.gui.controls;

import omni.utils.OStates;
import omni.components.core.OCore;
import omni.components.core.OComponent;
import omni.utils.signals.OSignalMouse;
import omni.components.core.OButtonBase;
import omni.utils.signals.OSignalType;
import omni.components.core.OLayout;
import omni.components.gui.controls.ScrollBarButton.ScrollBarButtonStyle;
import omni.components.gui.controls.Slider.SliderBaseStyle;
import omni.components.style.base.OBaseStyle;

import flash.display.Bitmap;
import nme.events.TimerEvent;
import nme.utils.Timer;

class ScrollBar extends OComponent
{
    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var increaseButton:ScrollBarButton;
    public var decreaseButton:ScrollBarButton;

    public var scrollSlider:ScrollSlider;

    public var onChange(default, null):OSignalType<Int -> Void>;

    public var type(get_type, set_type):String;
    public var _type:String;

    #if haxe3 @:isVar #end public var sliderStep(get_sliderStep, set_sliderStep):Int;

    public var value(get_value, set_value):Int;
    public var _value:Int = 0;

    public var max(get_max, set_max):Float;
    public var _max:Float = 100;

    public var min(get_min, set_min):Float;
    public var _min:Float = 0;

    #if haxe3 @:isVar #end public var contentSize(default, set_contentSize):Int = 0;

    #if haxe3 @:isVar #end public var pageSize(default, set_pageSize):Int = 0;

    #if haxe3 @:isVar #end public var barNeeded(get_barNeeded, set_barNeeded):Bool;

    //***********************************************************
    //                  Style Variables
    //***********************************************************

    private var _sliderStep:Int;
    private var _buttonStep:Int;
    private var _buttonMovementInterval:Float;
    private var _initialButtonMovementDelay:Float;
    private var _enableScrollButtons:Bool;
    private var _enableScrollSlider:Bool;

    //***********************************************************
    //                  Private Variables
    //***********************************************************

    private var _increasing:Bool;
    private var _timer:Timer;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        _sliderStep = styleAsScrollBar.sliderStep;
        _buttonStep = styleAsScrollBar.buttonStep;
        _buttonMovementInterval = styleAsScrollBar.buttonMovementInterval;
        _initialButtonMovementDelay = styleAsScrollBar.initialButtonMovementDelay;

        _enableScrollButtons = styleAsScrollBar.enableScrollButtons;
        _enableScrollSlider = styleAsScrollBar.enableScrollSlider;

        if (_enableScrollSlider)
            createScrollSlider();

        if (_enableScrollButtons)
            createScrollButtons();

        onChange = new OSignalType<Int -> Void>();
    }

    override public function enableSignals():Void
    {
        if (!_listening)
        {
            scrollSlider.onChange.add(handleOnChange);

            increaseButton.onMouseDown.add(handleOnIncrease);
            decreaseButton.onMouseDown.add(handleOnDecrease);

            _listening = true;
        }
    }

    override public function disableSignals():Void
    {
        if (_listening)
        {
            scrollSlider.onChange.remove(handleOnChange);

            increaseButton.onMouseDown.remove(handleOnIncrease);
            decreaseButton.onMouseDown.remove(handleOnDecrease);

            _listening = false;
        }
    }

    override public function drawMembers():Void
    {
        super.drawMembers();

        if (_type == OStates.VERTICAL)
        {
            scrollSlider._height = height - (increaseButton.height + decreaseButton.height);
            increaseButton._width = width;
            decreaseButton._width = width;
            increaseButton.y = height - increaseButton.height;
            scrollSlider.y = decreaseButton.height;
        }
        else
        {
            scrollSlider._width = width - (increaseButton.width + decreaseButton.width);
            increaseButton._height = _height;
            decreaseButton._height = _height;
            increaseButton.x = width - increaseButton.width;
            scrollSlider.x = decreaseButton._width;
        }

        scrollSlider.drawNow();
    }

    //***********************************************************
    //                  Event Handlers
    //***********************************************************

    public function handleOnChange(value:Int):Void
    {
        set_value(value);
    }

    public function handleOnIncrease(?e:OSignalMouse):Void
    {
        _increasing = true;
        set_value(_value + _buttonStep);
        OCore.instance.onStageMouseUp.addOnce(handleMouseUp);

        _timer.reset();
        _timer.start();
    }

    public function handleOnDecrease(?e:OSignalMouse):Void
    {
        _increasing = false;
        set_value(_value - _buttonStep);
        OCore.instance.onStageMouseUp.addOnce(handleMouseUp);

        _timer.reset();
        _timer.start();
    }

    private function handleMouseUp(?e:OSignalMouse):Void
    {
        _timer.stop();
        _timer.delay = _initialButtonMovementDelay;
    }

    public function handleTimerTick(?t:TimerEvent):Void
    {
        _timer.delay = _buttonMovementInterval;
        _increasing ? set_value(_value + _buttonStep) : set_value(_value - _buttonStep);
    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public function refreshButton():Void
    {
        scrollSlider._value = _value;
        scrollSlider.refreshButton();
    }

    public function createScrollButtons():Void
    {
        var styleAs = cast (_style, ScrollBarStyle);
        increaseButton = new ScrollBarButton(styleAs.increaseButton);
        add(increaseButton);

        decreaseButton = new ScrollBarButton(styleAs.decreaseButton);
        add(decreaseButton);

        _timer = new Timer(_initialButtonMovementDelay);
        _timer.addEventListener(TimerEvent.TIMER, handleTimerTick);

    }

    public function createScrollSlider():Void
    {
        var styleAs = cast (_style, ScrollBarStyle);
        scrollSlider = new ScrollSlider(styleAs.slider);
        scrollSlider.step = _sliderStep;
        scrollSlider._min = _min;
        scrollSlider._max = _max;
        scrollSlider._value = _value;
        add(scrollSlider);

    }

    private function clamp(value:Int):Int
    {
        if (_max > _min)
        {
            if (value > Std.int(_max))value = Std.int(_max);
            if (value < Std.int(_min))value = Std.int(_min);
        }
        else
        {
            value = Std.int(_max);
            _min = _max;
        }
        return value;
    }

    //***********************************************************
    //                  Properties
    //***********************************************************

    public function set_sliderStep(value:Int):Int
    {
        if (_sliderStep != value)
        {
            _sliderStep = value;
            if (scrollSlider != null)
                scrollSlider.step = _sliderStep;
        }
        return _sliderStep;
    }

    public function get_sliderStep():Int
    {
        return _sliderStep;
    }

    public function set_type(value:String):String
    {
        if (_type != value)
        {
            _type = value;
            if (scrollSlider != null)
                scrollSlider.type = _type;
            invalidate();
        }
        return _type;
    }

    public function get_type():String
    {
        return _type;
    }

    public function get_value():Int
    {
        return _value;
    }

    public function set_value(value:Int):Int
    {
        if (_value != value)
        {
            value = clamp(value);
            _value = value;

            if (scrollSlider != null)
                scrollSlider._value = _value;

            invalidate();
            onChange.dispatch(_value);
        }
        return value;
    }

    private function get_max():Float
    {
        return _max;
    }

    private function set_max(value:Float):Float
    {
        if (_max != value)
        {
            _max = value;

            if (scrollSlider != null)
                scrollSlider._max = _max;

            invalidate();
        }
        return value;
    }

    private function get_min():Float
    {
        return _min;
    }

    private function set_min(value:Float):Float
    {
        if (_min != value)
        {
            _min = value;

            if (scrollSlider != null)
                scrollSlider._min = _min;

            invalidate();
        } return value;
    }

    public function set_barNeeded(value:Bool):Bool
    {
        barNeeded = value;

        if (scrollSlider != null)
            scrollSlider.barNeeded = barNeeded;

        return barNeeded;
    }

    public function get_barNeeded():Bool
    {
        _max = Math.max(contentSize - pageSize, 0);

        if (_max > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public function set_contentSize(value:Int):Int
    {
        if (contentSize != value)
        {
            contentSize = value;
            if (scrollSlider != null)
                scrollSlider.contentSize = contentSize;

            invalidate();
        }
        return value;
    }

    public function set_pageSize(value:Int):Int
    {
        if (pageSize != value)
        {
            pageSize = value;
            if (scrollSlider != null)
                scrollSlider.pageSize = pageSize;

            invalidate();
        }
        return value;
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    private var styleAsScrollBar(get_styleAsScrollBar, null):ScrollBarStyle;

    private function get_styleAsScrollBar():ScrollBarStyle
    {
        return cast(_style, ScrollBarStyle);
    }

    override public function get_styleId():String
    {
        return ScrollBarStyle.styleString;
    }

}

class ScrollBarStyle extends OBaseStyle
{
    public static var styleString:String = "ScrollLayoutBarsStyle";

    public var increaseButton:ScrollBarButtonStyle;
    public var decreaseButton:ScrollBarButtonStyle;

    public var slider:SliderBaseStyle;

    public var sliderStep:Int;
    public var buttonStep:Int;
    public var enableScrollButtons:Bool;
    public var enableScrollSlider:Bool;
    public var buttonMovementInterval:Float;
    public var initialButtonMovementDelay:Float;

    public function new()
    {
        super();
        styleID = styleString;
    }
}