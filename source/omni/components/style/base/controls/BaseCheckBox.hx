package omni.components.style.base.controls;

import omni.components.style.base.BaseColors;
import omni.components.gui.controls.Button.ButtonLabelStyle;
import omni.utils.OStates;
import omni.components.gui.controls.CheckBox.CheckBoxStyle;
import omni.components.gui.controls.RadioButton.RadioButtonStyle;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.core.OToggleButton.OToggleButtonStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;

class BaseCheckBox extends CheckBoxStyle
{
	public function new( )
	{
		super( );

		var textStyle = new ButtonLabelStyle();
		textStyle.defaultText = "CheckBox!";
		textStyle.fontSize = 18;
		defaultLabel = textStyle;

		var bgColor = new BrushColorFill ();

		bgColor.setColorState( OStates.ON, BaseColors.ON );
		bgColor.setColorState( OStates.ON_OVER, BaseColors.ON_OVER );

		bgColor.setColorState( OStates.OFF, BaseColors.OFF_OVER );
		bgColor.setColorState( OStates.OFF_OVER, BaseColors.OFF_OVER );

		bgColor.setColorState( OStates.DISABLED, BaseColors.DISABLED );

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