package omni.components.style.base.layout.window;

import omni.components.style.base.controls.BaseButton;
import omni.components.gui.controls.Button.ButtonStyle;
import omni.components.gui.controls.Button.ButtonLabelStyle;
import omni.utils.ColorUtils;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.gui.layout.window.WindowHeader.WindowHeaderStyle;
import omni.components.style.base.BaseColors;
import omni.utils.OStates;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.brush.BrushColorFill;

class BaseWindowHeader extends WindowHeaderStyle
{
	public function new( )
	{
		super( );

		var label = new LabelStyle();
		label.fontSize = 10;
		label.fontColor = ColorUtils.BLACK;
		titleLabelStyle = label;

		var close = new BaseButton();
		close.defaultIcon = null;
		close.defaultLabel = new ButtonLabelStyle();
		close.defaultLabel.fontSize = 10;
		close.defaultLabel.fontColor = ColorUtils.BLACK;
		close.defaultLabel.defaultText = "Close";
		closeButton = close;
		
		
		var max = new BaseButton();
		max.defaultIcon = null;
		max.defaultLabel = new ButtonLabelStyle();
		max.defaultLabel.fontSize = 10;
		max.defaultLabel.fontColor = ColorUtils.BLACK;
		max.defaultLabel.defaultText = "Max";
		maximizeButton = max;
		
		var min = new BaseButton();
		min.defaultIcon = null;
		min.defaultLabel = new ButtonLabelStyle();
		min.defaultLabel.fontSize = 10;
		min.defaultLabel.fontColor = ColorUtils.BLACK;
		min.defaultLabel.defaultText = "Min";
		minimizeButton = min;
		
		defaultWidth = 120;
		defaultHeight = 40;

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, BaseColors.ACTIVE );
		setBackgroundBrush( bgColor );
	}
}