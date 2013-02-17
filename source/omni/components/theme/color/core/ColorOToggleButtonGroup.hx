package omni.components.theme.color.core;

import omni.components.core.OStates;
import omni.components.core.OToggleButtonGroup;
import omni.components.core.OToggleButtonGroup.OToggleButtonGroupStyle;
import omni.components.gui.layout.RadioButtonGroup.RadioButtonGroupStyle;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class ColorOToggleButtonGroup extends OToggleButtonGroupStyle
{

	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, Colors.BG_LAYOUT );
		setBackgroundBrush( bgColor );

		defaultDirection = OStates.HORIZONTAL;
		defaultWidth = 300;
		defaultHeight = 300;
		defaultPadding = 10;

	}

}
