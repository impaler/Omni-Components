package omni.components.theme.bloom;

import omni.components.theme.color.Colors;
import omni.components.theme.color.controls.ColorScrollBarButton;
import omni.components.theme.color.Color;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.Slider.SliderBaseStyle;
import omni.utils.ColorUtils;

class BloomSlider extends SliderBaseStyle
{

	public function new( )
	{
		super( );

		buttonStyle = new ColorScrollBarButton();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Colors.BG );
		setBackgroundBrush( bgColor );

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
