package omni.components.theme.softui;

import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.utils.OStates;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.gui.controls.CheckBox.CheckBoxStyle;

class SoftUICheckBox extends CheckBoxStyle
{
    public function new()
    {
        super();

        var textStyle = new SoftUILabel();
        textStyle.defaultText = "Checkbox!";
        textStyle.fontSize = 18;
        defaultLabel = textStyle;



        var bgColor = new BrushBitmapScale9Fill ();
        bgColor.scaleRect = [2 , 14 , 3 , 14];
        bgColor.setBitmapState(OStates.ON, "assets/themes/softui/checkBoxButton_bg.png");
        bgColor.setBitmapState(OStates.OFF, "assets/themes/softui/checkBoxButton_bg.png");
        setBackgroundBrush(bgColor);

//        var bitmap = Assets.getBitmapData( "assets/themes/softui/checkBoxButton_bg.png" );
//        var test = [];

//        var bgColor = new BrushColorFill ();
//
//        bgColor.setColorState(OStates.ON, BaseColors.ON);
//        bgColor.setColorState(OStates.ON_OVER, BaseColors.ON_OVER);
//        bgColor.setColorState(OStates.OFF, BaseColors.OFF);
//        bgColor.setColorState(OStates.OFF_OVER, BaseColors.OFF_OVER);
//        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
//        setBackgroundBrush(bgColor);

//defaultLabel = null;
        deafultLayoutStyle = new BaseOComponentButtonLayout();

        defaultState = OStates.OFF;
        defaultPadding = 0;
        defaultScrollRect = false;

//defaultWidth = 400;

        defaultHeight = 40;
//defaultWidth = 220;
        defaultWidthSizeMethod = OStates.AUTO;
        defaultHeightSizeMethod = OStates.FIXED;
    }
}