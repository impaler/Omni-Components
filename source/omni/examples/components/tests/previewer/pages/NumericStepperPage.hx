package omni.examples.components.tests.previewer.pages;

import omni.components.style.base.core.BaseOComponentButton;
import omni.components.core.OComponentButton.OComponentButtonStyle;
import omni.components.style.base.core.BaseOTextBase;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.base.BaseColors;
import omni.components.gui.controls.NumericStepper;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.Icon.IconStyle;
import omni.components.gui.layout.Icon;
import omni.utils.OStates;
import omni.components.gui.controls.Slider;

class NumericStepperPage extends ThemePage
{

    override public function createMembers():Void
    {

        super.createMembers();

        title = "Numeric Stepper";

        var defaultNumericStepper = new NumericStepper();
        addTest(defaultNumericStepper, "Default NumericStepper");

        var defaultNumericStepper = new NumericStepper();
        defaultNumericStepper.min = -100;
        defaultNumericStepper.max = 0;
        defaultNumericStepper.value = -50;
        addTest(defaultNumericStepper, "Min -100 Max 0");

        var numericStepperSize = new NumericStepper();
        numericStepperSize.size(500, 100);
        addTest(numericStepperSize, "NumericStepper 500 x 100");


    }

    public function testBGBrush():BrushColorFill
    {
        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.STEPPER_BUTTON_ACTIVE);
        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
        bgColor.setColorState(OStates.OVER, BaseColors.STEPPER_BUTTON_OVER);
        bgColor.setColorState(OStates.DOWN, BaseColors.STEPPER_BUTTON_DOWN);
        return bgColor;
    }

}
