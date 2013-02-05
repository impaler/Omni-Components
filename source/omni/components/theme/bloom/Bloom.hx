package omni.components.theme.bloom;

import omni.components.core.OTheme;
import omni.components.utils.ColorUtils;

class Bloom extends OTheme
{
	//Test of bitmap based theme
	public function new()
	{
		super();

		addStyle(BloomComponent);
		addStyle(BloomButtonBase);
		addStyle(BloomLayout);
		addStyle(BloomSlider);
		addStyle(BloomScrollBar);
		addStyle(BloomScrollContainer);
		//		addStyle(BloomTextBase);
	}
}