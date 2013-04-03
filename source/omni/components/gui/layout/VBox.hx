package omni.components.gui.layout;

import omni.components.core.interfaces.IOComponent;
import omni.utils.OStates;
import omni.components.core.OLayout;
import omni.components.core.OLayout.OLayoutStyle;

class VBox extends OLayout
{
    override public function draw():Void
    {
        var last:Float = 0;
        for (i in 0...members.length)
        {
            var current = cast (members[i], IOComponent);

            current.y = last;
            last = (current.y + current.height);
            if (i != members.length - 1) last += padding;

            if (_hAlign == OStates.LEFT)
            {
                current.x = _leftPadding;
            }
            else if (_hAlign == OStates.MIDDLE)
            {
                current.x = (width * .5) - (current.width * .5);
            }
            else if (_hAlign == OStates.RIGHT)
            {
                current.x = (width - _rightPadding ) - current.width;
            }
        }

        if (_vAlign == OStates.TOP)
        {
            target.y = _topPadding;
        }
        else if (_vAlign == OStates.MIDDLE)
        {
            target.y = ((height * .5) - (contentHeight * .5) + topPadding);
        }
        else if (_vAlign == OStates.BOTTOM)
        {
            target.y = (height - contentHeight) + topPadding;
        }

        super.draw();
    }

    override public function get_height():Float
    {
        if (_heightSizeMethod == OStates.AUTO)
        {
            calculateHeight();
            return set__height(contentHeight);
        }
        else
        {
            return super.get_height();
        }
    }

    override public function get_width():Float
    {
        if (_widthSizeMethod == OStates.AUTO)
        {
            calculateWidest();
            return set__width(widestMember);
        }
        else
        {
            return super.get_width();
        }
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return VBoxStyle.styleString;
    }
}

class VBoxStyle extends OLayoutStyle
{
    public static var styleString:String = "VBoxStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }

}