package omni.components.theme.color.layout;

import omni.components.core.OStates;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.Icon.IconStyle;

import nme.Assets;

class ColorIcon extends IconStyle
{
	public function new( )
	{
		super( );

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, Colors.BG );
		bgColor.setColorState( OStates.DISABLED, Colors.DISABLED );
		setBackgroundBrush( bgColor );

//todo test
//		bitmapPath = "asfasfs";
//		bitmapData = createBitmapDataTest();

		defaultWidth = 20;
		defaultHeight = 20;
		minWidth = 10;
		minHeight = 10;
		maxWidth = 2000;
		maxHeight = 2000;
		defaultPadding = 0;

	}
}