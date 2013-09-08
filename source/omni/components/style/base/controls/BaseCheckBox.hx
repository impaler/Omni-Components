package omni.components.style.base.controls;

import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.style.base.BaseColors;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.Button.ButtonLabelStyle;
import omni.components.gui.controls.CheckBox.CheckBoxStyle;
import omni.utils.OStates;

class BaseCheckBox extends CheckBoxStyle
{
    public function new()
    {
        super();

        var textStyle = new ButtonLabelStyle();
        textStyle.defaultText = "Checkbox!";
        textStyle.fontSize = 18;
        defaultLabel = textStyle;

        var bgColor = new BrushColorFill ();

        bgColor.setColorState(OStates.ON, BaseColors.ON);
        bgColor.setColorState(OStates.ON_OVER, BaseColors.ON_OVER);
        bgColor.setColorState(OStates.OFF, BaseColors.OFF);
        bgColor.setColorState(OStates.OFF_OVER, BaseColors.OFF_OVER);
        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
        setBackgroundBrush(bgColor);

        deafultLayoutStyle = new BaseOComponentButtonLayout();

        defaultState = OStates.OFF;
        defaultPadding = 0;
        defaultScrollRect = false;

        defaultHeight = 40;
        defaultWidthSizeMethod = OStates.AUTO;
        defaultHeightSizeMethod = OStates.FIXED;
    }
}