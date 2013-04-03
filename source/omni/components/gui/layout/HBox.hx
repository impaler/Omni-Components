package omni.components.gui.layout;

import omni.utils.OStates;
import omni.utils.OStates;
import omni.components.core.OLayout;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OLayout.OLayoutStyle;

class HBox extends OLayout
{

    override public function draw():Void
    {
        var last:Float = 0;
        for (i in 0...members.length)
        {
            var current = cast (members[i], IOComponent);

            current.x = last;
            last = (current.x + current.width);
            if (i != members.length - 1) last += padding;

            if (_vAlign == OStates.TOP)
            {
                current.y = _topPadding;
            }
            else if (_vAlign == OStates.MIDDLE)
            {
                current.y = (height * .5) - (current.height * .5);
            }
            else if (_vAlign == OStates.BOTTOM)
            {
                current.y = (height - bottomPadding) - current.height;
            }
        }

        if (_hAlign == OStates.LEFT)
        {
            target.x = _leftPadding;
        }
        else if (_hAlign == OStates.MIDDLE)
        {
            target.x = ((width * .5) - (contentWidth * .5)) + leftPadding;
        }
        else if (_hAlign == OStates.RIGHT)
        {
            target.x = (width - contentWidth) + leftPadding;
        }

        super.draw();
    }

    override public function get_height():Float
    {
        if (_heightSizeMethod == OStates.AUTO)
        {
            calculateHighest();
            return set__height(highestMember);
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
            calculateWidth();
            return set__width(contentWidth);
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
        return HBoxStyle.styleString;
    }

}

class HBoxStyle extends OLayoutStyle
{
    public static var styleString:String = "HBoxStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}