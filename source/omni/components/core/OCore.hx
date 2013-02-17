package omni.components.core;

import nme.display.DisplayObjectContainer;
import com.eclecticdesignstudio.motion.MotionPath.IComponentPath;
import omni.components.core.signals.OCoreEvent;
import omni.components.core.signals.OSignalMouse;
import nme.system.System;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.signals.OSignalType;
//import omni.components.core.signals.OSignal;

import nme.Lib;
import nme.display.Sprite;
import nme.display.Stage;

/**
* Components Core
* @description The Base class for all components created, only one instance can be created
*
**/
class OCore
{

	private function new( ):Void
	{
//todo cpp bug paramaters ? 
#if flash
		haxe.Log.trace = trace;
#end
	}

	private var id:Int = 0;
	public var getNextID(getID, null):Int;

	public function getID( ):Int
	{
		return id++;
	}

	public static var instance(getInstance, null):OCore;

	private static function getInstance( ):OCore
	{
		if( instance == null )
		{
			instance = new OCore();
		}
		return instance;
	}

	public var stage(get_stage, null):Stage;

//todo managers
//	public var timer:TimerManager;
//	public var inputs:InputManager;
//	public var onStageMouseDown:FlashSignal<MouseEvent>;
	public var onStageResize:OCoreEvent;
	public var enterframe:OCoreEvent;
	public var onStageMouseMove:OSignalMouse;
	public var onStageMouseLeave:OCoreEvent;
	public var onStageMouseUp:OSignalMouse;

	public var trackTheme:Bool;
//causes lag in games, better suited for apps
	public var updateAfterEvent:Bool = true;

	public var onThemeChange:OSignalType<Void -> Void>;

	public var defaultTheme:OTheme;

	public var disableScrolling:Bool = false;

//todo put theme id per component
	public var storedThemes:Hash<OTheme>;

	public function init( theme:Class<OTheme>, trackTheme:Bool = true ):Void
	{
		defaultTheme = Type.createInstance( theme, [] );
		this.trackTheme = trackTheme;

		onThemeChange = new OSignalType();
		onStageMouseMove = new OSignalMouse(OSignalMouse.MOVE, stage);
		onStageMouseUp = new OSignalMouse(OSignalMouse.UP, stage);
		onStageMouseLeave = new OCoreEvent(OCoreEvent.MOUSE_LEAVE, stage);
		enterframe = new OCoreEvent(OCoreEvent.ENTER_FRAME, stage);
		onStageResize = new OCoreEvent(OCoreEvent.RESIZE, stage);

	}

	public function changeTheme( theme:Class<OTheme> ):Void
	{
		defaultTheme.destroy( );
		defaultTheme = null;
		defaultTheme = Type.createInstance( theme, [] );
		onThemeChange.dispatch( );
		System.gc( );
	}

	public function addTheme( theme:Class<OTheme> ):Void
	{
		var themeInstance = Type.createInstance( theme, [] );
		storedThemes.set( "test", themeInstance );
	}

	public function getTheme( id:String ):OTheme
	{
		var themeInstance = storedThemes.get( id );
		return themeInstance;
	}

	public static var parentDisplayObject:DisplayObjectContainer;

	public static function addChild( component:IOComponent, ?parent:DisplayObjectContainer ):IOComponent
	{
		if( parent == null )
			parentDisplayObject = Lib.current.stage;

		parentDisplayObject.addChild( component.sprite );
		return component;
	}

	public static function removeChild( component:IOComponent, ?parent:DisplayObjectContainer ):IOComponent
	{
		if( parent == null )
			parent = parentDisplayObject;

		if( component.sprite.parent == parent )
		{
			parent.removeChild( component.sprite );
		}
		return component;
	}

	public function get_stage( ):Stage
	{
		return Lib.current.stage;
	}

	public static function log( arg:Dynamic, ?info:haxe.PosInfos ):Void
	{
		nme.Lib.trace( "Log : " + arg );
		nme.Lib.trace( "  at " + info.fileName + ":" + info.lineNumber + " in method " + info.methodName );
	}

	public static function error( arg:Dynamic, ?info:haxe.PosInfos ):Void
	{
		nme.Lib.trace( "[Error : " + arg + "]" );
		nme.Lib.trace( "  at " + info.fileName + ":" + info.lineNumber + " in method " + info.methodName );
	}

	private static function trace( v:Dynamic, ?infos:haxe.PosInfos )
	{
		nme.Lib.trace( v + infos );
	}

}
