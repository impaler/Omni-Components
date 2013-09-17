package omni.components.style.base.controls;

import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.style.base.text.BaseButtonLabel;
import omni.components.style.brush.BrushColorFill;
import omni.components.style.base.BaseColors;
import omni.components.gui.controls.TabButton.TabButtonStyle;
import omni.components.gui.controls.Button.ButtonLabelStyle;
import omni.components.gui.controls.TabButton;
import omni.utils.OStates;

class BaseTabButton extends TabButtonStyle
{
    public function new()
    {
        super();

        var bgColor = new BrushColorFill ();

        bgColor.setColorState(OStates.ON, BaseColors.ON );
        bgColor.setColorState(OStates.ON_OVER, BaseColors.ON_OVER);

        bgColor.setColorState(OStates.OFF, BaseColors.OFF );
        bgColor.setColorState(OStates.OFF_OVER, BaseColors.OFF_OVER);

        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);

        setBackgroundBrush(bgColor);

        defaultLabel = new BaseButtonLabel();
        defaultLabel.defaultText = "Tab Button";

        deafultLayoutStyle = new BaseOComponentButtonLayout();
        deafultLayoutStyle.defaultWidthSizeMethod = OStates.AUTO;
        deafultLayoutStyle.defaultHeightSizeMethod = OStates.AUTO;

        defaultHeightSizeMethod = OStates.AUTO;
        defaultWidthSizeMethod = OStates.AUTO;

        defaultState = OStates.OFF;

    }
}