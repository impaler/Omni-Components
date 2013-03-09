package omni.components.style.base.layout;

import omni.components.gui.layout.TabButtonGroup.TabButtonGroupStyle;
import omni.components.core.OLayout.OLayoutStyle;

class BaseTabButtonGroup extends TabButtonGroupStyle
{

	public function new()
	{
		super( );

		layoutStyle = new BaseOLayout();
        layoutStyle.background  = null;
	}

}
