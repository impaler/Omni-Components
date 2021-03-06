package omni.components.gui.controls;

import omni.utils.signals.OSignalT;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.utils.signals.OSignalMouse;
import omni.utils.signals.OSignal;
import omni.utils.OStates;
import omni.components.gui.layout.list.List;
import omni.components.gui.layout.list.ListItem;
import omni.components.gui.layout.HBox;
import omni.components.gui.layout.VBox;
import omni.components.core.OComponentButton;
import omni.components.core.OLayout;
import omni.components.core.OCore;

import flash.geom.Point;

class SelectList extends OComponentButton
{

    public var listOpen:Bool;
    public var listContainer:List;
    public var list:OLayout;

    public var selectedSoloItem:ListItem;
    public var selectedItems:Array<ListItem>;

    public var multipleSelections:Bool;

    public var onChange:OSignalT<SelectList>;


    override public function createMembers():Void
    {
        super.createMembers();

        listOpen = false;

        var layoutstyle = styleAsSelectListStyle;

        if (layoutstyle.defaultListLayoutStyle.defaultDirection == null)
            throw "ListStyle requires a defaultDirection of OStates.HORIZONTAL or OStates.VERTICAL";

        if (layoutstyle.defaultListLayoutStyle.defaultDirection == OStates.HORIZONTAL)
        {
            list = new HBox(styleAsSelectListStyle.defaultListLayoutStyle);
        }
        else if (layoutstyle.defaultListLayoutStyle.defaultDirection == OStates.VERTICAL)
        {
            list = new VBox(styleAsSelectListStyle.defaultListLayoutStyle);
        }

        listContainer = new List();
        listContainer.add(list);


    }

    override public function add(comp:IOComponent):IOComponent
    {
        return list.add(comp);
    }


    override public function addType(comp:Class<IOComponent>, ?style:IStyle = null):IOComponent
    {
        return list.addType(comp, style);
    }


    override public function handleMouseDown(?e:OSignalMouse):Void
    {
        listOpen ? closeList() : openList();

        super.handleMouseDown(e);
    }


    public function openList():Void
    {
        listOpen = true;

        OCore.instance.popupsLayer.addChild(listContainer.sprite);
        var pos = this.sprite.localToGlobal(new Point(OCore.instance.popupsLayer.x, OCore.instance.popupsLayer.y));
        listContainer.move(pos.x, pos.y + height);
    }

    public function closeList():Void
    {
        listOpen = false;

        OCore.instance.popupsLayer.removeChild(listContainer.sprite);
    }


    //***********************************************************
    //                  Component Style
    //***********************************************************

    private var styleAsSelectListStyle(get_styleAsSelectListStyle, null):SelectListStyle;

    private function get_styleAsSelectListStyle():SelectListStyle
    {
        return cast(_style, SelectListStyle);
    }

    override public function get_styleId():String
    {
        return SelectListStyle.styleString;
    }
}

class SelectListStyle extends OComponentButtonStyle
{
    public static var styleString:String = "SelectListStyle";

    public var defaultListLayoutStyle:OLayoutStyle;

    public function new()
    {
        super();
        styleID = styleString;
    }
}