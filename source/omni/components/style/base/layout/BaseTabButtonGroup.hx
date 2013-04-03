package omni.components.style.base.layout;

import omni.utils.OStates;
import omni.components.style.base.core.BaseOLayout;
import omni.components.gui.layout.TabButtonGroup.TabButtonGroupStyle;
import omni.components.core.OLayout.OLayoutStyle;

class BaseTabButtonGroup extends TabButtonGroupStyle
{

    public function new()
    {
        super();

        layoutStyle = new BaseOLayout();

        layoutStyle.defaultWidthSizeMethod = OStates.AUTO;
        layoutStyle.defaultHeightSizeMethod = OStates.AUTO;

        layoutStyle.background = null;
    }

}
