package omni.components.core;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.core.OContainer.OContainerStyle;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.utils.OStates;

import nme.display.Sprite;
import nme.geom.Rectangle;

class OLayout extends OContainer
{

//***********************************************************
//                  Style Variables
//***********************************************************

	public var _verticalHAlign:String;
	public var _horizontalVAlign:String;
	public var _direction:String;

	public var direction(default, set_direction):String;
	
//***********************************************************
//                  Public Variables
//***********************************************************

	public var highestMember:Int;
	public var widestMember:Int;

	public var horizontalVAlign(get_horizontalVAlign, set_horizontalVAlign):String;

	public var verticalHAlign(get_verticalHAlign, set_verticalHAlign):String;

//***********************************************************
//                  Component Overrides
//***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        highestMember = 0;
        widestMember = 0;
        target = this.sprite;

        _horizontalVAlign = styleAsOLayoutStyle.defaultHorizontalVAlign;
        _verticalHAlign = styleAsOLayoutStyle.defaultVerticalHAlign;
        _direction = styleAsOLayoutStyle.defaultDirection;

    }

    override public function add(comp:IOComponent):IOComponent
    {
        super.add(comp);

        comp.drawNow();
        invalidate(false);

        calculateHighest();
        calculateWidest();

        return comp;
    }

    override public function draw():Void
    {
        var last:Float = padding;

        for (i in 0...members.length)
        {
            var current = cast (members[i], IOComponent);

            if (_direction == OStates.HORIZONTAL)
            {
                current.x = last;
                if (i == 0)current.x += current.padding;
                last = current.x + current.width + padding + current.padding;

                if (_horizontalVAlign == OStates.MIDDLE)
                {
                    current.y = ((highestMember * .5) - (current.height * .5));
	                
                } else if (_horizontalVAlign == OStates.TOP)
                {
                    current.y = 0;

                } else if (_horizontalVAlign == OStates.BOTTOM)
                {
                    current.y = highestMember - current.height;
                }
            }
            else if (_direction == OStates.VERTICAL)
            {
                current.y = last;
                if (i == 0)current.y += current.padding;
                last = (current.y + current.height) + current.padding + padding;

                if (_verticalHAlign == OStates.LEFT)
                {
                    current.x = 0;
                } else if (_verticalHAlign == OStates.MIDDLE)
                {
                    current.x = ((widestMember * .5) - (current.width * .5));

                } else if (_verticalHAlign == OStates.RIGHT)
                {
                    current.x = widestMember - current.width;
                }
            }
        }

        super.draw();
    }

//***********************************************************
//                  Component Methods
//***********************************************************

    public inline function calculateHighest():Int
    {
    //todo avoid loop on add
        var heights = [];

        for (i in 0...members.length)
        {
            var current = cast (members[i], IOComponent);
            heights.push(current.height + current.padding * 2);
        }

        var last = 0;

        for (i in 0...heights.length)
        {
            if (heights[i] > last)
                last = Std.int(heights[i]);
        }

        highestMember = last;

        return last;
    }

    public inline function calculateWidest():Int
    {
        var widths = [];

        for (i in 0...members.length)
        {
            var current = cast (members[i], IOComponent);
            widths.push(current.width + (current.padding * 2) + padding * 2);
        }

        var last = 0;

        if (_direction == OStates.VERTICAL)
        {
            for (i in 0...widths.length)
            {
                if (widths[i] > last)
                    last = Std.int(widths[i]);
            }
        }

        widestMember = last;

        return last;
    }

    public function validateHorizontalVAlign(value:String):Bool
    {
        var validAlignments:Array<String>;
        validAlignments = [OStates.TOP, OStates.MIDDLE, OStates.BOTTOM];
        if (Lambda.exists(validAlignments, function(alignment)
        { return alignment == value; }))
        {
            return true;
        } else
        {
            throwAlignmentError(validAlignments, value);
            return false;
        }
    }

    public function validateVerticalHAlign(value:String):Bool
    {
        var validAlignments:Array<String>;
        validAlignments = [OStates.LEFT, OStates.MIDDLE, OStates.RIGHT];
        if (Lambda.exists(validAlignments, function(alignment)
        { return alignment == value; }))
        {
            return true;
        } else
        {
            throwAlignmentError(validAlignments, value);
            return false;
        }
    }

    private inline function throwAlignmentError(validItems:Array<String>, value:String):Void
    {
        var errorMessage = "The HorizontalVAlign value :: " + value + " :: is invalid please use one of ";
        for (o in validItems)
        {
            errorMessage += " :: " + o;
        }
        throw errorMessage + " ::";
    }

//***********************************************************
//                  Properties
//***********************************************************

    public function set_horizontalVAlign(value:String):String
    {
        if (value != _horizontalVAlign && validateHorizontalVAlign(value))
        {
            _horizontalVAlign = value;
            invalidate();
        }

        return _horizontalVAlign;
    }

    public function get_horizontalVAlign():String
    {
        return _horizontalVAlign;
    }

    public function set_verticalHAlign(value:String):String
    {
        if (value != _verticalHAlign && validateVerticalHAlign(value))
        {
            _verticalHAlign = value;
            invalidate();
        }

        return _verticalHAlign;
    }

    public function get_verticalHAlign():String
    {
        return _verticalHAlign;
    }

    override public function get_height():Float
    {
        if (!_scrollRectEnabled)
        {
            var last = 0;

            for (i in 0...members.length)
            {
                var current = cast (members[i], IOComponent);
                if (_direction == OStates.HORIZONTAL)
                {
                    last = highestMember;
                }
                else
                {
                    var paddingValue = padding + current.padding;

                    if (i == (members.length - 1))
                    {
                        paddingValue += padding + current.padding;
                    }

                    last = Std.int(last + current.height + paddingValue);
                }
            }

            return set__height(last);
        }
        else
        {
            return super.get_height();
        }
    }

    override public function get_width():Float
    {
    //todo cache values on add/remove
        if (!_scrollRectEnabled)
        {
            var last:Float = 0;

            if (_direction == OStates.VERTICAL)
            {
                last = widestMember;
            }

            if (_direction == OStates.HORIZONTAL)
            {
                for (i in 0...members.length)
                {
                    var current = cast (members[i], IOComponent);
                    last += current.width + (current.padding * 2);
                }
                last += (padding * members.length + padding);
            }

            return set__width(last);
        }
        else
        {
            return super.get_width();
        }
    }

    public function set_direction(value:String):String
    {
        _direction = value;
        invalidate();

        return _direction;
    }

//***********************************************************
//                  Component Style
//***********************************************************

    private var styleAsOLayoutStyle(get_styleAsOLayoutStyle, null):OLayoutStyle;

    private function get_styleAsOLayoutStyle( ):OLayoutStyle
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
    public var defaultHorizontalVAlign:String;
    public var defaultVerticalHAlign:String;

    public function new()
    {
        super();
        styleID = styleString;

        defaultDirection = OStates.VERTICAL;
        defaultVerticalHAlign = OStates.MIDDLE;
        defaultHorizontalVAlign = OStates.MIDDLE;
    }

}


