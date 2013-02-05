package omni.components.theme.android4;

import nme.geom.Rectangle;
import omni.components.theme.android4.Android4;
import omni.components.style.brush.BrushDrawTiles;
import nme.Assets;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.core.OButtonBase.OButtonBaseStyle;
import omni.components.style.OBaseStyle;
import omni.components.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.core.OComponent.ComponentStyle;

class Android4ButtonBase extends OButtonBaseStyle
{
	public function new()
	{
		super();

		var tile = new BrushDrawTiles();

		var rect = new Rectangle(0, 104, 356, 104);
		tile.addTile(OBaseStyle.STATE_ACTIVE, rect, Android4.MAIN_TILESHEET);

		//todo
		var rect = new Rectangle(0, 104, 356, 104);
		tile.addTile(OBaseStyle.STATE_DISABLED, rect, Android4.MAIN_TILESHEET);

		var rect = new Rectangle(0, 0, 356, 104);
		tile.addTile(OButtonBaseStyle.STATE_DOWN, rect, Android4.MAIN_TILESHEET);

		var rect = new Rectangle(0, 208, 356, 104);
		tile.addTile(OButtonBaseStyle.STATE_OVER, rect, Android4.MAIN_TILESHEET);

		setBackgroundBrush(tile);

		//autoset on  tile
		defaultWidth = 356;
		defaultHeight = 104;
		maxWidth = 356;
		maxHeight = 104;
		defaultPadding = 0;
	}

}