package omni.components.style.base.core;

import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OToggleButtonGroup;

class BaseOToggleButtonGroup extends OToggleButtonGroupStyle
{

    public function new()
    {
        super();

        defaultDirection = OStates.VERTICAL;

        //todo autosize
        defaultWidth = 300;
        defaultHeight = 300;
        defaultPadding = 10;

        //                   todo
        //		var bgColor = new BrushColorFill ();
        //		bgColor.setColorState( OStates.ACTIVE, BaseColors.BG_LAYOUT );
        //		setBackgroundBrush( bgColor );

    }

}
