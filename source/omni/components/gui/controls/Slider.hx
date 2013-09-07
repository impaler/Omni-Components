package omni.components.gui.controls;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IStyle;
import omni.components.core.OCore;
import omni.components.core.OComponent;
import omni.components.gui.controls.SliderButton.SliderButtonStyle;
import omni.components.gui.controls.Slider;
import omni.components.style.base.OBaseBackgroundStyle;

import omni.utils.OStates;
import omni.utils.UtilNumbers;
import omni.utils.signals.OSignalType;
import omni.utils.signals.OSignalEvent;
import omni.utils.signals.OSignalMouse;
import omni.utils.signals.OSignalMouse;

import flash.display.Sprite;
import flash.geom.Rectangle;

class Slider extends OComponent
{
    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var button:SliderButton;

    public var value(get_value, set_value):Int;
    public var type(get_type, set_type):String;
    public var max(get_max, set_max):Float;
    public var min(get_min, set_min):Float;

    //***********************************************************
    //                  Signals
    //***********************************************************

    public var onMouseMove:OSignalMouse;
    public var onMouseOut:OSignalMouse;
    public var onMouseWheel:OSignalMouse;
    public var onMouseDown:OSignalMouse;
    public var onMouseUp:OSignalMouse;
    public var onChange(default, null):OSignalType<Int -> Void>;
    //todo wheel broken in html5
    private var _mouseWheelTarget(default, set__mouseWheelTarget):Sprite;

    //***********************************************************
    //                  Private Variables
    //***********************************************************

    private var _tempValue:Int = 0;
    private var _rect:Rectangle;
    private var _buttonClick:Bool = false;
	private var _wheelScrollSpeed : Float = 18;
	private var _wheelValue : Float = 0;

    //***********************************************************
    //                  Style Variables
    //***********************************************************

    public var step:Int;
    public var _max:Float;
    public var _type:String;
    public var _value:Int;
    public var _min:Float;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        _rect = new Rectangle();

        _type = styleAs.defaultType;
        _max = styleAs.defaultMax;
        _min = styleAs.defaultMin;
        _value = styleAs.defaultValue;
        step = styleAs.defaultStep;

        onChange = new OSignalType<Int -> Void>();
        onMouseWheel = new OSignalMouse (OSignalMouse.MOUSE_WHEEL, this.sprite);
        onMouseDown = new OSignalMouse (OSignalMouse.MOUSE_DOWN, this.sprite);
	    onMouseOut = new OSignalMouse (OSignalMouse.MOUSE_OUT, this.sprite);
        onMouseUp = OCore.instance.onStageMouseUp;
        onMouseMove = OCore.instance.onStageMouseMove;

        button = new SliderButton(styleAs.buttonStyle);
        add(button);

