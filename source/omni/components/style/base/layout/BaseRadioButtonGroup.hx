package omni.components.style.base.layout;

import omni.utils.OStates;
import omni.components.gui.layout.RadioButtonGroup.RadioButtonGroupStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class BaseRadioButtonGroup extends RadioButtonGroupStyle
{

    public function new()
    {
        super();

        //var bgColor = new BrushColorFill ();
        //bgColor.setColorState( OStates.ACTIVE, BaseColors.BG_LAYOUT );
        //setBackgroundBrush( bgColor );

        defaultDirection = OStates.VERTICAL;
        defaultWidth = 300;
        defaultHeight = 300;
        defaultPadding = 20;

    }

}
