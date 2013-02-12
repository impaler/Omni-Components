package omni.components.theme.color;

import omni.utils.ColorUtils;
import omni.components.core.OTheme;

class Color extends OTheme
{
	static public var DISABLED:Int = ColorUtils.LIGHT_ORANGE;
	static public var ACTIVE:Int = ColorUtils.DARKER_ORANGE;

	static public var ON:Int = ColorUtils.DARKER_ORANGE;
	static public var ON_OVER:Int = ColorUtils.HALO_ORANGE;
	static public var OFF:Int = ColorUtils.LIGHT_ORANGE;
	static public var OFF_OVER:Int = ColorUtils.ORANGE_BRIGHT;

	static public var OVER:Int = ColorUtils.ORANGE_BRIGHT;
	static public var DOWN:Int = ColorUtils.ORANGE;
	static public var BG:Int = ColorUtils.GRAY;
	static public var BG_LAYOUT:Int = ColorUtils.BLACK;

	public function new( )
	{
		super( );

		addStyle( ColorComponent );

		addStyle( ColorButtonBase );
		addStyle( ColorButton );
		addStyle( ColorToggleButton );
		addStyle( ColorCheckBox );
		addStyle( ColorRadioButton );
		addStyle( ColorRadioButtonGroup );

		addStyle( ColorLayout );
		addStyle( ColorHBox );
		addStyle( ColorVBox );

		addStyle( ColorSlider );

		addStyle( ColorScrollBar );
		addStyle( ColorScrollContainer );

		addStyle( ColorIcon );

		addStyle( ColorNumericStepper );

		addStyle( ColorTextBase );
		addStyle( ColorLabel );
		addStyle( ColorInputField );

	}
}