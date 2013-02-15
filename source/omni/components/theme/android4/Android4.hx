package omni.components.theme.android4;

import omni.components.theme.color.controls.ColorScrollSlider;
import omni.components.theme.color.controls.ColorSlider;
import omni.components.theme.bloom.BloomScrollContainer;
import omni.components.theme.bloom.BloomScrollBar;
import omni.components.theme.bloom.BloomSlider;
import omni.components.theme.bloom.BloomLayout;
import omni.components.core.OTileSheet;
import omni.components.core.OTheme;

class Android4 extends OTheme
{
	static public var MAIN_TILESHEET:String = "MAIN";

	public function new( )
	{
		super( );

		OTileSheet.instance.add( MAIN_TILESHEET, "assets/themes/android4/Android4TileSheet.png" );

		addStyle( Android4ButtonBase );
		addStyle( BloomLayout );
		addStyle( ColorSlider );
		addStyle( ColorScrollSlider );
		addStyle( Android4ScrollContainer );

//		76px squares
	}

}