package omni.components.theme.color.controls;

import omni.components.gui.controls.RadioButton.RadioButtonStyle;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.core.OToggleButton.OToggleButtonStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.OBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.ComponentStyle;

class ColorRadioButton extends RadioButtonStyle
{
	public function new( )
	{
		super( );

		var textStyle = new LabelStyle();
		textStyle.defaultText = "Radio!";
		textStyle.fontSize = 18;
		labelText = textStyle;

		var bgColor = new BrushColorFill ();

		bgColor.setColorState( OToggleButtonStyle.STATE_ON, Colors.ON );
		bgColor.setColorState( OToggleButtonStyle.STATE_ON_OVER, Colors.ON_OVER );

		bgColor.setColorState( OToggleButtonStyle.STATE_OFF, Colors.OFF_OVER );
		bgColor.setColorState( OToggleButtonStyle.STATE_OFF_OVER, Colors.OFF_OVER );

		bgColor.setColorState( OToggleButtonStyle.STATE_DISABLED, Colors.DISABLED );

		setBackgroundBrush( bgColor );

		defaultState = OToggleButtonStyle.STATE_OFF;

		defaultWidth = 200;
		defaultHeight = 50;
		minWidth = 10;
		minHeight = 10;
		maxWidth = 2000;
		maxHeight = 2000;
		defaultPadding = 0;
	}
}