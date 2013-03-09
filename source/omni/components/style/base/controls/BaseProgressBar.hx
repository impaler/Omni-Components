package omni.components.style.base.controls;

import omni.components.style.base.BaseColors;
import omni.utils.ColorUtils;
import omni.utils.OStates;
import omni.components.gui.controls.ProgressBar.ProgressBarStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;

class BaseProgressBar extends ProgressBarStyle
{
	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, BaseColors.ACTIVE );
		bgColor.setColorState( OStates.DISABLED, BaseColors.DISABLED );
		bgColor.setColorState( OStates.OVER, BaseColors.OVER );
		bgColor.setColorState( OStates.DOWN, BaseColors.DOWN );
		setBackgroundBrush( bgColor );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, ColorUtils.HALO_BLUE );
		bgColor.setColorState( OStates.DISABLED, BaseColors.DISABLED );
		bgColor.setColorState( OStates.OVER, BaseColors.OVER );
		bgColor.setColorState( OStates.DOWN, BaseColors.DOWN );
		setProgressBrush( bgColor );
		
		
		defaultWidth = 300;
		defaultHeight = 60;
		minWidth = 0;
		minHeight = 0;
		maxWidth = 2000;
		maxHeight = 2000;
		defaultPadding = 0;
	}
}