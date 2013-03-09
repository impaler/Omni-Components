package omni.components.style.base.controls;

import omni.components.style.base.BaseColors;
import omni.components.gui.controls.SliderButton.SliderButtonStyle;
import omni.utils.OStates;
import omni.components.gui.controls.ScrollBarButton.ScrollBarButtonStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;

class BaseSliderButton extends SliderButtonStyle
{
	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, BaseColors.SCROLLBAR_BUTTON_ACTIVE );
		bgColor.setColorState( OStates.DISABLED, BaseColors.DISABLED );
		bgColor.setColorState( OStates.OVER, BaseColors.SCROLLBAR_BUTTON_OVER );
		bgColor.setColorState( OStates.DOWN, BaseColors.SCROLLBAR_BUTTON_DOWN );
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