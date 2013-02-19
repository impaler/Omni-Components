package omni.components.theme.color.layout;

import omni.components.theme.color.core.ColorWindowScalerButton;
import omni.components.theme.color.core.ColorOComponent;
import omni.components.theme.color.core.ColorOButtonBase;
import omni.components.gui.layout.Window.WindowStyle;
import omni.components.core.OStates;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OLayout;
import omni.components.core.OLayout.OLayoutStyle;
import omni.utils.ColorUtils;
import nme.geom.Rectangle;

class ColorWindow extends WindowStyle
{

	public function new( )
	{
		super( );

		header = new ColorOComponent();
		footer = new ColorOComponent();

		scalerButton = new ColorWindowScalerButton();

		var bgColor = new BrushColorFill ();
		bgColor.setColorState( OStates.ACTIVE, Colors.ACTIVE );
		setBackgroundBrush( bgColor );

		defaultWidth = 300;
		defaultHeight = 300;

		maxWidth = 680;
		maxHeight = 680;
		minHeight = 200;
		minWidth = 200;
	}

}
