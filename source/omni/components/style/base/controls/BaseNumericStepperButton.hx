package omni.components.style.base.controls;

import omni.components.gui.layout.containers.SpriteContainer;
import nme.display.Sprite;
import omni.components.gui.controls.NumericStepper;
import omni.components.core.interfaces.IOComponent;
import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.gui.controls.NumericStepperButton;
import omni.components.gui.controls.NumericStepperButton.NumericStepperButtonStyle;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponentButton.OComponentButtonStyle;

class BaseNumericStepperButton extends NumericStepperButtonStyle
{
    public function new()
    {
        super();

        layoutStyle = new BaseOComponentButtonLayout();
        layoutStyle.defaultVAlign = OStates.MIDDLE;
        layoutStyle.defaultHAlign = OStates.MIDDLE;
        layoutStyle.defaultWidthSizeMethod = OStates.FIXED;
        layoutStyle.defaultHeightSizeMethod = OStates.FIXED;
        layoutStyle.defaultTopPadding = 0;
        layoutStyle.defaultLeftPadding = 0;
        layoutStyle.defaultRightPadding = 0;
        layoutStyle.defaultBottomPadding = 0;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.ACTIVE);
        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
        bgColor.setColorState(OStates.OVER, BaseColors.OVER);
        bgColor.setColorState(OStates.DOWN, BaseColors.DOWN);
        setBackgroundBrush(bgColor);

        defaultWidthSizeMethod = OStates.FIXED;
        defaultHeightSizeMethod = OStates.FIXED;
    }

}