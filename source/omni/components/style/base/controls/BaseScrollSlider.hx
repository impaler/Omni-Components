package omni.components.style.base.controls;

import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.ScrollSlider.ScrollSliderStyle;
import omni.components.gui.controls.Slider.SliderBaseStyle;
import omni.utils.ColorUtils;

class BaseScrollSlider extends ScrollSliderStyle
{
	public function new( )
	{
		super( );

		buttonStyle = new BaseSliderButton();

		decreaseButtonStyle = new BaseScrollBarButton();
		increaseButtonStyle = new BaseScrollBarButton();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, ColorUtils.BLUE );
		setBackgroundBrush( bgColor );

		defaultVHeight = 120;
		defaultVWidth = 20;

		defaultHHeight = 20;
		defaultHWidth = 120;

		defaultValue = 50;

		scrollButtons = false;

	}

}
