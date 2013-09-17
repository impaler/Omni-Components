package omni.components.theme.softui;

import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.style.base.BaseColors;
import omni.components.style.base.text.BaseButtonLabel;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.gui.controls.Button.ButtonLabelStyle;
import omni.utils.OStates;
import omni.components.gui.controls.TabButton.TabButtonStyle;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.core.OToggleButton.OToggleButtonStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;


class SoftUITabButton extends TabButtonStyle
{

    public function new()
    {
        super();

        var bgColor = new BrushBitmapScale9Fill ();
        //bgColor.debuglines = true;
        bgColor.scaleRect = [10 , 12 , 8 , 10];
        bgColor.setBitmapState(OStates.OFF, "assets/themes/softui/TabButton_down.png");
        bgColor.setBitmapState(OStates.ON, "assets/themes/softui/TabButton_over.png");
        //bgColor.setBitmapState(OStates.ON_OVER, "assets/themes/softui/TabButton_active.png");
        bgColor.setBitmapState(OStates.OFF_OVER, "assets/themes/softui/TabButton_active.png");
        setBackgroundBrush(bgColor);

        defaultLabel = new SoftUILabel();
        defaultLabel.defaultText = "Tab Button";

        deafultLayoutStyle = new BaseOComponentButtonLayout();
        deafultLayoutStyle.defaultWidthSizeMethod = OStates.AUTO;
        deafultLayoutStyle.defaultHeightSizeMethod = OStates.AUTO;

        defaultHeightSizeMethod = OStates.AUTO;
        defaultWidthSizeMethod = OStates.AUTO;

        defaultState = OStates.OFF;

    }
}