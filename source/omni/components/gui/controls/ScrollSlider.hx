package omni.components.gui.controls;

import omni.components.core.OCore;
import omni.utils.OStates;
import omni.utils.signals.OSignalMouse;
import omni.components.gui.controls.Slider.SliderBaseStyle;

import flash.geom.Rectangle;

class ScrollSlider extends Slider
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    #if haxe3 @:isVar #end public var contentSize(default, set_contentSize):Int = 0;
    #if haxe3 @:isVar #end public var pageSize(default, set_pageSize):Int = 0;

    public var minSize(get_minSize, set_minSize):Int;
    public var _minSize:Int = 0;

    #if haxe3 @:isVar #end public var barNeeded(get_barNeeded, set_barNeeded):Bool;

    public var _realSize:Int = 0;

    private var _working:Bool = true;

    //***********************************************************
    //                  Event Handlers
    //***********************************************************

    override public function handleMouseMove(?e:OSignalMouse):Void
    {
        super.handleMouseMove(e);
    }

    override public function handleMouseDown(?e:OSignalMouse):Void
    {
        button.handleMouseDown(e);

        updateButtonLocationFromDown();
        updateValueFromButtonLocation();

        button.startDrag(false, _rect);
        onMouseMove.add(handleMouseMove);
        onMouseUp.add(handleMouseUp);
    }

    override public function handleMouseUp(?e:OSignalMouse):Void
    {
        button.handleMouseUp(e);
        button.stopDrag();

        updateValueOnMouseMove();

        onMouseUp.remove(handleMouseUp);
        onMouseMove.remove(handleMouseMove);
    }

    override public function handleMouseWheel(?e:OSignalMouse):Void
    {
	    _wheelScrollSpeed = 4;
	    _wheelValue = e.delta * _wheelScrollSpeed;

	    if (_type != OStates.HORIZONTAL)
	    {
		    if (e.delta > 0)
		    {
			    if( _wheelValue >= _wheelScrollSpeed) value += -step;
		    }
		    else
		    {
			    if( _wheelValue <= -_wheelScrollSpeed) value += step;
		    }
	    }
	    else
	    {
		    if (e.delta > 0)
		    {
			    if( _wheelValue >= _wheelScrollSpeed) value -= -step;
		    }
		    else
		    {
			    if( _wheelValue <= -_wheelScrollSpeed) value -= step;
		    }
	    }

	    _wheelValue = 0;

	    if (OCore.instance.updateAfterEvent)
		    e.updateAfterEvent();
    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    override public function refreshButton():Void
    {
        _max = Math.max(contentSize - pageSize, 0);

        if (_max > 0)
        {
            barNeeded = true;

            if (_type == OStates.HORIZONTAL)
            {
                _realSize = Std.int((pageSize * _width) / (_max + pageSize));
                button._size(Math.max(_realSize, _minSize), _height);
                _rect.width = Math.ceil(_width - button.width);
                button.x = _value / _max * _rect.width;
                if (button.x + button.width > _width) button.x = _width - button.width;
            }
            else
            {
                _realSize = Std.int((pageSize * _height) / (_max + pageSize));
                button._size(_width, Math.max(_realSize, _minSize));
                _rect.height = Math.ceil(_height - button.height);
                button.y = _value / _max * _rect.height;
                if (button.y + button.height > _height) button.y = _height - button.height;
            }
            _working = true;
        }
        else
        {
            barNeeded = false;
            _value = 0;
            _rect.width = 0;
            _rect.height = 0;
            button.move(0, 0);
            button._size(0, 0);
            _working = false;
        }
    }

    override public function updateValueOnMouseMove():Void
    {
        _tempValue = _value;

        if (_type == OStates.HORIZONTAL)
        {
            _tempValue = clamp(Math.ceil(button.sprite.x / _rect.width * _max));
        }
        else
        {
            _tempValue = clamp(Math.ceil(button.sprite.y / _rect.height * _max));
        }

        if (_value != _tempValue)
        {
            _value = _tempValue;
            onChange.dispatch(_value);
        }
    }

    override public function updateValueFromButtonLocation():Void
    {
        _tempValue = _value;

        if (_type == OStates.HORIZONTAL)
        {
            _tempValue = Math.ceil(button.x / _rect.width * _max);
        }
        else
        {
            _tempValue = Math.ceil(button.y / _rect.height * _max);
        }

        if (_value != _tempValue)
        {
            _value = _tempValue;
            onChange.dispatch(_value);
        }
    }

    public function set_barNeeded(value:Bool):Bool
    {
        barNeeded = value;
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
        }
        return value;
    }

    public function set_pageSize(value:Int):Int
    {
        if (pageSize != value)
        {
            pageSize = value;
        }
        return value;
    }

    public function set_minSize(value:Int):Int
    {
        if (_minSize != value)
        {
            _minSize = value;
        }
        return _minSize;
    }

    public function get_minSize():Int
    {
        return _minSize;
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return ScrollSliderStyle.styleString;
    }

}

class ScrollSliderStyle extends SliderBaseStyle
{
    public static var styleString:String = "ScrollBarStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }

}