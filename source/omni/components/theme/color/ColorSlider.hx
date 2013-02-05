package omni.components.theme.color;

import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.Slider.SliderBaseStyle;
import omni.components.utils.ColorUtils;

/**
 * OrangeSlider
 */
class ColorSlider extends SliderBaseStyle
{

	public function new()
	{
		super();

		buttonStyle = new ColorButtonBase();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState(OBaseStyle.STATE_ACTIVE, Color.BG);
		setBackgroundBrush(bgColor);

		defaultVHeight = 120;
		defaultVWidth = 20;

		defaultHHeight = 20;
		defaultHWidth = 120;

		defaultValue = 50;

		defaultPadding = 0;
		minWidth = 10;
		minHeight = 10;
		maxWidth = 2000;
		maxHeight = 2000;
	}

}