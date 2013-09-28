package omni.components.gui.layout;

import omni.components.core.OLayout;
import omni.components.core.OToggleButtonGroup;
import omni.components.core.interfaces.IStyle;
import omni.components.core.OLayout.OLayoutStyle;
import omni.components.gui.controls.RadioButton;
import omni.utils.signals.OSignal;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OToggleButton;
import omni.components.core.OComponent;
import omni.components.style.base.OBaseBackgroundStyle;

class RadioButtonGroup extends OToggleButtonGroup
{

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    override public function addButton(style:IStyle = null):OToggleButton
    {
        var button = new RadioButton(style);
        button.onChange.add(handleButtonChange);
        button.group = this;

        this.members.push(button);
        layout.add(button);

        button.drawNow();

        return button;
    }

    override public function setActiveButton(button:RadioButton):Void
    {
        button.value = true;
        _target = button;
        update();
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return RadioButtonGroupStyle.styleString;
    }
}

class RadioButtonGroupStyle extends OToggleButtonGroupStyle
{
    public static var styleString:String = "RadioButtonGroupStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }

}