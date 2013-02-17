package omni.components.core;

import omni.components.style.OBaseStyle;
import omni.utils.UtilNumbers;
import omni.utils.ComponentUtils;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.signals.OCoreEvent;
import omni.components.core.signals.OSignalType;
import omni.components.style.OBackgroundStyle;

import nme.events.Event;
import nme.display.Sprite;
import nme.geom.Rectangle;

class OComponent implements IOComponent
{

//***********************************************************
//                  Component Core
//***********************************************************

	public function new( style:IStyle = null )
	{
		compId = OCore.instance.getNextID;
		createComponentMembers( );
		initStyle( style );
		createMembers( );
		if( style == null )
			startTrackingTheme( );
		enableSignals( );

		sprite.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
	}

	public function createComponentMembers( ):Void
	{
		sprite = new Sprite();
		onResize = new OCoreEvent(OCoreEvent.RESIZE, this.sprite);
		components = [];
	}

	public function onAddedToStage( e:Event ):Void
	{
		sprite.removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
		invalidate( );
//		OCore.log("Added to stage");
	}

	public var sprite(get_sprite, null):Sprite;

	private function get_sprite( ):Sprite
	{
		return sprite;
	}

	public var state(get_state, set_state):String;
	public var _state:String = null;

	private function set_state( value:String ):String
	{
		if( value != this._state )
		{
			this._state = value;
			invalidate( );
		}
		return _state;
	}

	private function get_state( ):String
	{
		return _state;
	}

	public function setActiveState( ):Void
	{
		this._state = OStates.ACTIVE;
		invalidate( );
	}

	public var style(get_style, set_style):IStyle;
	private var _style:IStyle;

	public function setStyleClass( value:Class<IStyle> ):IStyle
	{
		var styleInstance = Type.createInstance( value, [] );
		this.style = styleInstance;
		return this.style;
	}

	private function set_style( value:IStyle ):IStyle
	{
		if( this._style != value )
		{
			stopTrackingTheme( );
			initStyle( value );
			invalidate( );
			return this._style;
		}
		else
		{
			return null;
		}
	}

	private function get_style( ):IStyle
	{
		return this._style;
	}

	public var styleId(get_styleId, null):String;

	public function initStyle( style:IStyle = null ):Void
	{
		if( this._style != null )
		{
			this._style.destroy( );
			this._style = null;
		}
		if( style == null )
		{
			this._style = OCore.instance.defaultTheme.getStyle( this.styleId );
		}
		else
		{
			this._style = style;
		}
		this._style.initStyle( this );
	}

	public var invalid:Bool;

	public function invalidate( recursive:Bool = true ):Void
	{
		if( ! this.invalid )
		{
			this.invalid = true;
			ORenderManager.instance.addToRenderList( this );

		}
//todo is this handled in style
		if( components.length > 0 && recursive )
		{
			for( i in 0...components.length )
			{
				var o = cast (components[i], IOComponent);
				o.invalidate( );
			}
		}
	}

	public function drawNow( recursive:Bool = true ):Void
	{
		this.invalid = true;
		draw( );

		if( components.length > 0 && recursive )
		{
			for( i in 0...components.length )
			{
				var o = cast (components[i], IOComponent);
				o.drawNow( );
			}
		}
	}

	public function draw( ):Void
	{
		coreDraw( );
	}

	public function coreDraw( ):Void
	{
		if( ! this.invalid )
			return;

		if( this._style != null )
		{
			this._style.update( this );
		}

		drawMembers( );

		drawCount++;

		this.invalid = false;
	}

	public function onThemeChange( ):Void
	{
		initStyle( );
		invalidate( );
	}

	public var trackTheme(default, set_trackTheme):Bool;

	public function set_trackTheme( value:Bool ):Bool
	{
		if( value != this.trackTheme )
		{
			this.trackTheme = value;
			this.trackTheme ? startTrackingTheme( ) : stopTrackingTheme( );
		}

		return this.trackTheme;
	}

	public var trackingTheme:Bool = false;

	public function startTrackingTheme( ):Void
	{
		if( ! this.trackingTheme )
		{
			OCore.instance.onThemeChange.add( onThemeChange );
			trackingTheme = true;
		}
	}

	public function stopTrackingTheme( ):Void
	{
		if( this.trackTheme )
		{
			OCore.instance.onThemeChange.remove( onThemeChange );

//todo
//			var styleType = Type.getClass(this._style);
//			this._style = Type.createInstance(styleType, []);
//			this.trackTheme = false;
		}
	}

	public var onResize:OCoreEvent;

	public var components:Array <IOComponent>;

	public function add( comp:IOComponent ):IOComponent
	{
		this.components.push( comp );
		this.sprite.addChild( comp.sprite );
		return comp;
	}

	public function remove( comp:IOComponent ):Void
	{
		this.components.remove( comp );
		this.sprite.removeChild( comp.sprite );
	}

	private var _listening:Bool = false;

//***********************************************************
//                  Overridables
//***********************************************************

	public function createMembers( ):Void
	{
//override me
	}

	public function drawMembers( ):Void
	{
//override me
	}

	public function enableSignals( ):Void
	{
		if( ! _listening )
		{
//override me
			_listening = true;
		}
	}

