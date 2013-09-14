package omni.components.theme.softui;

import omni.utils.OStates;
import omni.components.gui.layout.RadioButtonGroup.RadioButtonGroupStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import flash.geom.Rectangle;

class SoftUIRadioButtonGroup extends RadioButtonGroupStyle
{

    public function new()
    {
        super();

        defaultDirection = OStates.VERTICAL;
        defaultWidth = 300;
        defaultHeight = 300;
        defaultPadding = 20;

    }

}
