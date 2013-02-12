package omni.components.theme.color;

import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.ScrollBar.ScrollBarStyle;
import omni.components.gui.controls.Slider.SliderBaseStyle;
import omni.utils.ColorUtils;

class ColorScrollBar extends ScrollBarStyle
{
	public function new( )
	{
		super( );

		buttonStyle = new ColorButtonBase();
		buttonStyle.minHeight = 40;

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Color.BG );
		setBackgroundBrush( bgColor );

		defaultWidth = 20;
		defaultHeight = 180;
		defaultPadding = 10;

	}

}
