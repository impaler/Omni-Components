package omni.components.gui.controls;

import omni.components.core.signals.OSignalMouse;
import omni.components.core.OCore;
import nme.events.TimerEvent;
import nme.utils.Timer;
import omni.components.core.OButtonBase;
import omni.components.core.signals.OSignalType;
import omni.components.core.OLayout;
import flash.display.Bitmap;
import omni.components.gui.controls.ScrollBarButton.ScrollBarButtonStyle;
import omni.components.style.OBaseStyle;
import omni.components.core.OComponent;

class ScrollBar extends OComponent
{
	public var increaseButton:ScrollBarButton;
	public var decreaseButton:ScrollBarButton;
	
	private var _increasing:Bool;
	private var _timer:Timer;
	private var _delay:Float;

	public var scrollSlider:ScrollSlider;

	public var enableScrollButtons:Bool;
	public var enableScrollSlider:Bool;

	public var type(get_type, set_type):Int;
	public var _type:Int;

	public var sliderStep(default, set_sliderStep):Int;
	public var _sliderStep:Int;
	
	public var buttonStep:Int;
	
	public var value(get_value, set_value):Int;
	public var _value:Int;

	public var max(get_max, set_max):Float;
	public var _max:Float;

	public var min(get_min, set_min):Float;
	public var _min:Float;

	public var _realSize:Int;
	public var contentSize(default, set_contentSize):Int;
	public var pageSize(default, set_pageSize):Int;

	public var onChange(default, null):OSignalType<Int -> Void>;

//***********************************************************
//                  Component Core
//***********************************************************

	override public function createMembers( ):Void
	{
		onChange = new OSignalType<Int -> Void>();

		_sliderStep = 10;
		buttonStep = 30;
		_delay = 20;
		enableScrollButtons = true;
		enableScrollSlider = true;
		_max = 100;
		_min = 0;
		_realSize = 0;
		contentSize = 0;
		pageSize = 0;

		if( enableScrollSlider )
			createScrollSlider( );

		if( enableScrollButtons )
			createScrollButtons( );
	}

	override public function enableSignals( ):Void
	{
//		super.enableSignals( );

		if( ! _listening )
		{
			scrollSlider.onChange.add( handleOnChange );

			increaseButton.onClick.add( handleOnIncrease );
			decreaseButton.onClick.add( handleOnDecrease );

			_listening = true;
		}
	}

	override public function disableSignals( ):Void
	{
//		super.disableSignals( );

		if( _listening )
		{
			scrollSlider.onChange.add( handleOnChange );

//		increaseButton.onClick.add( handleOnChange );
//		decreaseButton.onClick.add( handleOnChange );

			_listening = false;
		}
	}

	override public function drawMembers( ):Void
	{
		super.drawMembers( );

		scrollSlider.width = width - (increaseButton.width + decreaseButton.width);
		scrollSlider.height = height  - (increaseButton.height + decreaseButton.height);

		if( _type == Slider.VERTICALLY )
		{
			increaseButton._width = width;
			decreaseButton._width = width;
			increaseButton.y = height-increaseButton.height;
			scrollSlider.y = decreaseButton.height;
		}
		else
		{
			increaseButton._height = _height;
			decreaseButton._height = _height;
			increaseButton.x = width-increaseButton.width;
			scrollSlider.x = decreaseButton._width;
		}

	}

//***********************************************************
//                  Event Handlers
//***********************************************************

	public function handleOnChange( value:Int ):Void
	{
		set_value(value);
	}
	
	public function handleOnIncrease( ?button:OButtonBase ):Void
	{
		_increasing = true;
		set_value(_value + buttonStep);
		OCore.instance.onStageMouseUp.add(handleStageUp);
		
		_timer.delay = _delay;
		_timer.start( );
	}
	
	public function handleOnDecrease( ?button:OButtonBase ):Void
	{
		_increasing = false;
		set_value(_value - buttonStep);
		OCore.instance.onStageMouseUp.add(handleStageUp);
		
//		_timer.reset( );
		_timer.delay = _delay;
		_timer.start( );
	}
	
	public function handleStageUp( ?m:OSignalMouse ):Void
	{
		_timer.stop( );
		_timer.delay = 100;
	}
	
