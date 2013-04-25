package omni.components.core;

import omni.components.core.interfaces.IStyle;
import omni.utils.signals.OCoreEvent;
import omni.utils.signals.OSignalMouse;
import omni.components.core.interfaces.IOComponent;
import omni.utils.signals.OSignalType;
import omni.utils.OStates;

import nme.system.System;
import nme.display.DisplayObjectContainer;
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

    private function new():Void
    {
        //todo cpp bug paramaters ?
        #if flash
		haxe.Log.trace = trace;
        #end
    }

    public var coreComponentsLayer:Sprite;
    public var debugLayer:Sprite;
    public var popupsLayer:Sprite;
    public var windowsLayer:Sprite;

    private var id:Int = 0;
    public var getNextID(get_getNextID, null):Int;

    public function get_getNextID():Int
    {
        return id++;
    }

    public static var instance(get_instance, null):OCore;

    private static function get_instance():OCore
    {
        if (instance == null)
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
    public var updateAfterEvent:Bool = false;

    public var onThemeChange:OSignalType<Void -> Void>;

    public var defaultTheme:OTheme;

    public var disableScrolling:Bool = false;

    //todo put theme id per component

    #if haxe3
    public var storedThemes:Map<String, OTheme>;
	#else
    public var storedThemes:Hash<OTheme>;
    #end

    public function init(theme:Class<OTheme>, trackTheme:Bool = true):Void
    {
        defaultTheme = initTheme(theme);
        this.trackTheme = trackTheme;

        onThemeChange = new OSignalType();
        onStageMouseMove = new OSignalMouse(OSignalMouse.MOUSE_MOVE, stage);
        onStageMouseUp = new OSignalMouse(OSignalMouse.MOUSE_UP, stage);
        onStageMouseLeave = new OCoreEvent(OCoreEvent.MOUSE_LEAVE, stage);
        enterframe = new OCoreEvent(OCoreEvent.ENTER_FRAME, stage);
        onStageResize = new OCoreEvent(OCoreEvent.RESIZE, stage);

        debugLayer = new Sprite();
        popupsLayer = new Sprite();
        windowsLayer = new Sprite();
        coreComponentsLayer = new Sprite();

        stage.addChild(coreComponentsLayer);
        stage.addChild(windowsLayer);
        stage.addChild(popupsLayer);
        stage.addChild(debugLayer);
    }

    public function initTheme(theme:Class<OTheme>):OTheme
    {
        var themeInstance = cast( Type.createInstance(theme, []), OTheme);
        themeInstance.initTheme();

        return themeInstance;
    }

    public function changeDefaultTheme(theme:Class<OTheme>):Void
    {
        if (defaultTheme != null)
        {
            defaultTheme.destroy();
            defaultTheme = null;
        }
        defaultTheme = initTheme(theme);
        onThemeChange.dispatch();
    }

    public function addTheme(theme:Class<OTheme>):Void
    {
        var themeInstance = Type.createInstance(theme, [null]);
        storedThemes.set("test", themeInstance);
    }

    public function getTheme(id:String):OTheme
    {
        var themeInstance = storedThemes.get(id);
        return themeInstance;
    }

    public static var parentDisplayObject:DisplayObjectContainer;

    public static function addChild(component:IOComponent, ?parent:DisplayObjectContainer):IOComponent
    {
        if (parent == null)
            parentDisplayObject = OCore.instance.coreComponentsLayer;

        parentDisplayObject.addChild(component.sprite);

        //if (parent == null && OCore.instance.debugLayer != null)
        //coreComponentsLayer.setChildIndex(OCore.instance.debugLayer, Lib.current.stage.numChildren - 1);
        return component;
    }

    public static function addChildType(component:Class<IOComponent>, ?style:IStyle, ?parent:DisplayObjectContainer):IOComponent
    {
        var comp = Type.createInstance(component, [style]);

        return addChild(comp);
    }

    public static function removeChild(component:IOComponent, ?parent:DisplayObjectContainer):IOComponent
    {
        if (parent == null)
            parent = parentDisplayObject;

        if (component.sprite.parent == parent)
        {
            parent.removeChild(component.sprite);
        }
        return component;
    }

    public function get_stage():Stage
    {
        return Lib.current.stage;
    }

    public static function log(arg:Dynamic, ?info:haxe.PosInfos):Void
    {
        nme.Lib.trace("Log : " + arg);
        nme.Lib.trace("  at " + info.fileName + ":" + info.lineNumber + " in method " + info.methodName);
    }

    public static function error(arg:Dynamic, ?info:haxe.PosInfos):Void
    {
        nme.Lib.trace("[Error : " + arg + "]");
        nme.Lib.trace("  at " + info.fileName + ":" + info.lineNumber + " in method " + info.methodName);
    }

    private static function trace(v:Dynamic, ?infos:haxe.PosInfos)
    {
        nme.Lib.trace(v + infos);
    }

}
