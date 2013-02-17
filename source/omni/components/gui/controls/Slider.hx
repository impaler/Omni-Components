package omni.components.gui.controls;

import omni.components.gui.controls.ScrollBarButton.ScrollBarButtonStyle;
import omni.utils.UtilNumbers;
import omni.components.gui.controls.Slider;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IStyle;
import omni.components.core.signals.OSignalType;
import omni.components.core.signals.OCoreEvent;
import omni.components.core.signals.OSignalMouse;
import omni.components.style.OBackgroundStyle;
import omni.components.core.OCore;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.OComponent;
import omni.components.core.OButtonBase;
import omni.utils.ComponentUtils;

import nme.display.Sprite;
import nme.geom.Rectangle;
import nme.events.Event;
import nme.events.MouseEvent;

class Slider extends OComponent
{
	public static var VERTICALLY:Int = 0;
	public static var HORIZONTALLY:Int = 1;

	public var step:Int = 10;

	public var button:OButtonBase;

	public var value(get_value, set_value):Int;
	public var _value:Int = 30;

	public var tempValue:Int = 0;

	public var type(get_type, set_type):Int;
	public var _type:Int = 0;

	public var max(get_max, set_max):Float;
	public var _max:Float = 100;

	public var min(get_min, set_min):Float;
	public var _min:Float = 0;

	private var _rect:Rectangle;

	private var buttonClick:Bool = false;

	public var mouseMove:OSignalMouse;
	public var mouseWheel:OSignalMouse;
	public var mouseDown:OSignalMouse;
	public var mouseUp:OSignalMouse;

	public var onChange(default, null):OSignalType<Int -> Void>;

//todo broken in html5
	private var _mouseWheelTarget(default, setMouseWheelTarget):Sprite;

//***********************************************************
//                  Component Core
//***********************************************************

	override public function createMembers( ):Void
	{
		_rect = new Rectangle();

		onChange = new OSignalType<Int -> Void>();
		mouseWheel = new OSignalMouse (OSignalMouse.WHEEL, this.sprite);
		mouseDown = new OSignalMouse (OSignalMouse.DOWN, this.sprite);
		mouseUp = OCore.instance.onStageMouseUp;
		mouseMove = OCore.instance.onStageMouseMove;

		var thisStyle = cast(_style, SliderBaseStyle);
		button = new OButtonBase(thisStyle.buttonStyle);
		add( button );

		sprite.buttonMode = true;
	}

	override public function enableSignals( ):Void
	{
		button.mouseDown.add( handleButtonDown );
		mouseWheel.add( handleMouseWheel );
		mouseDown.add( handleMouseDown );
	}

	override public function disableSignals( ):Void
	{
		button.mouseDown.remove( handleButtonDown );
		mouseDown.remove( handleMouseDown );
		mouseWheel.remove( handleMouseWheel );
	}

	override public function destroy( ):Void
	{
		mouseWheel.destroy( );
		mouseDown.destroy( );

		mouseMove.remove( handleMouseMove );
		mouseUp.remove( handleMouseUp );
		button.mouseDown.remove( handleButtonDown );
		OCore.instance.onStageMouseLeave.remove( handleLeftStage );

		super.destroy( );
	}

//***********************************************************
//                  Event Handlers
//***********************************************************

	public function handleMouseMove( ?e:OSignalMouse ):Void
	{
		updateValueOnMouseMove( );

		if( OCore.instance.updateAfterEvent )
			e.updateAfterEvent( );
	}

	public function handleMouseDown( ?e:OSignalMouse ):Void
	{
		button.handleMouseDown( e );

		updateButtonLocationFromDown( );
		updateValueFromButtonLocation( );

		button.startDrag( false, _rect );

		mouseMove.add( handleMouseMove );
		mouseUp.add( handleMouseUp );
	}

	public function handleButtonDown( e:OSignalMouse ):Void
	{
		buttonClick = true;
		OCore.instance.onStageMouseLeave.add( handleLeftStage );
	}

	public function handleMouseUp( ?e:OSignalMouse ):Void
	{
		button.handleMouseUp( e );
		button.stopDrag( );

		mouseUp.remove( handleMouseUp );
		mouseMove.remove( handleMouseMove );

		updateValueFromButtonLocation( );

		onChange.dispatch( value );
	}

	public function handleMouseWheel( ?e:OSignalMouse ):Void
	{
		value += (e.delta > 0 ? step : - step);
		e.updateAfterEvent( );
	}

	public function handleLeftStage( e:OCoreEvent ):Void
	{
		handleMouseUp( );
	}

//***********************************************************
//                  Component Methods
//***********************************************************