	public function handleTimerTick( ?t:TimerEvent ):Void
	{
		_increasing ? set_value(_value + buttonStep) : set_value(_value - buttonStep);
		_timer.delay = _delay;
	}
	
//***********************************************************
//                  Component Methods
//***********************************************************

	public function refreshButton( ):Void
	{
		scrollSlider._value = _value;
		scrollSlider.refreshButton();
//		scrollSlider.updateValueOnMouseMove();
		
		
	}

	public function createScrollButtons( ):Void
	{
		increaseButton = new ScrollBarButton();
//		increaseButton.step = _step;
		add( increaseButton );

		decreaseButton = new ScrollBarButton();
//		decreaseButton.step = _step;
		add( decreaseButton );
		
		_timer = new Timer(100);
		_timer.addEventListener( TimerEvent.TIMER, handleTimerTick );

	}

	public function createScrollSlider( ):Void
	{
		scrollSlider = new ScrollSlider();
		scrollSlider.step = _sliderStep;
		scrollSlider._min = _min;
		scrollSlider._max = _max;
		scrollSlider._value = _value;
		add( scrollSlider );

	}

	private function clamp( value:Int ):Int
	{
		if( _max > _min )
		{
			if( value > Std.int( _max ) )value = Std.int( _max );
			if( value < Std.int( _min ) )value = Std.int( _min );
		}
		else
		{
			value = Std.int( _max );
			_min = _max;
		}
		return value;
	}

//***********************************************************
//                  Properties
//***********************************************************

	public function set_sliderStep( value:Int ):Int
	{
		if( _sliderStep != value )
		{
			_sliderStep = value;
			if( scrollSlider != null )
				scrollSlider.step = _sliderStep;
		}
		return _sliderStep;
	}

	public function set_type( value:Int ):Int
	{
		if( _type != value )
		{
			_type = value;
			if( scrollSlider != null )
				scrollSlider.type = _type;
			invalidate( );
		}
		return _type;
	}

	public function get_type( ):Int
	{
		return _type;
	}

	public function get_value( ):Int
	{
		return _value;
	}

	public function set_value( value:Int ):Int
	{
		value = clamp( value );

		if( _value != value )
		{
			_value = value;

			if( scrollSlider != null )
				scrollSlider._value = _value;

			invalidate( );
			onChange.dispatch( _value );
		}
		return value;
	}

	private function get_max( ):Float
	{
		return _max;
	}

	private function set_max( value:Float ):Float
	{
		if( _max != value )
		{
			_max = value;

			if( scrollSlider != null )
				scrollSlider._max = _max;

			invalidate( );
		}
		return value;
	}

	private function get_min( ):Float
	{
		return _min;
	}

	private function set_min( value:Float ):Float
	{
		if( _min != value )
		{
			_min = value;

			if( scrollSlider != null )
				scrollSlider._min = _min;

			invalidate( );
		} return value;
	}

	public var barNeeded(getBarNeeded, setBarNeeded):Bool;

	public function setBarNeeded( value:Bool ):Bool
	{
		barNeeded = value;

		if( scrollSlider != null )
			scrollSlider.barNeeded = barNeeded;

		return barNeeded;
	}

	public function getBarNeeded( ):Bool
	{
		_max = Math.max( contentSize - pageSize, 0 );

		if( _max > 0 )
		{
			return true;
		}
		else
		{
			return false;
		}
	}

	public function set_contentSize( value:Int ):Int
	{
		if( contentSize != value )
		{
			contentSize = value;
			if( scrollSlider != null )
				scrollSlider.contentSize = contentSize;
		}
		return value;
	}

	public function set_pageSize( value:Int ):Int
	{
		if( pageSize != value )
		{
			pageSize = value;
			if( scrollSlider != null )
				scrollSlider.pageSize = pageSize;
		}
		return value;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return ScrollBarStyle.styleString;
	}

}

class ScrollBarStyle extends OBaseStyle
{
	public static var styleString:String = "ScrollLayoutBarsStyle";

	public var horizontalBar:ScrollBarButtonStyle;
	public var verticalBar:ScrollBarButtonStyle;

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}