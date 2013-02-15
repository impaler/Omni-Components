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

//		buttonStyle = new ColorScrollBarButton();

//		public var horizontalBar:ScrollBarButtonStyle;
//		public var verticalBar:ScrollBarButtonStyle;

//		var bgColor = new BrushColorFill ();
//		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Colors.BG );
//		setBackgroundBrush( bgColor );

		defaultWidth = 300;
		defaultHeight = 20;
		defaultPadding = 0;

	}

}
