package omni.components.gui.controls;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.core.OCore;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.signals.OSignalType;
import omni.components.core.OTextBase;
import omni.components.core.OButtonBase;
import omni.components.gui.text.Label;
import omni.components.style.OBackgroundStyle;
import omni.utils.ComponentUtils;

import nme.utils.Timer;
import nme.events.TimerEvent;
import nme.events.MouseEvent;

class NumericStepper extends OComponent
{
	public var step:Int;

	public var value(get_value, set_value):Int;
	public var _value:Int;

	public var max(get_max, set_max):Int;
	public var _max:Int;

	public var min(get_min, set_min):Int;
	public var _min:Int;

	private var _increasing:Bool;
	private var _timer:Timer;
	private var _intialButtonTimerDelay:Float;
	private var _timerInterval:Float;

	public var _textBase:OTextBase;
	public var _increase:OButtonBase;
	public var _decrease:OButtonBase;

	public var onMouseWheel:OSignalMouse;
	public var onChange(default, null):OSignalType<Int -> Void>;

	override public function createMembers( ):Void
	{
//todo move to style layer
		_max = 1000;
		_min = - 10;
		_value = 0;
		step = 1;
		_intialButtonTimerDelay = 1000;
		_timerInterval = 100;

		onChange = new OSignalType();
		onMouseWheel = new OSignalMouse(OSignalMouse.WHEEL, this.sprite);

		var thisStyle = cast(_style, NumericStepperStyle);

		_textBase = new Label(thisStyle.textStyle);
		_textBase.trackTheme = false;
		add( _textBase );

		_increase = new OButtonBase(thisStyle.increaseButtonStyle);
		_increase.trackTheme = false;
		add( _increase );

		_decrease = new OButtonBase(thisStyle.decreaseButtonStyle);
		_decrease.trackTheme = false;
		add( _decrease );

		_timer = new Timer(_intialButtonTimerDelay);
		_timer.addEventListener( TimerEvent.TIMER, handleTimerTick );
	}

	override public function enableSignals( ):Void
	{
		_increase.onMouseDown.add( handleIncreaseClick );
		_decrease.onMouseDown.add( handleDecreaseClick );
		onMouseWheel.add( handleMouseWheel );
	}

	override public function disableSignals( ):Void
	{
		_increase.onMouseDown.remove( handleIncreaseClick );
		_decrease.onMouseDown.remove( handleDecreaseClick );
	}

	private function handleMouseWheel( ?e:OSignalMouse ):Void
	{
		value += (e.delta > 0 ? 1 : - 1) * step;
	}

	private function handleTimerTick( e:TimerEvent ):Void
	{
		_timer.delay = _timerInterval;
		value += _increasing ? step : - step;
	}

	private function handleIncreaseClick( ?e:OSignalMouse ):Void
	{
		value += step;
		OCore.instance.onStageMouseUp.addOnce( handleMouseUp );
		_increasing = true;
		_timer.reset( );
		_timer.start( );
	}

	private function handleDecreaseClick( ?e:OSignalMouse ):Void
	{
		value -= step;

		OCore.instance.onStageMouseUp.addOnce( handleMouseUp );
		_increasing = false;
		_timer.reset( );
		_timer.start( );
	}

	private function handleMouseUp( ?e:OSignalMouse ):Void
	{
		_timer.stop( );
		_timer.delay = 1000;
	}

	override public function draw( ):Void
	{
		super.draw( );
		_textBase.text = Std.string( value );

		updatePositions( );
	}

	public function updatePositions( ):Void
	{
		_increase._width = _height;
		_increase._height = _height * .5;

		_decrease._width = _height;
		_decrease._height = _height * .5;

		_increase.x = _width - _increase.width;
		_decrease.x = _width - _decrease.width;

		_decrease.y = _height * .5;

		ComponentUtils.VAlignToOther( _textBase, this );
	}

	public function fixValue( ):Void
	{
		if( _max > _min )
		{
			if( _value > _max )_value = _max;
			if( _value < _min )_value = _min;
		}
		else
		{
			_value = _min = _max;
		}
		_textBase.text = Std.string( _value );
	}

	public function get_value( ):Int
	{
		return _value;
	}

	public function set_value( value:Int ):Int
	{
		if( _value != value )
		{
			_value = value;
			fixValue( );
			invalidate( );
			onChange.dispatch( _value );
		}
		return _value;
	}

	public function set_max( value:Int ):Int
	{
		if( _max != value )
		{
			_max = value;
			fixValue( );
			invalidate( );
		}
		return _max;
	}

	public function get_max( ):Int
	{
		return _max;
	}

	public function set_min( value:Int ):Int
	{
		if( _min != value )
		{
			_min = value;
			fixValue( );
			invalidate( );
		}
		return _min;
	}

	public function get_min( ):Int
	{
		return _min;
	}

	override public function get_styleId( ):String
	{
		return NumericStepperStyle.styleString;
	}
}

/**
* 
* Numeric Stepper style
* 
* 
*/
class NumericStepperStyle extends OBackgroundStyle
{

	public static var styleString:String = "NumericStepperStyle";

	public var increaseButtonStyle:OButtonBaseStyle;
	public var decreaseButtonStyle:OButtonBaseStyle;
	public var textStyle:TextBaseStyle;

	public function new( )
	{
		super( );
		styleID = styleString;
	}

	override public function initStyle( value:IOComponent ):Void
	{
		super.initStyle( value );

//		var instance = cast ( value, NumericStepper);
//
//		if(instance._textBase != null)
//		{
//			var stylethis = cast ( instance.style, NumericStepperStyle);
//			instance._textBase.style = stylethis.textStyle;
//			instance._increase.style = stylethis.increaseButtonStyle;
//			instance._decrease.style = stylethis.decreaseButtonStyle;
//		}

	}

}