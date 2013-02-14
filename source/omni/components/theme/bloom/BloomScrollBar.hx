package omni.components.theme.bloom;

import omni.components.theme.color.Colors;
import omni.components.theme.color.controls.ColorScrollBarButton;
import omni.components.theme.color.Color;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.ScrollBar.ScrollBarStyle;
import omni.components.gui.controls.Slider.SliderBaseStyle;
import omni.utils.ColorUtils;

class BloomScrollBar extends ScrollBarStyle
{
	public function new( )
	{
		super( );

		buttonStyle = new ColorScrollBarButton();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Colors.BG );
		setBackgroundBrush( bgColor );

		defaultWidth = 20;
		defaultHeight = 180;
		defaultPadding = 10;

	}

}