	public function disableSignals( ):Void
	{
		if( _listening )
		{
//override me
			_listening = false;
		}
	}

//***********************************************************
//                  Dimensions / Positions
//***********************************************************

	public var x(get_x, set_x):Float;

	public function set_x( value:Float ):Float
	{
		return x = sprite.x = (value);
	}

	function get_x( ):Float
	{
		return sprite.x;
	}

	public var y(get_y, set_y):Float;

	function get_y( ):Float
	{
		return sprite.y;
	}

	public function set_y( value:Float ):Float
	{
		return y = sprite.y = (value);
	}

	public function move( x:Float, y:Float ):Void
	{
		set_x( x );
		set_y( y );
	}

	public var height(get_height, set_height):Float;
	public var _height(default, set__height):Float = 0;

	private function set_height( h:Float ):Float
	{
		if( _height != h )
		{
			set__height( h );
			invalidate( );
			onResize.dispatch( );
		}
		return _height;
	}

	private function get_height( ):Float
	{
		return _height;
	}

	private function set__height( h:Float ):Float
	{
		if( _height != h )
		{
			h = UtilNumbers.clamp( h, _style.minHeight, _style.maxHeight );
			_height = (h);
		}
		return _height;
	}

	public var width(get_width, set_width):Float;
	public var _width(default, set__width):Float = 0;

	public function set_width( w:Float ):Float
	{
		if( _width != w )
		{
			set__width( w );
			invalidate( );
			onResize.dispatch( );
		}
		return _width;
	}

	public function set__width( w:Float ):Float
	{
		if( _width != w )
		{
			w = UtilNumbers.clamp( w, this._style.minWidth, this._style.maxWidth );
			_width = (w);
		}
		return _width;
	}

	public function get_width( ):Float
	{
		return _width;
	}

	public function size( w:Float, h:Float ):Void
	{
		_size( w, h );
		invalidate( );
	}

	public function _size( w:Float, h:Float ):Void
	{
		_width = UtilNumbers.clamp( w, this._style.minWidth, this._style.maxWidth );
		_height = UtilNumbers.clamp( h, this._style.minHeight, this._style.maxHeight );
	}

	public var padding(get_padding, set_padding):Float;
	public var _padding(default, set__padding):Float = 0;

	private function set_padding( value:Float ):Float
	{
		if( _padding != value )
		{
			set__padding( value );
			invalidate( );
			onResize.dispatch( );
		}
		return _padding;
	}

	private function get_padding( ):Float
	{
		return _padding;
	}

	private function set__padding( value:Float ):Float
	{
		if( _padding != value )
		{
			_padding = Math.round( value );
		}
		return _padding;
	}

	public var buttonMode(get_buttonMode, set_buttonMode):Bool;

	public function set_buttonMode( b:Bool ):Bool
	{
#if flash
		//todo new native flash api for cursors
		sprite.buttonMode = b;
#elseif js
		sprite.useHandCursor = b;
#end
//todo cpp desktop use displayobject

		return b;
	}

	public function get_buttonMode( ):Bool
	{
#if flash
		return sprite.buttonMode;
#elseif js
		return sprite.useHandCursor;
#else
return false;
#end
	}

	public function startDrag( lockCenter:Bool = false, ?bounds:Rectangle ):Void
	{
		sprite.startDrag( false, bounds );
	}

	public function stopDrag( ):Void
	{
		sprite.stopDrag( );
	}

	public var mouseX(get_mouseX, null):Float;

	private function get_mouseX( ):Float
	{
		return sprite.mouseX;
	}

	public var mouseY(get_mouseY, null):Float;

	private function get_mouseY( ):Float
	{
		return sprite.mouseY;
	}

	public function destroy( ):Void
	{
		if( components.length > 0 )
		{
			for( o in components )
			{
				var comp = cast(o, IOComponent);
				comp.destroy( );
				comp = null;
			}
			components = null;
		}
//todo
////		_style.destroy();
		_style = null;

		if( sprite.parent != null )
			sprite.parent.removeChild( sprite );

		sprite = null;

		onResize.destroy( );
		stopTrackingTheme( );
	}

	public var visible(default, set_visible):Bool;

	public function set_visible( v:Bool ):Bool
	{
		sprite.visible = v;
		return sprite.visible;
	}

	public var alpha(default, set_alpha):Float;

	public function set_alpha( a:Float ):Float
	{
		sprite.alpha = a;
		return sprite.alpha;
	}

//***********************************************************
//                  Debug
//***********************************************************

	public var compId(default, null):Int;

	public var drawCount(default, set_drawCount):Int = 0;

	public function set_drawCount( value:Int ):Int
	{
		drawCount = value;
//				OCore.log("ID:" + compId + " : " +this.styleId + " :DRAWCOUNT: " + drawCount);
		return drawCount;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	public function get_styleId( ):String
	{
		return ComponentStyle.styleString;
	}

}

class ComponentStyle extends OBackgroundStyle
{
	public static var styleString:String = "ComponentStyle";

	public static var STATE_OVER:String = "STATE_OVER";
	public static var STATE_DOWN:String = "STATE_DOWN";

	public function new( )
	{
		super( );
		styleID = styleString;
	}

}