package omni.components.gui.layout.list;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.OContainer.OContainerStyle;
import omni.components.core.OContainer;
import omni.components.core.OLayout;
import omni.utils.OStates;

class List extends OContainer
{

    public var layout:OLayout;
    public var direction:String;

    override public function createMembers():Void
    {
        super.createMembers();

        direction = OStates.VERTICAL;

        layout = new OLayout();
        layout.direction = direction;
        coreAdd(layout);

        members = layout.members;
    }

    override public function add(comp:IOComponent):IOComponent
    {
        layout.add(comp);
    }

    public function setDirection(directionValue:String):Void
    {
        if (direction != directionValue)
        {
            direction = directionValue;

            if (layout != null)
            {
                layout.direction = direction;
            }
        }

    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return ListStyle.styleString;
    }
}

class ListStyle extends OContainerStyle
{
    public static var styleString:String = "ListStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}