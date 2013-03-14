package omni.components.style.base.layout;

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
		label.fontSize = 30;
		label.fontColor = ColorUtils.BLACK;
		titleLabelStyle = label;

		var close = new ButtonStyle();
		close.defaultLabel = new ButtonLabelStyle();
		close.defaultLabel.fontSize = 30;
		close.defaultLabel.fontColor = ColorUtils.BLACK;
		close.defaultLabel.defaultText = "Close";
		closeButton = close;

		defaultWidth = 120;
		defaultHeight = 40;

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, BaseColors.ACTIVE );
		setBackgroundBrush( bgColor );
	}
}