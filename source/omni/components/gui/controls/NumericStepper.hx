package omni.components.gui.controls;

import omni.components.gui.controls.NumericStepperButton.NumericStepperButtonStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponentButton;
import omni.components.core.OComponentButton.OComponentButtonStyle;
import omni.components.gui.controls.Button.ButtonStyle;
import omni.components.core.OComponent;
import omni.components.core.OCore;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.signals.OSignalType;
import omni.components.core.OTextBase;
import omni.components.core.OButtonBase;
import omni.components.gui.text.Label;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.utils.ComponentUtils;

import nme.utils.Timer;
import nme.events.TimerEvent;
import nme.events.MouseEvent;

class NumericStepper extends OComponent
{

//***********************************************************
//                  Public Variables
//***********************************************************

    public var textBase:OTextBase;
    public var increase:NumericStepperButton;
    public var decrease:NumericStepperButton;

    public var onMouseWheel:OSignalMouse;
    public var onChange(default, null):OSignalType<Int -> Void>;

    public var value(get_value, set_value):Int;
    public var max(get_max, set_max):Int;
    public var min(get_min, set_min):Int;

//***********************************************************
//                  Style Variables
//***********************************************************

    public var step:Int;
    public var _value:Int;
    public var _max:Int;
    public var _min:Int;

    private var _initialButtonTimerDelay:Float;
    private var _timerInterval:Float;

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
        _max = styleAsNumericStepper.max;
        _min = styleAsNumericStepper.min;
        _value = styleAsNumericStepper.value;
        step = styleAsNumericStepper.step;
        _initialButtonTimerDelay = styleAsNumericStepper.initialButtonTimerDelay;
        _timerInterval = styleAsNumericStepper.timerInterval;

        onChange = new OSignalType();
        onMouseWheel = new OSignalMouse(OSignalMouse.WHEEL, this.sprite);

        textBase = new Label(styleAsNumericStepper.textStyle);
        //textBase.trackTheme = false;
        add(textBase);

        increase = new NumericStepperButton(styleAsNumericStepper.increaseButtonStyle);
        //increase.trackTheme = false;
        add(increase);

        decrease = new NumericStepperButton(styleAsNumericStepper.decreaseButtonStyle);
        //decrease.trackTheme = false;
        add(decrease);

        _timer = new Timer(_initialButtonTimerDelay);
        _timer.addEventListener(TimerEvent.TIMER, handleTimerTick);
    }

    override public function enableSignals():Void
    {
        increase.onMouseDown.add(handleIncreaseClick);
        decrease.onMouseDown.add(handleDecreaseClick);
        onMouseWheel.add(handleMouseWheel);
    }

    override public function disableSignals():Void
    {
        increase.onMouseDown.remove(handleIncreaseClick);
        decrease.onMouseDown.remove(handleDecreaseClick);
    }

    override public function draw():Void
    {
        super.draw();
        textBase.text = Std.string(value);

        updatePositions();
    }

//***********************************************************
//                  Event Handlers
//***********************************************************

    private function handleMouseWheel(?e:OSignalMouse):Void
    {
        value += (e.delta > 0 ? 1 : -1) * step;
    }

    private function handleTimerTick(e:TimerEvent):Void
    {
        _timer.delay = _timerInterval;
        value += _increasing ? step : -step;
    }

    private function handleIncreaseClick(?e:OSignalMouse):Void
    {
        value += step;
        OCore.instance.onStageMouseUp.addOnce(handleMouseUp);
        _increasing = true;
        _timer.reset();
        _timer.start();
        invalidate();
    }

    private function handleDecreaseClick(?e:OSignalMouse):Void
    {
        value -= step;

        OCore.instance.onStageMouseUp.addOnce(handleMouseUp);
        _increasing = false;
        _timer.reset();
        _timer.start();
        invalidate();
    }

    private function handleMouseUp(?e:OSignalMouse):Void
    {
        _timer.stop();
        _timer.delay = _initialButtonTimerDelay;
    }

//***********************************************************
//                  Component Methods
//***********************************************************

    private inline function updatePositions():Void
    {
        increase._width = _height;
        increase._height = _height * .5;

        decrease._width = _height;
        decrease._height = _height * .5;

        increase.x = _width - increase.width;
        decrease.x = _width - decrease.width;

        decrease.y = _height * .5;

        ComponentUtils.VAlignToOther(textBase, this);
    }

    private inline function fixValue():Void
    {
        if (_max > _min)
        {
            if (_value > _max)_value = _max;
            if (_value < _min)_value = _min;
        }
        else
        {
            _value = _min = _max;
        }
        textBase.text = Std.string(_value);
    }

//***********************************************************
//                  Properties
//***********************************************************

    public function get_value():Int
    {
        return _value;
    }

    public function set_value(value:Int):Int
    {
        if (_value != value)
        {
            _value = value;
            fixValue();
            invalidate();
            onChange.dispatch(_value);
        }
        return _value;
    }

    public function set_max(value:Int):Int
    {
        if (_max != value)
        {
            _max = value;
            fixValue();
            invalidate();
        }
        return _max;
    }

    public function get_max():Int
    {
        return _max;
    }

    public function set_min(value:Int):Int
    {
        if (_min != value)
        {
            _min = value;
            fixValue();
            invalidate();
        }
        return _min;
    }

    public function get_min():Int
    {
        return _min;
    }

//***********************************************************
//                  Component Style
//***********************************************************

    public var styleAsNumericStepper(get_styleAsNumericStepper, null):NumericStepperStyle;

    public function get_styleAsNumericStepper():NumericStepperStyle
    {
        return cast(_style, NumericStepperStyle);
    }

    override public function get_styleId():String
    {
        return NumericStepperStyle.styleString;
    }
}

/**
* 
* Numeric Stepper style
*
*/
class NumericStepperStyle extends OBaseBackgroundStyle
{

    public static var styleString:String = "NumericStepperStyle";

    public var increaseButtonStyle:NumericStepperButtonStyle;
    public var decreaseButtonStyle:NumericStepperButtonStyle;
    public var textStyle:TextBaseStyle;

    public var step:Int;
    public var value:Int;
    public var max:Int;
    public var min:Int;
    public var initialButtonTimerDelay:Float;
    public var timerInterval:Float;

    public function new()
    {
        super();
        styleID = styleString;
    }

}