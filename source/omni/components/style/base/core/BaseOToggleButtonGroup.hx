package omni.components.style.base.core;

import omni.components.core.OToggleButtonGroup;
import omni.utils.OStates;

class BaseOToggleButtonGroup extends OToggleButtonGroupStyle
{

    public function new()
    {
        super();

        defaultDirection = OStates.VERTICAL;

        defaultWidth = 300;
        defaultHeight = 300;
        defaultPadding = 10;
    }

}
