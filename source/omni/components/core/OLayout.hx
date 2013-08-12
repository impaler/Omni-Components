package omni.components.core;

import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.core.OContainer.OContainerStyle;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.utils.ComponentUtils;
import omni.utils.OStates;

import flash.display.Sprite;
import flash.geom.Rectangle;

class OLayout extends OContainer
{

    //***********************************************************
    //                  Style Variables
    //***********************************************************

    public var _hAlign:String;
    public var _vAlign:String;

    public var _widthSizeMethod:String;
    public var _heightSizeMethod:String;

    public var _topPadding:Int;
    public var _bottomPadding:Int;
    public var _leftPadding:Int;
    public var _rightPadding:Int;

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var highestMember:Float;
    public var widestMember:Float;

    public var highestInvalid:Bool;
    public var widestInvalid:Bool;

    public var heightSizeMethod(get_heightSizeMethod, set_heightSizeMethod):String;
    public var widthSizeMethod(get_widthSizeMethod, set_widthSizeMethod):String;

    public var hAlign(get_hAlign, set_hAlign):String;
    public var vAlign(get_vAlign, set_vAlign):String;

    public var topPadding(get_topPadding, set_topPadding):Int;
    public var bottomPadding(get_bottomPadding, set_bottomPadding):Int;
    public var leftPadding(get_leftPadding, set_leftPadding):Int;
    public var rightPadding(get_rightPadding, set_rightPadding):Int;

    private var contentWidth:Float;
    public var widthInvalid:Bool;

    private var contentHeight:Float;
    public var heightInvalid:Bool;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        contentWidth = 0;
        widthInvalid = true;

        contentHeight = 0;
        heightInvalid = true;

        highestMember = 0;
        widestMember = 0;

        highestInvalid = true;
        widestInvalid = true;

        target = new Sprite();
        sprite.addChild(target);

        _vAlign = styleAsOLayoutStyle.defaultVAlign;
        _hAlign = styleAsOLayoutStyle.defaultHAlign;

        _widthSizeMethod = styleAsOLayoutStyle.defaultWidthSizeMethod;
        _heightSizeMethod = styleAsOLayoutStyle.defaultHeightSizeMethod;

        _topPadding = styleAsOLayoutStyle.defaultTopPadding;
        _bottomPadding = styleAsOLayoutStyle.defaultBottomPadding;
        _leftPadding = styleAsOLayoutStyle.defaultLeftPadding;
        _rightPadding = styleAsOLayoutStyle.defaultRightPadding;

