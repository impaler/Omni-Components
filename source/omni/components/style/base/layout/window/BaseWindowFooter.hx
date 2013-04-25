package omni.components.style.base.layout.window;

import omni.components.gui.layout.window.WindowFooter.WindowFooterStyle;
import omni.components.style.base.controls.BaseButton;
import omni.components.gui.controls.Button.ButtonStyle;
import omni.components.gui.controls.Button.ButtonLabelStyle;
import omni.utils.ColorUtils;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.gui.layout.window.WindowHeader.WindowHeaderStyle;
import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.brush.BrushColorFill;

class BaseWindowFooter extends WindowFooterStyle
{
    public function new()
    {
        super();

        defaultHeight = 10;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.ACTIVE);
        setBackgroundBrush(bgColor);
    }
}