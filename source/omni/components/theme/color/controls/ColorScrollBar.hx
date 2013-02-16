package omni.components.theme.color.controls;

import omni.components.gui.controls.ScrollBar.ScrollBarStyle;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.ScrollSlider.ScrollSliderStyle;
import omni.components.gui.controls.Slider.SliderBaseStyle;
import omni.utils.ColorUtils;

class ColorScrollBar extends ScrollBarStyle
{
	public function new( )
	{
		super( );

		increaseButton = new ColorScrollBarButton();
		decreaseButton = new ColorScrollBarButton();

		defaultWidth = 300;
		defaultHeight = 20;
		defaultPadding = 0;

	}

}
