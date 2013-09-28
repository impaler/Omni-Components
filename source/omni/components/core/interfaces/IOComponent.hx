package omni.components.core.interfaces;

import flash.display.Sprite;

/**
 * IComponent
 * 
 * @description The base interface for all component types
 * 
 */
interface IOComponent #if haxe3 extends #else implements #end IDestroyable
{

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    /**
* The base display object of the component
**/
    public var sprite(get_sprite, null):Sprite;
    private function get_sprite( ):Sprite;

    /**
* The string that describes the current component state
* Eg Disabled, Enabled etc
**/
    public var state(get_state, set_state):String;
    public var _state:String;
    private function set_state( value:String ):String;
    private function get_state( ):String;

    /**
* Method to set the active state of a component
* State on active, off active etc
**/
    public function setActiveState( ):Void;

    /**
* The components style object required by all components to draw
**/
    public var style(get_style, set_style):IStyle;
    private var _style:IStyle;
    private function set_style( value:IStyle ):IStyle;
    private function get_style( ):IStyle;
    public function setStyleClass( value:Class<IStyle> ):IStyle;

    /**
* The components styleID used to get the appropriate IStyle
**/
    public var styleId(get_styleId, null):String;
    public function get_styleId( ):String;

    /**
* The place where a component style is initiated
**/
    public function initStyle (style:IStyle = null):Void;

    /**
* The invalid flag to mark the component to be drawn
**/
    public var invalid:Bool;

    /**
* Mark the component to be drawn after a change
**/
    public function invalidate (recursive:Bool = true):Void;

    /**
* Draw the component asap
**/
    function drawNow(recursive:Bool = true):Void;

    /**
* The main draw function of each component
**/
    public function draw ():Void;

    /**
* The function called when the default theme is changed in core
**/
    public function onThemeChange( ):Void;

    /**
* Track the Theme changes or not
**/
    public var trackTheme(default, set_trackTheme):Bool;
    public function set_trackTheme (value:Bool):Bool;

    /**
* Let the component change theme based on the core default changes
**/
    public function startTrackingTheme( ):Void;

    /**
* Stop the component change theme based on the core default changes
**/
    public function stopTrackingTheme( ):Void;

    /**
* The core signal for when a component's dimensions have changed
**/
    //	public var onResize:OSignal<Void->Void>;

    /**
* Array of child components
**/
    public var members:Array <IOComponent>;

    public var parentComponent:IOComponent;

    public function add (comp:IOComponent):IOComponent;
    public function addType(comp:Class<IOComponent>, ?style:IStyle = null):Dynamic;
    public function addFirst (comp:IOComponent):IOComponent;
    public function addAt (comp:IOComponent, index:Int):IOComponent;
    public function getMemberIndex (comp:IOComponent):Int;

    public function addToMembers (comp:IOComponent):IOComponent;
    public function coreAdd(comp:IOComponent):IOComponent;

    public function remove(comp:IOComponent):Void;

    //***********************************************************
    //                  Overridables
    //***********************************************************

    /**
* The suggested place to create the component display objects etc
**/
    public function createMembers ():Void;

    /**
* The function to override to update the child object of a component
**/
    public function drawMembers ():Void;

    /**
* The suggested place for where Events are enabled
**/
    public function enableSignals ():Void;

    /**
* The suggested place for where Events are disabled
**/
    public function disableSignals ():Void ;

    //***********************************************************
    //                  Dimensions / Positions
    //***********************************************************

    /**
* The base x dimension of a component
**/
    public var x(get_x, set_x):Float;
    private function set_x( value:Float ):Float;
    private function get_x( ):Float;

    /**
* The base y dimension of a component
**/
    public var y(get_y, set_y):Float;
    private function set_y( value:Float ):Float;
    private function get_y( ):Float;

    /**
* Move the component
**/
    public function move (x:Float, y:Float):Void;

    /**
* The base height dimension of a component
**/
    public var height(get_height, set_height):Float;
    private function set_height( value:Float ):Float;
    private function get_height( ):Float;

    /**
* The base height dimension without invalidation
**/
    public var _height(default, set__height):Float;
    private function set__height( value:Float ):Float;

    /**
* The base width dimension of a component
**/
    public var width(get_width, set_width):Float;
    private function set_width( value:Float ):Float;
    private function get_width( ):Float;

    /**
* The base width dimension without invalidation
**/
    public var _width(default, set__width):Float;
    private function set__width( value:Float ):Float;

    public var minWidth:Float;
    public var maxWidth:Float;

    public var minHeight:Float;
    public var maxHeight:Float;

    /**
* Resize the component
**/
    public function size (w:Float, h:Float):Void;

    /**
* Resize without invalidation
**/
    public function _size( w:Float, h:Float ):Void;

    /**
* Basic padding value for simple layouts
**/
    public var padding(get_padding, set_padding):Float;
    private function set_padding( value:Float ):Float;
    private function get_padding( ):Float;

    /**
* Basic padding value without invalidation
**/
    public var _padding(default, set__padding):Float;
    private function set__padding( value:Float ):Float;

    //***********************************************************
    //                  Debug
    //***********************************************************

    //	/**
    //	* Draw count is a debug util to check how many times a component has been drawn
    //	**/
    //	public var drawCount(default, setdrawCount):Int = 0;
    //	public function setdrawCount( value:Int ):Int;
}
