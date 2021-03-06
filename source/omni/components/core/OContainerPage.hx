package omni.components.core;

import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OContainer;
import omni.components.core.OComponent;
import omni.components.gui.layout.containers.PagedContainer;
import omni.components.gui.controls.TabButton;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.utils.signals.OSignalT;

class OContainerPage extends OComponent
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var onClosed:OSignalT<OContainerPage>;
    public var onOpened:OSignalT<OContainerPage>;

    public var title(get_title, set_title):String;
    public var _title:String;

    public var parentContainer:PagedContainer;
    public var pageButton:TabButton;

    public var container:OContainer;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        onClosed = new OSignalT<OContainerPage>();
        onOpened = new OSignalT<OContainerPage>();

        var type = styleAsContainerPageStyle.defaultContainerType;
        setContainerType(type);

    }

    override public function add(comp:IOComponent):IOComponent
    {
        container.add(comp);
        return comp;
    }

    override public function addType(comp:Class<IOComponent>, ?style:IStyle = null):IOComponent
    {
        var compInstance = Type.createInstance(comp, [style]);
        container.add(compInstance);
        return compInstance;
    }

    override public function drawMembers():Void
    {
        super.drawMembers();

        if (container != null)
        {
            container._width = width;
            container._height = height;
            container.drawNow();
        }
    }

    override public function enableSignals():Void
    {
        if (!_listening)
        {
            if (container != null)
            {
                container.enableSignals();
            }
            _listening = true;
        }
    }

    override public function disableSignals():Void
    {
        if (_listening)
        {
            if (container != null)
            {
                container.disableSignals();
            }
            _listening = false;
        }
    }

    override public function destroy():Void
    {
        onClosed.destroy();
        onOpened.destroy();
        if (container != null)
            container.destroy();
        super.destroy();
    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public function setContainer(type:OContainer):OContainer
    {
        container = type;
        container.scrollRectEnabled = true;
        coreAdd(container);
        return container;
    }

    public function setContainerType(type:Class<OContainer>):OContainer
    {
        var containerInstance = Type.createInstance(type, [null]);
        setContainer(containerInstance);
        return containerInstance;
    }

    //***********************************************************
    //                  Properties
    //***********************************************************

    public function get_title():String
    {
        if (_title == null)
        {
            _title = Std.string(compId);
        }
        return _title;
    }

    public function set_title(value:String):String
    {
        if (_title == null)
        {
            _title = value;
        }
        return _title;
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    private var styleAsContainerPageStyle(get_styleAsContainerPageStyle, null):OContainerPageStyle;

    private function get_styleAsContainerPageStyle():OContainerPageStyle
    {
        return cast(_style, OContainerPageStyle);
    }

    override public function get_styleId():String
    {
        return OContainerPageStyle.styleString;
    }
}

class OContainerPageStyle extends OBaseBackgroundStyle
{

    public static var styleString:String = "OContainerPageStyle";

    public var defaultContainerType:Class<OContainer>;

    public function new()
    {
        super();
        styleID = styleString;
    }
}
