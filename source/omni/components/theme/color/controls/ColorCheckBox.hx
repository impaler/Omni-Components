package omni.components.theme.color.controls;

import omni.components.core.OStates;
import omni.components.gui.controls.CheckBox.CheckBoxStyle;
import omni.components.gui.controls.RadioButton.RadioButtonStyle;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.core.OToggleButton.OToggleButtonStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.OBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.ComponentStyle;

class ColorCheckBox extends CheckBoxStyle
{
	public function new( )
	{
		super( );

		var textStyle = new LabelStyle();
		textStyle.defaultText = "CheckBox!";
		textStyle.fontSize = 18;
		labelText = textStyle;

		var bgColor = new BrushColorFill ();

		bgColor.setColorState( OStates.ON, Colors.ON );
		bgColor.setColorState( OStates.ON_OVER, Colors.ON_OVER );

		bgColor.setColorState( OStates.OFF, Colors.OFF_OVER );
		bgColor.setColorState( OStates.OFF_OVER, Colors.OFF_OVER );

		bgColor.setColorState( OStates.DISABLED, Colors.DISABLED );

		setBackgroundBrush( bgColor );

		defaultState = OStates.OFF;

		defaultWidth = 200;
		defaultHeight = 50;
		minWidth = 10;
		minHeight = 10;
		maxWidth = 2000;
		maxHeight = 2000;
		defaultPadding = 0;
	}
}