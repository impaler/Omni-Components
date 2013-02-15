package omni.components.theme.android4;

import omni.components.theme.color.Colors;
import omni.components.core.OLayout;
import omni.components.theme.color.controls.ColorScrollSlider;
import omni.components.theme.bloom.BloomScrollBar;
import omni.components.theme.color.Color;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.ScrollContainer.ScrollContainerStyle;
import omni.components.core.OLayout.OLayoutStyle;
import nme.geom.Rectangle;

class Android4ScrollContainer extends ScrollContainerStyle
{

	public function new( )
	{
		super( );

		hScrollStyle = new ColorScrollSlider();
		vScrollStyle = new ColorScrollSlider();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Colors.BG );
		setBackgroundBrush( bgColor );

		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 20;

	}

}
