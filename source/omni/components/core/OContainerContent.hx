package omni.components.core;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IStyle;
import omni.components.core.OCore;
import omni.components.core.OComponent;
import omni.components.gui.layout.containers.PagedContainer;
import omni.components.core.OContainer;
import omni.components.core.OLayout;

import flash.display.Sprite;

class OContainerContent extends OContainer
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var container:OContainer;
    public var currentLayout:OLayout;
    public var paged:PagedContainer;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        var containerStyle = styleAsContentContainerStyle.defaultContainerType;
        createContainerType(containerStyle);

        var layoutStyle = styleAsContentContainerStyle.defaultLayoutType;
        createLayoutBaseType(layoutStyle);

    }

    override public function add(comp:IOComponent):IOComponent
    {
        currentLayout.add(comp);
        return comp;
    }

    override public function addType(comp:Class<IOComponent>, ?style:IStyle = null):IOComponent
    {
        var instance = currentLayout.addType(comp, style);
        return instance;
    }

    override public function drawMembers():Void
    {
        if (container != null)
        {
            container._size(this.width, this.height);
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

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public inline function destroyExistingLayout():Void
    {
        if (currentLayout != null)
        {
            //todo pass on the content of a layout??
            currentLayout.destroy();
            currentLayout = null;
        }
    }

    public inline function destroyExistingContainer():Void
    {
        if (container != null)
        {
            if (currentLayout != null)
                container.remove(currentLayout);

            container.destroy();
            container = null;
        }
    }

    public function createLayoutBaseType(type:Class<OLayout>):Void
    {
        destroyExistingLayout();

        currentLayout = Type.createInstance(type, [null]);
        currentLayout.scrollRectEnabled = false;

        container.add(currentLayout);

        this.drawNow();
    }

    public function createContainerType(type:Class<OContainer>):Void
    {
        destroyExistingContainer();

        container = Type.createInstance(type, [null]);
        container.scrollRectEnabled = false;

        coreAdd(container);

        if (currentLayout != null)
            container.add(currentLayout);

        this.drawNow();
    }


    //***********************************************************
    //                  Component Style
    //***********************************************************

    private var styleAsContentContainerStyle(get_styleAsContentContainerStyle, null):OContainerContentStyle;

    private function get_styleAsContentContainerStyle():OContainerContentStyle
    {
        return cast(_style, OContainerContentStyle);
    }

    override public function get_styleId():String
    {
        return OContainerContentStyle.styleString;
    }
}

class OContainerContentStyle extends OContainerStyle
{
    public static var styleString:String = "OContainerContentStyle";

    public var defaultLayoutType:Class<OLayout>;
    public var defaultContainerType:Class<OContainer>;

    public function new()
    {
        super();
        styleID = styleString;
    }
}
