package omni.components.theme.softui;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.utils.OStates;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.gui.controls.RadioButton.RadioButtonStyle;
class SoftUIRadioButton  extends RadioButtonStyle
{
    public function new()
    {
        super();

        var textStyle = new SoftUILabel();
        textStyle.defaultText = "Radio!";
        textStyle.fontSize = 18;
        defaultLabel = textStyle;

        deafultLayoutStyle = new BaseOComponentButtonLayout();

//        var bitmap = Assets.getBitmapData( "assets/themes/softui/radioButton_bg.png" );
//        var test = [7 , 9 , 7 , 9];

        var bgColor = new BrushBitmapScale9Fill ();
        bgColor.scaleRect = [7 , 9 , 7 , 9];
        bgColor.setBitmapState(OStates.ON, "assets/themes/softui/radioButton_bg.png");
        bgColor.setBitmapState(OStates.OFF, "assets/themes/softui/radioButton_bg.png");
        setBackgroundBrush(bgColor);

//        var bgColor = new BrushColorFill ();
//        bgColor.setColorState(OStates.ON, BaseColors.ON);
//        bgColor.setColorState(OStates.ON_OVER, BaseColors.ON_OVER);
//        bgColor.setColorState(OStates.OFF, BaseColors.OFF);
//        bgColor.setColorState(OStates.OFF_OVER, BaseColors.OFF_OVER);
//        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
//        setBackgroundBrush(bgColor);

        defaultWidthSizeMethod = OStates.AUTO;
        defaultHeightSizeMethod = OStates.AUTO;

        defaultHeight = 40;
        defaultState = OStates.OFF;
    }
}