        sprite.buttonMode = true;
        buttonMode = true;
    }

    override public function enableSignals():Void
    {
        if (!_listening)
        {
            button.onMouseDown.add(handleButtonDown);
            onMouseWheel.add(handleMouseWheel);
            onMouseDown.add(handleMouseDown);
            onMouseUp.add(handleMouseUp);
	        onMouseOut.add(handleMouseOut);

            _listening = true;
        }
    }

    override public function disableSignals():Void
    {
        if (_listening)
        {
            button.onMouseDown.remove(handleButtonDown);
            onMouseDown.remove(handleMouseDown);
            onMouseWheel.remove(handleMouseWheel);
            onMouseUp.remove(handleMouseUp);
	        onMouseOut.remove(handleMouseOut);

            _listening = false;
        }
    }

    override public function destroy():Void
    {
        onMouseWheel.destroy();
        onMouseDown.destroy();
	    onMouseOut.destroy();
        onMouseMove.remove(handleMouseMove);
        onMouseUp.remove(handleMouseUp);
        button.onMouseDown.remove(handleButtonDown);
        OCore.instance.onStageMouseLeave.remove(handleLeftStage);

        super.destroy();
    }

    override public function drawMembers():Void
    {
        refreshButton();

        button.drawNow();
    }

    //***********************************************************
    //                  Event Handlers
    //***********************************************************

    public function handleMouseMove(?e:OSignalMouse):Void
    {
        updateValueOnMouseMove();

        if (OCore.instance.updateAfterEvent)
            e.updateAfterEvent();
    }

    public function handleMouseDown(?e:OSignalMouse):Void
    {
        OCore.instance.disableScrolling = true;

        button.handleMouseDown(e);

        updateButtonLocationFromDown();
        updateValueOnMouseMove();

        button.startDrag(false, _rect);

        onMouseMove.add(handleMouseMove);
    }

    public function handleButtonDown(e:OSignalMouse):Void
    {
        OCore.instance.disableScrolling = true;
        _buttonClick = true;
    }

    public function handleMouseUp(?e:OSignalMouse):Void
    {
        if (OCore.instance.disableScrolling)
            OCore.instance.disableScrolling = false;

        button.stopDrag();
        onMouseMove.remove(handleMouseMove);
        updateValueOnMouseMove();
    }

    public function handleMouseWheel(?e:OSignalMouse):Void
    {
        OCore.instance.disableScrolling = true;

	    _wheelValue = e.delta * _wheelScrollSpeed;
	    if( _wheelValue >= _wheelScrollSpeed) value += step;
	    if( _wheelValue <= -_wheelScrollSpeed) value -= step;
	    _wheelValue = 0;

        if (OCore.instance.updateAfterEvent)
            e.updateAfterEvent();
    }

	public function handleMouseOut(?e:OSignalMouse):Void
	{
		OCore.instance.disableScrolling = false;
	}

    public function handleLeftStage(e:OSignalEvent):Void
    {
        handleMouseUp();
    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public function updateButtonLocationFromDown():Void
    {
        if (_buttonClick == false)
        {
            if (_type == OStates.HORIZONTAL)
            {
                var maxlocation = Math.min(this.width - button.width, this.mouseX - button.width / 2);
                button.x = UtilNumbers.clamp((this.mouseX - button.width / 2), 0, maxlocation);
            }

            if (_type == OStates.VERTICAL)
            {
                var maxlocation = Math.min(this.height - button.height, this.mouseY - button.height / 2);
                button.y = UtilNumbers.clamp((this.mouseY - button.height / 2), 0, maxlocation);
            }
        }
        _buttonClick = false;
    }

    public function updateValueOnMouseMove():Void
    {
        _tempValue = _value;

        if (_type == OStates.HORIZONTAL)
        {
            _tempValue = clamp(Std.int(button.x / (_width - _height) * (_max - _min) + _min));
        }
        else
        {
            _tempValue = clamp(Std.int((_height - _width - button.y) / (_height - _width) * (_max - _min) + _min));
        }

        if (_value != _tempValue)
        {
            _value = _tempValue;
            onChange.dispatch(_value);
        }
    }

    public function refreshButton():Void
    {
        if (_type == OStates.HORIZONTAL)
        {
            button._height = _height;
            button._width = _height;
            _rect.width = _width - _height;
            button.move((_value - _min) / (_max - _min) * _rect.width, 0);
        }
        else
        {
            button._height = _width;
            button._width = _width;
            _rect.height = _height - _width;
            button.move(0, _rect.height - (_value - _min) / (_max - _min) * _rect.height);
        }
    }

    public function updateValueFromButtonLocation():Void
    {
        if (_type == OStates.HORIZONTAL)
        {
            _value = clamp(Std.int(((this.mouseX - (Std.int(_height) >> 1)) / (_width - _height)) * (_max - _min) + _min));
        }
        else
        {
            _value = clamp(Std.int((_height - (Std.int(_width) >> 1) - this.mouseY) / (_height - _width) * (_max - _min) + _min));
        }
    }

    private inline function clampValue():Void
    {
        _value = clamp(_value);
    }

    private inline function clamp(value:Int):Int
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

    public function get_mouseWheelTarget():Sprite
    {
        return _mouseWheelTarget;
    }

    public function set__mouseWheelTarget(value:Sprite):Sprite
    {
        _mouseWheelTarget = value;
        return _mouseWheelTarget;
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
            invalidate();
        } return value;
    }

    public function get_value():Int
    {
        return _value;
    }

    public function set_value(value:Int):Int
    {
        value = clamp(value);

        if (_value != value)
        {
            _value = value;

            invalidate();
            onChange.dispatch(_value);
        }
        return value;
    }

    public function set_Value(value:Int):Int
    {
        value = clamp(value);

        if (_value != value)
        {
            _value = value;
            invalidate();
        }
        return value;
    }

    public function get_type():String
    {
        return _type;
    }

    public function set_type(value:String):String
    {
        if (_type != value)
        {
            _type = value;

            var styleAs = cast (_style, SliderBaseStyle);
            if (_type == OStates.VERTICAL)
            {
                _width = styleAs.defaultVWidth;
            }
            else
            {
                _width = styleAs.defaultHWidth;
            }

            if (_type == OStates.VERTICAL)
            {
                _height = styleAs.defaultVHeight;
            }
            else
            {
                _height = styleAs.defaultHHeight;
            }
            _rect = new Rectangle(0, 0, 0, 0);

            invalidate();
        }
        return _type;
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    public var styleAs(get_styleAs, null):SliderBaseStyle;

    public function get_styleAs():SliderBaseStyle
    {
        return cast(_style, SliderBaseStyle);
    }

    override public function get_styleId():String
    {
        return SliderBaseStyle.styleString;
    }

}

class SliderBaseStyle extends OBaseBackgroundStyle
{
    public static var styleString:String = "SliderBaseStyle";

    public var buttonStyle:SliderButtonStyle;

    public var defaultVHeight:Float;
    public var defaultVWidth:Float;

    public var defaultHHeight:Float;
    public var defaultHWidth:Float;

    public var defaultType:String;

    public var defaultStep:Int;
    public var defaultValue:Int;

    public var defaultMax:Float;
    public var defaultMin:Float;

    public function new()
    {
        super();
        styleID = styleString;

        defaultStep = 10;
        defaultValue = 0;
        defaultMax = 100;
        defaultMin = 0;
        defaultType = OStates.HORIZONTAL;
        defaultValue = 50;

        defaultVWidth = 10;
        defaultHHeight = 10;
        defaultVHeight = 120;
        defaultHWidth = 120;
    }

    override public function initStyle(value:IOComponent):Void
    {
        super.initStyle(value);

        var styleAs = cast (value, Slider);

        if (value._width == defaultWidth && value._height == defaultHeight)
        {
            if (defaultType == OStates.VERTICAL)
            {
                value._width = defaultVWidth;
            }
            else
            {
                value._width = defaultHWidth;
            }

            if (defaultType == OStates.VERTICAL)
            {
                value._height = defaultVHeight;
            }
            else
            {
                value._height = defaultHHeight;
            }
        }
    }

}