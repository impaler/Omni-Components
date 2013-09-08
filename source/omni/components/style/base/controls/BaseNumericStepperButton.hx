package omni.components.style.base.controls;

import omni.components.gui.controls.NumericStepperButton;
import omni.components.gui.controls.NumericStepperButton.NumericStepperButtonStyle;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.core.OComponentButton.OComponentButtonStyle;
import omni.utils.OStates;

class BaseNumericStepperButton extends NumericStepperButtonStyle
{
    public function new()
    {
        super();

        deafultLayoutStyle = new BaseOComponentButtonLayout();
        deafultLayoutStyle.defaultVAlign = OStates.MIDDLE;
        deafultLayoutStyle.defaultHAlign = OStates.MIDDLE;
        deafultLayoutStyle.defaultWidthSizeMethod = OStates.FIXED;
        deafultLayoutStyle.defaultHeightSizeMethod = OStates.FIXED;
        deafultLayoutStyle.defaultTopPadding = 0;
        deafultLayoutStyle.defaultLeftPadding = 0;
        deafultLayoutStyle.defaultRightPadding = 0;
        deafultLayoutStyle.defaultBottomPadding = 0;

        defaultWidthSizeMethod = OStates.FIXED;
        defaultHeightSizeMethod = OStates.FIXED;

        setBackgroundBrush(null);
    }

}