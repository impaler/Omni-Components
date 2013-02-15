package omni.components.gui.layout;

import nme.Assets;
import nme.display.BitmapData;
import nme.display.Bitmap;
import omni.utils.ComponentUtils;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.style.OBackgroundStyle;

class Icon extends OComponent
{

	private var bitmap:Bitmap;

	public function setBitmapAsset( path:String, scaleToFit:Bool = false ):Void
	{
		setBitmapData( Assets.getBitmapData( path ), scaleToFit );
	}

	public function setBitmapData( bitmapData:BitmapData, scaleToFit:Bool = false ):Void
	{
//todo scaleToFit
		bitmap = new Bitmap(bitmapData);

		sprite.addChild( bitmap );
	}

	override public function drawMembers( ):Void
	{
		if( bitmap != null )
		{
			ComponentUtils.VAlignDisplayObjectToOther( bitmap, this.sprite );
			ComponentUtils.HAlignDisplayObjectToOther( bitmap, this.sprite );
		}
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return IconStyle.styleString;
	}
}

class IconStyle extends OBackgroundStyle
{
	public static var styleString:String = "IconStyle";

	public static var STATE_OVER:String = "STATE_OVER";
	public static var STATE_DOWN:String = "STATE_DOWN";

	public var bitmapPath:String;
	public var bitmapData:BitmapData;

	public function new( )
	{
		super( );
		styleID = styleString;
	}

	override public function initStyle( value:IOComponent ):Void
	{
//todo load the style bitmaps etc
		super.initStyle( value );
	}

}