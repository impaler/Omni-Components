package omni.components.gui.controls;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.core.OContainer;
import omni.utils.signals.OSignalInt;
import omni.utils.signals.OSignal;
import omni.components.style.base.OBaseBackgroundStyle;

import flash.events.TimerEvent;
import flash.utils.Timer;

class ProgressBar extends OComponent
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var onComplete:OSignal;
    public var onProgress:OSignalInt;

    public var value(get_value, set_value):Int;
    public var _value:Int = 0;

    public var progressImage:OContainer;

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public function startTestMode(interval:Int):Void
    {
        var timer = new Timer(interval, 0);
        timer.addEventListener(TimerEvent.TIMER, handleTimer);
        timer.start();
    }

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        onComplete = new OSignal();
        onProgress = new OSignalInt();

        var sty = cast(_style, ProgressBarStyle );
        progressImage = new OContainer(sty.progress);
        add(progressImage);
    }

    override public function drawMembers():Void
    {
        _value = _value > 100 ? 100 : _value;
        _value = _value < 0 ? 0 : _value;

        progressImage._width = (_width * _value) * 0.01;
        progressImage._height = _height;
        progressImage.drawNow();
    }

    //***********************************************************
    //                  Properties
    //***********************************************************

    public function set_value(v:Int):Int
    {
        if (_value != v)
        {
            _value = v;

            invalidate();

            if (_value >= 100)
            {
                onComplete.dispatch();
            }
            else
            {
                onProgress.dispatch(_value);
            }
        }
        return _value;
    }

    public function get_value():Int
    {
        return _value;
    }

    //***********************************************************
    //                  Event Handlers
    //***********************************************************

    public function handleTimer(e:TimerEvent):Void
    {
        this.value += 1;
        if (this.value == 100) this.value = 0;
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return ProgressBarStyle.styleString;
    }
}

class ProgressBarStyle extends OBaseBackgroundStyle
{
    public static var styleString:String = "ProgressBarStyle";

    public var progress:OContainerStyle;

    public function new()
    {
        super();
        styleID = styleString;
    }

}
