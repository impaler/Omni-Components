package omni.components.core;

import omni.components.gui.layout.window.TabButton;
import omni.components.gui.layout.VBox;
import omni.components.gui.layout.HBox;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.style.base.OBaseStyle;
import omni.components.core.OLayout.OLayoutStyle;
import omni.components.core.OToggleButton;
import omni.utils.signals.OSignalType;
import omni.components.core.OToggleButton;
import omni.components.core.OComponent;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.utils.OStates;

class OToggleButtonGroup extends OComponent
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var layout:OLayout;

    public var onChange:OSignalType<Dynamic -> Void>;
    public var onButtonChange:OSignalType<Dynamic -> Void>;

    private var _target:OToggleButton;

    //***********************************************************
    //                  Style Variables
    //***********************************************************

    public var direction:String;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        if (styleAsOToggleButtonGroup.defaultDirection == OStates.HORIZONTAL)
        {
            layout = new HBox(styleAsOToggleButtonGroup.layoutStyle);
        }
        else if (styleAsOToggleButtonGroup.defaultDirection == OStates.VERTICAL)
        {
            layout = new VBox(styleAsOToggleButtonGroup.layoutStyle);
        }

        this.sprite.addChild(layout.sprite);

        onChange = new OSignalType<OToggleButtonGroup -> Void>();
        onButtonChange = new OSignalType<OToggleButton -> Void>();
    }

    override public function destroy():Void
    {
        onChange.destroy();
        onButtonChange.destroy();
        layout.destroy();
        _target = null;

        super.destroy();
    }

    //***********************************************************
    //                  Event Handlers
    //***********************************************************

    public function handleButtonChange(button:Dynamic):Void
    {
        var btn = cast (button, OToggleButton);

        if (btn._value)
        {
            _target = btn;
            update();
        }

        onChange.dispatch(this);
        onButtonChange.dispatch(btn);
    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public function setActiveButton(button:Dynamic):Void
    {
        _target = button;
        update();
    }

    public function addButton(style:IStyle = null):Dynamic
    {
        var button = new OToggleButton(style);
        button.group = this;
        button.onChange.add(handleButtonChange);
        this.members.push(button);
        layout.add(button);

        return button;
    }

    private function update():Void
    {
        for (o in members)
        {
            var comp = cast(o, OToggleButton);

            if (comp != _target)
                comp.value = false;
        }
    }

    //***********************************************************
    //                  Properties
    //***********************************************************

    override public function get_height():Float
    {
        return layout.get_height();
    }

    override public function get_width():Float
    {
        return layout.get_width();
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    private var styleAsOToggleButtonGroup(get_styleAsOToggleButtonGroup, null):OToggleButtonGroupStyle;

    private function get_styleAsOToggleButtonGroup():OToggleButtonGroupStyle
    {
        return cast(_style, OToggleButtonGroupStyle);
    }

    override public function get_styleId():String
    {
        return OToggleButtonGroupStyle.styleString;
    }
}

class OToggleButtonGroupStyle extends OBaseStyle
{
    public static var styleString:String = "OToggleButtonGroupStyle";

    public var defaultDirection:String;
    public var layoutStyle:OLayoutStyle;

    public function new()
    {
        super();
        styleID = styleString;
    }

    override public function initStyle(value:IOComponent):Void
    {
        var styleAs = cast (value, OToggleButtonGroup);

        styleAs.direction = defaultDirection;

        super.initStyle(value);
    }
}