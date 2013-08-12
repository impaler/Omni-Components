package omni.components.style.base.controls;

import omni.components.style.base.BaseColors;
import omni.components.style.base.text.BaseButtonLabel;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.style.base.layout.BaseIcon;
import omni.utils.OStates;
import openfl.Assets;
import omni.components.gui.layout.Icon.IconStyle;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.gui.controls.Button.ButtonStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;

class BaseButton extends ButtonStyle
{
    public function new()
    {
        super();

        //defaultSizeMethodWidth = OStates.AUTO;
        //defaultSizeMethodHeight = OStates.FIXED;

        defaultHeight = 40;

        defaultText = "test";

//        defaultLabel = new BaseButtonLabel();
//        defaultIcon = new BaseIcon();

        deafultLayoutStyle = new BaseOComponentButtonLayout();

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.ACTIVE);
        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
        bgColor.setColorState(OStates.OVER, BaseColors.OVER);
        bgColor.setColorState(OStates.DOWN, BaseColors.DOWN);
        setBackgroundBrush(bgColor);

    }
}