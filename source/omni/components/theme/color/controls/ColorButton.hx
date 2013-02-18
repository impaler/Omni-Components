package omni.components.theme.color.controls;

import omni.components.core.OStates;
import nme.Assets;
import omni.components.gui.layout.Icon.IconStyle;
import omni.components.gui.text.Label.LabelStyle;
import omni.components.gui.controls.Button.ButtonStyle;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.OBaseStyle;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.OComponentStyle;

class ColorButton extends ButtonStyle
{
	public function new( )
	{
		super( );

		var textStyle = new LabelStyle();
		textStyle.defaultText = "Button";
		textStyle.fontSize = 18;
		labelText = textStyle;

		var icon = new IconStyle();
//		icon.bitmap = Assets.getBitmapData("w");
//		icon.sprite = createTestIconSprite();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, Colors.ACTIVE );
		bgColor.setColorState( OStates.DISABLED, Colors.DISABLED );
		bgColor.setColorState( OStates.OVER, Colors.OVER );
		bgColor.setColorState( OStates.DOWN, Colors.DOWN );
		setBackgroundBrush( bgColor );

		defaultWidth = 200;
		defaultHeight = 50;
		minWidth = 10;
		minHeight = 10;
		maxWidth = 2000;
		maxHeight = 2000;
		defaultPadding = 0;

	}
}