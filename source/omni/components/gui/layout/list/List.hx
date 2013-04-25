package omni.components.gui.layout.list;

import omni.components.core.interfaces.IOComponent;
import omni.components.gui.layout.window.Window;
import omni.components.core.OContainer.OContainerStyle;
import omni.components.core.OContainer;
import omni.components.core.OLayout;
import omni.utils.OStates;

class List extends Window
{

    //public var layout:OLayout;

    override public function createMembers():Void
    {
        super.createMembers();

        //var layoutstyle = styleAsListStyle;
        //
        //if (layoutstyle.defaultDirection == null)
        //    throw "ListStyle requires a defaultDirection of OStates.HORIZONTAL or OStates.VERTICAL";
        //
        //if (layoutstyle.defaultDirection == OStates.HORIZONTAL)
        //{
        //    layout = new HBox(styleAsListStyle.defaultLayoutStyle);
        //}
        //else if (layoutstyle.defaultDirection == OStates.VERTICAL)
        //{
        //    layout = new VBox(styleAsListStyle.defaultLayoutStyle);
        //}
        //
        //coreAdd(layout);
        //
        //members = layout.members;
    }

    //override public function add(comp:IOComponent):IOComponent
    //{
    //    return layout.add(comp);
    //}

    //***********************************************************
    //                  Component Style
    //***********************************************************

    private var styleAsListStyle(get_styleAsListStyle, null):ListStyle;

    private function get_styleAsListStyle():ListStyle
    {
        return cast(_style, ListStyle);
    }

    override public function get_styleId():String
    {
        return ListStyle.styleString;
    }
}

class ListStyle extends OContainerStyle
{
    public static var styleString:String = "ListStyle";

    //public var defaultLayoutStyle:OLayoutStyle;
    //public var defaultDirection:String;

    public function new()
    {
        super();
        styleID = styleString;
    }
}