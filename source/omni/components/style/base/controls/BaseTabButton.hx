package omni.components.style.base.controls;

import omni.components.style.base.BaseColors;
import omni.components.style.base.text.BaseButtonLabel;
import omni.components.style.base.core.BaseOComponentButtonLayout;
import omni.components.gui.controls.Button.ButtonLabelStyle;
import omni.utils.OStates;
import omni.components.gui.controls.TabButton.TabButtonStyle;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.core.OToggleButton.OToggleButtonStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;

class BaseTabButton extends TabButtonStyle
{
	public function new( )
	{
		super( );
		
		defaultHeight = 70;
		defaultWidth = 220;
		defaultSizeMethodWidth = OStates.AUTO;
		defaultSizeMethodHeight = OStates.AUTO;
		
		var bgColor = new BrushColorFill ();

		bgColor.setColorState( OStates.ON, BaseColors.ON );
		bgColor.setColorState( OStates.ON_OVER, BaseColors.ON_OVER );

		bgColor.setColorState( OStates.OFF, BaseColors.OFF );
		bgColor.setColorState( OStates.OFF_OVER, BaseColors.OFF_OVER );

		bgColor.setColorState( OStates.DISABLED, BaseColors.DISABLED );

		setBackgroundBrush( bgColor );
		
		defaultLabel = new BaseButtonLabel();
		layoutStyle = new BaseOComponentButtonLayout();
	}
}