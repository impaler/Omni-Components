package omni.components.core;

import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.gui.layout.VBox;
import omni.components.gui.layout.HBox;
import omni.components.style.base.OBaseStyle;
import omni.components.core.OLayout.OLayoutStyle;
import omni.components.core.OToggleButton;
import omni.components.core.OToggleButton;
import omni.components.core.OComponent;
import omni.utils.signals.OSignalT;
import omni.utils.OStates;

class OToggleButtonGroup extends OComponent
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var layout:OLayout;

    public var onButtonChange:OSignalT<Dynamic>;

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

        onButtonChange = new OSignalT<OToggleButton>();
    }

    override public function destroy():Void
    {
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

        onButtonChange.dispatch(btn);
    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public function nextButton():Dynamic
    {
        if (_target!=null)
        {
            var currentIndex = Lambda.indexOf(members, _target);
            if (members[currentIndex + 1] == null)
            {
                return (members[0]);
            }
            else
            {
                return (members[currentIndex + 1]);
            }
        }
        return null;
    }

    public function previousButton():Dynamic
    {
        if (_target!=null)
        {
            var currentIndex = Lambda.indexOf(members, _target);
            if (members[currentIndex - 1] == null)
            {
                return (members[members.length-1]);
            }
            else
            {
                return (members[currentIndex - 1]);
            }
        }
        return null;
    }

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