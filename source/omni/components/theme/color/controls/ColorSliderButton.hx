package omni.components.theme.color.controls;

import omni.components.gui.controls.ScrollBarButton.ScrollBarButtonStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.OBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.ComponentStyle;

class ColorSliderButton extends OButtonBaseStyle
{
	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OBaseStyle.STATE_ACTIVE, Colors.SCROLLBAR_BUTTON_ACTIVE );
		bgColor.setColorState( OBaseStyle.STATE_DISABLED, Colors.DISABLED );
		bgColor.setColorState( OButtonBaseStyle.STATE_OVER, Colors.SCROLLBAR_BUTTON_OVER );
		bgColor.setColorState( OButtonBaseStyle.STATE_DOWN, Colors.SCROLLBAR_BUTTON_DOWN );
		setBackgroundBrush( bgColor );

		defaultWidth = 20;
		defaultHeight = 20;
		minWidth = 10;
		minHeight = 10;
		maxWidth = 2000;
		maxHeight = 2000;
		defaultPadding = 0;
	}
}