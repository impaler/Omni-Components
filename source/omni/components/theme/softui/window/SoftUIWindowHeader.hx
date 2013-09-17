package omni.components.theme.softui.window;

import omni.utils.ColorUtils;
import omni.utils.OStates;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.gui.controls.Button.ButtonLabelStyle;
import omni.components.style.base.controls.BaseButton;
import omni.components.gui.layout.window.WindowHeader.WindowHeaderStyle;

class SoftUIWindowHeader extends WindowHeaderStyle
{
    public function new()
    {
        super();

        var label = new SoftUILabel();
        label.fontSize = 10;
        label.fontColor = ColorUtils.BLACK;
        titleLabelStyle = label;

        var close = new BaseButton();
        close.defaultIcon = null;
        close.defaultLabel = new ButtonLabelStyle();
        close.defaultLabel.fontSize = 10;
        close.defaultLabel.fontColor = ColorUtils.BLACK;
        close.defaultLabel.defaultText = "Close";
        closeButton = close;


        var max = new BaseButton();
        max.defaultIcon = null;
        max.defaultLabel = new ButtonLabelStyle();
        max.defaultLabel.fontSize = 10;
        max.defaultLabel.fontColor = ColorUtils.BLACK;
        max.defaultLabel.defaultText = "Max";
        maximizeButton = max;

        var min = new BaseButton();
        min.defaultIcon = null;
        min.defaultLabel = new ButtonLabelStyle();
        min.defaultLabel.fontSize = 10;
        min.defaultLabel.fontColor = ColorUtils.BLACK;
        min.defaultLabel.defaultText = "Min";
        minimizeButton = min;

        defaultWidth = 120;
        defaultHeight = 40;

        var bgColor = new BrushBitmapScale9Fill ();
        bgColor.scaleRect = [8, 26, 7 , 8];
        bgColor.setBitmapState(OStates.ACTIVE, "assets/themes/softui/windowBg_header.png");
        setBackgroundBrush(bgColor);

    }
}