        if (_widthSizeMethod == OStates.FIXED || _heightSizeMethod == OStates.FIXED)
            _scrollRectEnabled = true;
    }

    override public function add(comp:IOComponent):IOComponent
    {
        super.add(comp);

        invalidateAdd();

        return comp;
    }

    override public function addType(comp:Class<IOComponent>, ?style:IStyle = null):Dynamic
    {
        var instance = super.addType(comp, style);

        invalidateAdd();

        return instance;
    }

    override public function remove(comp:IOComponent):Void
    {
        this.members.remove(comp);

        if (comp.sprite.parent == this.target)
            this.target.removeChild(comp.sprite);

        invalidateAdd();
    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public inline function invalidateAdd():Void
    {
        widthInvalid = true;
        heightInvalid = true;
        highestInvalid = true;
        widestInvalid = true;

        calculateHighest();
        calculateWidest();
        calculateWidth();
        calculateHeight();

        invalidate();
    }

    public inline function calculateWidth():Float
    {
        if (widthInvalid)
        {
            contentWidth = 0;
            for (i in 0...members.length)
            {
                var current = cast (members[i], IOComponent);
                contentWidth += current.width;
                if (i != members.length - 1)
                    contentWidth += padding;
            }

            contentWidth += (_leftPadding + _rightPadding);
            widthInvalid = false;
        }
        return contentWidth;
    }

    public inline function calculateHeight():Float
    {
        if (heightInvalid)
        {
            contentHeight = 0;
            for (i in 0...members.length)
            {
                var current = cast (members[i], IOComponent);
                contentHeight += current.height;
                if (i != members.length - 1)
                    contentHeight += padding;
            }
            contentHeight += (_bottomPadding + _topPadding);
            heightInvalid = false;
        }
        return contentHeight;
    }

    public inline function calculateHighest():Float
    {
        if (highestInvalid)
        {
            var last:Float = 0;
            for (i in 0...members.length)
            {
                var current = cast (members[i], IOComponent);
                if (current.height > last)
                    last = current.height;
            }
            highestMember = last + _bottomPadding + _topPadding;
            highestInvalid = false;
        }
        return highestMember;
    }

    public inline function calculateWidest():Float
    {
        if (widestInvalid)
        {
            var last:Float = 0;
            for (i in 0...members.length)
            {
                var current = cast (members[i], IOComponent);
                if (current.width > last)
                    last = current.width;
            }
            widestMember = last + _leftPadding + _rightPadding;
            widestInvalid = false;
        }
        return widestMember;
    }

    public function validateVAlign(value:String):Bool
    {
        var validAlignments:Array<String>;
        validAlignments = [OStates.TOP, OStates.MIDDLE, OStates.BOTTOM];
        if (Lambda.exists(validAlignments, function(alignment)
        { return alignment == value; }))
        {
            return true;
        }
        else
        {
            ComponentUtils.throwAlignmentError(validAlignments, value);
            return false;
        }
    }

    public function validateHAlign(value:String):Bool
    {
        var validAlignments:Array<String>;
        validAlignments = [OStates.LEFT, OStates.MIDDLE, OStates.RIGHT];

        if (Lambda.exists(validAlignments, function(alignment)
        { return alignment == value; }))
        {
            return true;
        }
        else
        {
            ComponentUtils.throwAlignmentError(validAlignments, value);
            return false;
        }
    }

    //***********************************************************
    //                  Properties
    //***********************************************************

    public function set_heightSizeMethod(value:String):String
    {
        if (value != _heightSizeMethod)
        {
            if (value == OStates.FIXED)
            {
                _scrollRectEnabled = true;
            }
            _heightSizeMethod = value;
            invalidate();
        }
        return _heightSizeMethod;
    }

    public function get_heightSizeMethod():String
    {
        return _heightSizeMethod;
    }

    public function set_widthSizeMethod(value:String):String
    {
        if (value != _widthSizeMethod)
        {
            if (value == OStates.FIXED)
            {
                _scrollRectEnabled = true;
            }
            _widthSizeMethod = value;
            invalidate();
        }
        return _widthSizeMethod;
    }

    public function get_widthSizeMethod():String
    {
        return _widthSizeMethod;
    }

    public function set_hAlign(value:String):String
    {
        if (value != _hAlign && validateHAlign(value))
        {
            _hAlign = value;
            invalidate();
        }
        return _hAlign;
    }

    public function get_hAlign():String
    {
        return _hAlign;
    }

    public function set_vAlign(value:String):String
    {
        if (value != _vAlign && validateVAlign(value))
        {
            _vAlign = value;
            invalidate();
        }
        return _hAlign;
    }

    public function get_vAlign():String
    {
        return _vAlign;
    }

    public function set_rightPadding(value:Int):Int
    {
        if (value != _rightPadding)
        {
            _rightPadding = value;
            invalidateAdd();
        }
        return _rightPadding;
    }

    public function get_rightPadding():Int
    {
        return _rightPadding;
    }

    public function set_leftPadding(value:Int):Int
    {
        if (value != _leftPadding)
        {
            _leftPadding = value;
            invalidateAdd();
        }
        return _leftPadding;
    }

    public function get_leftPadding():Int
    {
        return _leftPadding;
    }

    public function set_bottomPadding(value:Int):Int
    {
        if (value != _bottomPadding)
        {
            _bottomPadding = value;
            invalidateAdd();
        }
        return _bottomPadding;
    }

    public function get_bottomPadding():Int
    {
        return _bottomPadding;
    }

    public function set_topPadding(value:Int):Int
    {
        if (value != _topPadding)
        {
            _topPadding = value;
            invalidateAdd();
        }
        return _topPadding;
    }

    public function get_topPadding():Int
    {
        return _topPadding;
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    private var styleAsOLayoutStyle(get_styleAsOLayoutStyle, null):OLayoutStyle;

    private function get_styleAsOLayoutStyle():OLayoutStyle
    {
        return cast(_style, OLayoutStyle);
    }

    override public function get_styleId():String
    {
        return OLayoutStyle.styleString;
    }
}

class OLayoutStyle extends OContainerStyle
{
    public static var styleString:String = "OLayoutStyle";

    public var defaultDirection:String;

    public var defaultVAlign:String;
    public var defaultHAlign:String;

    public var defaultTopPadding:Int;
    public var defaultBottomPadding:Int;
    public var defaultLeftPadding:Int;
    public var defaultRightPadding:Int;

    public var defaultWidthSizeMethod:String;
    public var defaultHeightSizeMethod:String;

    public function new()
    {
        super();
        styleID = styleString;
    }
}