	public function updateButtonLocationFromDown( ):Void
	{
		if( buttonClick == false )
		{
			if( _type == HORIZONTALLY )
			{
				var maxlocation = Math.min( this.width - button.width, this.mouseX - button.width / 2 );
				button.x = UtilNumbers.clamp( (this.mouseX - button.width / 2), 0, maxlocation );
			}

			if( _type == VERTICALLY )
			{
				var maxlocation = Math.min( this.height - button.height, this.mouseY - button.height / 2 );
				button.y = UtilNumbers.clamp( (this.mouseY - button.height / 2), 0, maxlocation );
			}
		}
		buttonClick = false;
	}

	public function updateValueOnMouseMove( ):Void
	{
		tempValue = _value;

		if( _type == Slider.HORIZONTALLY )
		{
			tempValue = clamp( Std.int( button.x / (_width - _height) * (_max - _min) + _min ) );
		}
		else
		{
			tempValue = clamp( Std.int( (_height - _width - button.y) / (_height - _width) * (_max - _min) + _min ) );
		}

		if( _value != tempValue )
		{
			_value = tempValue;
			onChange.dispatch( _value );
		}
	}

	override public function drawMembers( ):Void
	{
		refreshButton( );
		super.drawMembers( );
	}

	public function refreshButton( ):Void
	{
		if( _type == Slider.HORIZONTALLY )
		{
			button._height = _height;
			button._width = _height;
			_rect.width = _width - _height;
			button.move( (_value - _min) / (_max - _min) * _rect.width, 0 );
		}
		else
		{
			button._height = _width;
			button._width = _width;
			_rect.height = _height - _width;
			button.move( 0, _rect.height - (_value - _min) / (_max - _min) * _rect.height );
		}
	}

	public function updateValueFromButtonLocation( ):Void
	{
		if( _type == Slider.HORIZONTALLY )
		{
			_value = clamp( Std.int( ((this.mouseX - (Std.int( _height ) >> 1)) / (_width - _height)) * (_max - _min) + _min ) );
		}
		else
		{
			_value = clamp( Std.int( (_height - (Std.int( _width ) >> 1) - this.mouseY) / (_height - _width) * (_max - _min) + _min ) );
		}
	}

	private function clampValue( ):Void
	{
		_value = clamp( _value );
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

	public function get_mouseWheelTarget( ):Sprite
	{
		return _mouseWheelTarget;
	}

	public function setMouseWheelTarget( value:Sprite ):Sprite
	{
		_mouseWheelTarget = value;
		return _mouseWheelTarget;
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
			invalidate( );
		} return value;
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

			invalidate( );
			onChange.dispatch( _value );
		}
		return value;
	}

	public function set_Value( value:Int ):Int
	{
		value = clamp( value );

		if( _value != value )
		{
			_value = value;
			invalidate( );
		}
		return value;
	}

	public function get_type( ):Int
	{
		return _type;
	}

	public function set_type( value:Int ):Int
	{
		if( _type != value )
		{
			_type = value;

			var styleAs = cast (_style, SliderBaseStyle);
			if( _type == Slider.VERTICALLY )
			{
				_width = styleAs.defaultVWidth;
			}
			else
			{
				_width = styleAs.defaultHWidth;
			}

			if( _type == Slider.VERTICALLY )
			{
				_height = styleAs.defaultVHeight;
			}
			else
			{
				_height = styleAs.defaultHHeight;
			}
			_rect = new Rectangle(0, 0, 0, 0);

			invalidate( );
		}
		return _type;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return SliderBaseStyle.styleString;
	}

}

class SliderBaseStyle extends OBackgroundStyle
{
	public static var styleString:String = "SliderBaseStyle";

	public var buttonStyle:OButtonBaseStyle;

	public var defaultVHeight:Float;
	public var defaultVWidth:Float;

	public var defaultHHeight:Float;
	public var defaultHWidth:Float;

	public var defaultType:Int;

	public var defaultStep:Int;
	public var defaultValue:Int;
	private var defaultMax:Float;
	private var defaultMin:Float;

	public function new( )
	{
		super( );
		styleID = styleString;

		defaultType = 0;
		defaultStep = 10;
		defaultValue = 0;
		defaultMax = 100;
		defaultMin = 0;
	}

	override public function initStyle( value:IOComponent ):Void
	{
		super.initStyle( value );

		var styleAs = cast (value, Slider);

		styleAs._type = defaultType;
		styleAs.step = defaultStep;
		styleAs._value = defaultValue;
		styleAs._max = defaultMax;
		styleAs._min = defaultMin;

		if( value._width == defaultWidth && value._height == defaultHeight )
		{
			if( defaultType == Slider.VERTICALLY )
			{
				value._width = defaultVWidth;
			}
			else
			{
				value._width = defaultHWidth;
			}

			if( defaultType == Slider.VERTICALLY )
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