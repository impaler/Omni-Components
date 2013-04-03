package omni.components.style.base.controls;

import omni.components.gui.layout.window.TabButton;
import omni.components.style.base.BaseColors;
import omni.components.style.base.text.BaseButtonLabel;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.gui.controls.Button.ButtonLabelStyle;
import omni.utils.OStates;
import omni.components.gui.layout.window.TabButton.TabButtonStyle;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.core.OToggleButton.OToggleButtonStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;

class BaseTabButton extends TabButtonStyle
{
    public function new()
    {
        super();

        var bgColor = new BrushColorFill ();

        bgColor.setColorState(OStates.ON, ColorUtils.BLUE);
        bgColor.setColorState(OStates.ON_OVER, BaseColors.ON_OVER);

        bgColor.setColorState(OStates.OFF, ColorUtils.GREEN);
        bgColor.setColorState(OStates.OFF_OVER, BaseColors.OFF_OVER);

        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);

        setBackgroundBrush(bgColor);

        defaultLabel = new BaseButtonLabel();
        defaultLabel.defaultText = "Tab Button";

        layoutStyle = new BaseOComponentButtonLayout();
        layoutStyle.defaultWidthSizeMethod = OStates.AUTO;
        layoutStyle.defaultHeightSizeMethod = OStates.AUTO;

        defaultHeightSizeMethod = OStates.AUTO;
        defaultWidthSizeMethod = OStates.AUTO;

    }
}