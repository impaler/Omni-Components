package omni.components.theme.color;

import omni.components.core.OToggleButtonGroup;
import omni.components.core.OToggleButtonGroup.OToggleButtonGroupStyle;
import omni.components.gui.layout.RadioButtonGroup.RadioButtonGroupStyle;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.Layout.LayoutStyle;
import omni.components.gui.layout.Layout;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class ColorOToggleButtonGroup extends OToggleButtonGroupStyle
{

	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Color.BG_LAYOUT );
		setBackgroundBrush( bgColor );

//todo
		defaultDirection = Layout.HORIZONTALLY;
		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 10;

	}

}
