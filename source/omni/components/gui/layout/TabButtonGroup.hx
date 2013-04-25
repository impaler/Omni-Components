package omni.components.gui.layout;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IStyle;
import omni.components.gui.layout.window.TabButton;
import omni.utils.OStates;
import omni.components.core.OLayout;
import omni.components.core.OToggleButtonGroup;
import omni.components.core.OContainerPage;
import omni.components.gui.layout.window.TabButton;
import omni.components.core.OToggleButtonGroup.OToggleButtonGroupStyle;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.signals.OSignalType;
import omni.components.core.OToggleButton;
import omni.components.core.OComponent;
import omni.components.style.base.OBaseBackgroundStyle;

class TabButtonGroup extends OToggleButtonGroup
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        if (styleAsTabButtonGroupStyle.defaultDirection == OStates.HORIZONTAL)
        {
            layout = new HBox(styleAsTabButtonGroupStyle.layoutStyle);
        }
        else if (styleAsTabButtonGroupStyle.defaultDirection == OStates.VERTICAL)
        {
            layout = new VBox(styleAsTabButtonGroupStyle.layoutStyle);
        }

        this.sprite.addChild(layout.sprite);

        onChange = new OSignalType<TabButtonGroup -> Void>();
        onButtonChange = new OSignalType<TabButton -> Void>();
    }

    //***********************************************************
    //                  Event Handlers
    //***********************************************************

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    //todo mouse wheel change

    public function addTabButton(page:OContainerPage, style:IStyle = null):TabButton
    {
        var button = new TabButton(style);
        page.pageButton = button;
        button.text = page.title;
        button.group = this;
        button.containerPage = page;
        button.drawNow();
        this.members.push(button);
        layout.add(button);
        button.onChange.add(handleButtonChange);

        return button;
    }

    override public function setActiveButton(button:TabButton):Void
    {
        _target = button;
        button._value = true;
        button._state = button.getValueState();
        update();
    }

    //***********************************************************
    //                  Properties
    //***********************************************************

    //***********************************************************
    //                  Component Style
    //***********************************************************

    private var styleAsTabButtonGroupStyle(get_styleAsTabButtonGroupStyle, null):TabButtonGroupStyle;

    private function get_styleAsTabButtonGroupStyle():TabButtonGroupStyle
    {
        return cast(_style, TabButtonGroupStyle);
    }

    override public function get_styleId():String
    {
        return TabButtonGroupStyle.styleString;
    }
}

class TabButtonGroupStyle extends OToggleButtonGroupStyle
{
    public static var styleString:String = "TabButtonGroupStyle";

    public function new()
    {
        super();
        defaultDirection = OStates.HORIZONTAL;
        styleID = styleString;
    }

    override public function initStyle(value:IOComponent):Void
    {
        var styleAs = cast (value, OToggleButtonGroup);

        styleAs.direction = defaultDirection;

        super.initStyle(value);
    }

    override public function update(value:IOComponent):Void
    {
        super.update(value);
        var comp = cast (value, TabButtonGroup);
        comp.layout.invalidate();

    }

}