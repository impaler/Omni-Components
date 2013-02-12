package omni.components.theme.color;

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

		bgColor.setColorState( OToggleButtonStyle.STATE_ON, Color.ON );
		bgColor.setColorState( OToggleButtonStyle.STATE_ON_OVER, Color.ON_OVER );

		bgColor.setColorState( OToggleButtonStyle.STATE_OFF, Color.OFF_OVER );
		bgColor.setColorState( OToggleButtonStyle.STATE_OFF_OVER, Color.OFF_OVER );

		bgColor.setColorState( OToggleButtonStyle.STATE_DISABLED, Color.DISABLED );

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