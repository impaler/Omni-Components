package omni.components.theme.softui.window;

import omni.components.gui.layout.window.WindowFooter.WindowFooterStyle;
import omni.utils.ColorUtils;
import omni.utils.OStates;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.gui.controls.Button.ButtonLabelStyle;
import omni.components.style.base.controls.BaseButton;
import omni.components.gui.layout.window.WindowHeader.WindowHeaderStyle;

class SoftUIWindowFooter extends WindowFooterStyle
{
    public function new()
    {
        super();

        defaultHeight = 10;

        var bgColor = new BrushBitmapScale9Fill ();
        bgColor.scaleRect = [8, 26, 2 , 3];
        bgColor.setBitmapState(OStates.ACTIVE, "assets/themes/softui/windowBg_footer.png");
        setBackgroundBrush(bgColor);

    }
}