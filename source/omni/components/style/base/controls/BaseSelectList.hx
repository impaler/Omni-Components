package omni.components.style.base.controls;

import omni.components.style.base.core.BaseOLayout;
import omni.components.core.OLayout.OLayoutStyle;
import omni.components.gui.controls.SelectList;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponentButton.OComponentButtonStyle;

class BaseSelectList extends SelectListStyle
{
    public function new()
    {
        super();

        deafultLayoutStyle = new BaseOComponentButtonLayout();

        defaultListLayoutStyle = new BaseOLayout();
        defaultListLayoutStyle.defaultDirection = OStates.VERTICAL;


        defaultHeight = 10;

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, BaseColors.ACTIVE);
        bgColor.setColorState(OStates.DISABLED, BaseColors.DISABLED);
        bgColor.setColorState(OStates.OVER, BaseColors.OVER);
        bgColor.setColorState(OStates.DOWN, BaseColors.DOWN);
        setBackgroundBrush(bgColor);

    }
}