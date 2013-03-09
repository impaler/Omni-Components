package omni.components.gui.layout;

import omni.components.core.interfaces.IStyle;
import omni.components.core.OLayout;
import omni.components.core.OContainer;
import omni.utils.OStates;
import omni.components.core.interfaces.IOComponent;
import omni.components.gui.controls.TabButton;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.components.core.signals.OSignalType;
import omni.components.core.OComponent;

class ContainerPage extends OComponent {

//***********************************************************
//                  Public Variables
//***********************************************************

    public var onClosed:OSignalType<ContainerPage -> Void>;
    public var onOpened:OSignalType<ContainerPage -> Void>;

    public var title(get_pageName, set_pageName):String;
    public var _title:String;

    public var parentContainer:PagedContainer;
    public var pageButton:TabButton;

    public var container:OContainer;

//***********************************************************
//                  Component Overrides
//***********************************************************

    override public function createMembers():Void {
        super.createMembers();

        onClosed = new OSignalType<ContainerPage -> Void>();
        onOpened = new OSignalType<ContainerPage -> Void>();

        var type = styleAsContainerPageStyle.defaultContainerType;
        setContainerType(type);

    }

    override public function add(comp:IOComponent):IOComponent {
        container.add(comp);
        return comp;
    }

    override public function addType(comp:Class<IOComponent>, ?style:IStyle = null):IOComponent {
        var compInstance = Type.createInstance(comp, [style]);
        container.add(compInstance);
        return compInstance;
    }

    override public function drawMembers():Void {
        super.drawMembers();

        if (container != null) {
            container._width = width;
            container._height = height;
            container.drawNow();
        }
    }

    override public function destroy():Void {
        onClosed.destroy();
        onOpened.destroy();
        if(container!=null)
            container.destroy();
        super.destroy();
    }

//***********************************************************
//                  Component Methods
//***********************************************************

	public function setContainer( type:OContainer ):OContainer
	{
		container = type;
		container.scrollRectEnabled = true;
		coreAdd(type);
		return type;
	}

	public function setContainerType(  type:Class<OContainer> ):OContainer
	{
		container = Type.createInstance( type, [null] );
		setContainer(container);
		
		return container;
	}

    public function open():Void {
        parentContainer.sprite.addChild(this.sprite);
        onOpened.dispatch(this);
    }

    public function close():Void {
        pageButton.value = false;
        parentContainer.sprite.removeChild(this.sprite);
        onClosed.dispatch(this);
    }

//***********************************************************
//                  Properties
//***********************************************************

    public function get_pageName():String {
        if (_title == null) {
            _title = Std.string(compId);
        }
        return _title;
    }

    public function set_pageName(value:String):String {
        if (_title == null) {
            _title = value;
        }
        return _title;
    }

//***********************************************************
//                  Component Style
//***********************************************************

    private var styleAsContainerPageStyle(get_styleAsContainerPageStyle, null):ContainerPageStyle;

    private function get_styleAsContainerPageStyle( ):ContainerPageStyle
    {
        return cast(_style, ContainerPageStyle);
    }

    override public function get_styleId():String {
        return ContainerPageStyle.styleString;
    }
}

class ContainerPageStyle extends OBaseBackgroundStyle {

    public static var styleString:String = "ContainerPageStyle";

    public var defaultContainerType:Class<OContainer>;

    public function new() {
        super();
        styleID = styleString;
    }
}
