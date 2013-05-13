package omni.components.style.base.controls;

import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.style.base.BaseColors;
import omni.components.gui.controls.NumericStepperButton.NumericStepperButtonStyle;
import omni.utils.ColorUtils;
import omni.components.core.OLayout.OLayoutStyle;
import omni.components.core.OComponentButton.OComponentButtonStyle;
import omni.components.core.OComponentButton.OComponentButtonLayoutStyle;
import omni.components.gui.layout.containers.SpriteContainer;
import omni.components.core.interfaces.IOComponent;
import omni.components.gui.layout.Icon.IconStyle;
import omni.components.gui.controls.Button.ButtonStyle;
import nme.display.Sprite;
import omni.utils.OStates;
import omni.components.style.base.core.BaseOTextBase;
import omni.components.style.base.core.BaseOButtonBase;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.NumericStepper;
import omni.components.gui.controls.NumericStepper.NumericStepperStyle;

class BaseNumericStepper extends NumericStepperStyle
{
    public function new()
    {
        super();

        max = 1000;
        min = -10;
        value = 0;
        step = 1;
        initialButtonTimerDelay = 1000;
        timerInterval = 100;

        defaultWidth = 160;
        defaultHeight = 60;

        var buttonStyle = new BaseNumericStepperButton();

//        var bgColor = new BrushColorFill ();
//        bgColor.setColorState(OStates.ACTIVE, BaseColors.STEPPER_BUTTON_ACTIVE);
//        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
//        bgColor.setColorState(OStates.OVER, BaseColors.STEPPER_BUTTON_OVER);
//        bgColor.setColorState(OStates.DOWN, BaseColors.STEPPER_BUTTON_DOWN);
//        buttonStyle.setBackgroundBrush(bgColor);

        increaseButtonStyle = buttonStyle;
        decreaseButtonStyle = buttonStyle;

        var style = new BaseOTextBase();
        textStyle = style;

        var bgColor = new BrushBitmapScale9Fill ();
        bgColor.scaleRect = [4 , 10 , 4 , 8];
        bgColor.setBitmapState(OStates.ACTIVE, "assets/themes/softui/stepper_bg.png");
        setBackgroundBrush(bgColor);


//        var bgColor = new BrushColorFill ();
//        bgColor.setColorState(OStates.ACTIVE, BaseColors.ACTIVE);
//        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
//        setBackgroundBrush(bgColor);
    }

    override public function initStyleComponent(value:IOComponent):Void
    {
        var stepper = cast( value, NumericStepper );

        var size = 2;
        var _increase_shape = new Sprite();
        _increase_shape.graphics.beginFill(ColorUtils.BLACK);
        _increase_shape.graphics.moveTo(3 * size, 0);
        _increase_shape.graphics.lineTo(6 * size, 5 * size);
        _increase_shape.graphics.lineTo(0, 5 * size);
        _increase_shape.graphics.lineTo(3 * size, 0);
        _increase_shape.graphics.endFill();

        var comp = new SpriteContainer();
        comp.setSprite(_increase_shape);

        stepper.increase.add(comp);
        stepper.increase.drawNow();

        var _decrease_shape = new Sprite();
        _decrease_shape.graphics.beginFill(ColorUtils.BLACK);
        _decrease_shape.graphics.moveTo(0, 0);
        _decrease_shape.graphics.lineTo(6 * size, 0);
        _decrease_shape.graphics.lineTo(3 * size, 5 * size);
        _decrease_shape.graphics.lineTo(0, 0);
        _decrease_shape.graphics.endFill();

        var comp = new SpriteContainer();
        comp.setSprite(_decrease_shape);

        stepper.decrease.add(comp);

        stepper.drawNow();
    }

}