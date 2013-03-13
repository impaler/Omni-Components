package omni.components.gui.controls;

import nme.events.TimerEvent;
import nme.utils.Timer;
import omni.utils.signals.OSignalInt;
import omni.utils.signals.OSignalVoid;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IBrush;
import nme.display.Sprite;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.components.core.OComponent;
import omni.utils.signals.OSignalType;

class ProgressBar extends OComponent
{

//***********************************************************
//                  Public Variables
//***********************************************************

	public var onComplete:OSignalVoid;
	public var onProgress:OSignalInt;

	public var value(get_value, set_value):Int;
	public var _value:Int = 0;

	public var progressImage:OComponent;

//***********************************************************
//                  Component Methods
//***********************************************************

    public function startTestMode( interval:Int ):Void
    {
        var timer = new Timer(interval, 0);
        timer.addEventListener( TimerEvent.TIMER, handleTimer );
        timer.start( );
    }

//***********************************************************
//                  Component Overrides
//***********************************************************

	override public function createMembers( ):Void
	{
		super.createMembers( );

		onComplete = new OSignalVoid();
		onProgress = new OSignalInt();

		progressImage = new OComponent();
		add( progressImage );
	}

	override public function drawMembers( ):Void
	{
		_value = _value > 100 ? 100 : _value;
		_value = _value < 0 ? 0 : _value;

		progressImage._width = (_width * _value) * 0.01;
		progressImage._height = _height;
	}

//***********************************************************
//                  Properties
//***********************************************************

	public function set_value( v:Int ):Int
	{
		if( _value != v )
		{
			_value = v;

			invalidate( );

			if( _value >= 100 )
			{
				onComplete.dispatch;
			}
			else
			{
				onProgress.dispatch( _value );
			}
		}
		return _value;
	}

	public function get_value( ):Int
	{
		return _value;
	}

//***********************************************************
//                  Event Handlers
//***********************************************************

	public function handleTimer( e:TimerEvent ):Void
	{
		this.value = this.value + 1;
		if( this.value == 100 ) this.value = 0;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return ProgressBarStyle.styleString;
	}
}

class ProgressBarStyle extends OBaseBackgroundStyle
{
	public static var styleString:String = "ProgressBarStyle";

	public var progress:IBrush;

	public function new( )
	{
		super( );
		styleID = styleString;
	}

	public function setProgressBrush( value:IBrush ):Void
	{
		progress = cast ( value, IBrush);
	}

	override public function update( value:IOComponent ):Void
	{
		if( progress != null )
			progress.update( value );

		super.update( value );
	}

	override public function destroy( ):Void
	{
		if( progress != null )
		{
			progress.destroy( );
			progress = null;
		}
		super.destroy( );
	}

}
