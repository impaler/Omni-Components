package omni.components.theme.color.controls;

import omni.components.core.OStates;
import omni.components.gui.controls.ScrollBarButton.ScrollBarButtonStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.OBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;

class ColorSliderButton extends OButtonBaseStyle
{
	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, Colors.SCROLLBAR_BUTTON_ACTIVE );
		bgColor.setColorState( OStates.DISABLED, Colors.DISABLED );
		bgColor.setColorState( OStates.OVER, Colors.SCROLLBAR_BUTTON_OVER );
		bgColor.setColorState( OStates.DOWN, Colors.SCROLLBAR_BUTTON_DOWN );
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