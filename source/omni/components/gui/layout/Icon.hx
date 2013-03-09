package omni.components.gui.layout;

import omni.utils.UtilBitmapData;
import omni.utils.BitmapScaleSliceUtily;
import omni.utils.ColorUtils;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
//import omni.utils.BitmapScaleSliceUtil;
import nme.Assets;
import nme.display.BitmapData;
import nme.display.Bitmap;
import omni.utils.ComponentUtils;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponent;
import omni.components.style.base.OBaseBackgroundStyle;

class Icon extends OComponent
{

//***********************************************************
//                  Public Variables
//***********************************************************

    public var bitmap:Bitmap;
    public var bitmapPadding(get_bitmapPadding, set_bitmapPadding):Int;

	public var resizeBitmapData:Bool;
	
//***********************************************************
//                  Style Variables
//***********************************************************

	public var _bitmapPadding:Int;

//***********************************************************
//                  Component Overrides
//***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        resizeBitmapData = true;
        _bitmapPadding = styleAs.defaultBitmapPadding;

        if(_bitmapPadding > 0 && styleAs.background == null )
        {
            styleAs.setBackgroundBrush(styleAs.defaultIconBGBrush());
        }

        if (styleAs.defaultBitmapData != null)
        {
            setBitmapData(styleAs.defaultBitmapData);

        } else if (styleAs.defaultBitmapDataPath != null)
        {
            setBitmapData(Assets.getBitmapData(styleAs.defaultBitmapDataPath)) ;
        }
    }

    override public function size(w:Float, h:Float):Void
    {
        if (_width != h || _height != h)
        {
            super._size(w, h);
            resizeBitmap();
        }
    }

    override public function drawMembers():Void
    {
//        super.drawMembers();

        if (bitmap != null && bitmapPadding != 0)
        {
            ComponentUtils.VAlignDisplayObjectToOther(bitmap, this.sprite);
            ComponentUtils.HAlignDisplayObjectToOther(bitmap, this.sprite);
        }
    }

//***********************************************************
//                  Component Methods
//***********************************************************

    public function setBitmapAsset(path:String, scaleToFit:Bool = true):Void
    {
        setBitmapData(Assets.getBitmapData(path), scaleToFit);
    }

    public function setBitmapData(bitmapData:BitmapData, scaleToFit:Bool = true, ?targetWidth:Float, ?targetHeight:Float):Void
    {
        if (targetWidth == null)
            targetWidth = width - bitmapPadding;

        if (targetHeight == null)
            targetHeight = height - bitmapPadding;

        if (scaleToFit)
        {
            setBitmap(UtilBitmapData.fitIntoRectBitmapData(bitmapData, Std.int(targetWidth), 
                                                                  Std.int(targetHeight)));
        } else
        {
            setBitmap(new Bitmap(bitmapData));
        }
    }

    public function setBitmap(bit:Bitmap, scaleToFit:Bool = true):Void
    {
        if (bitmap != null)
        {
            sprite.removeChild(bitmap);
            bitmap = null;
        }

        if (scaleToFit)
        {
            bitmap = UtilBitmapData.fitIntoRectBitmapData(bit.bitmapData, Std.int(width - bitmapPadding), Std.int(height - bitmapPadding));
        } else
        {
            bitmap = bit;
        }

        sprite.addChild(bitmap);

        _size(bitmap.width + bitmapPadding, bitmap.height + bitmapPadding);

        invalidate();
    }

//todo cache original for resizing??

    public function resizeBitmap():Void
    {
        if (resizeBitmapData)
        {
            setBitmap(bitmap, true);
        } else
        {
//todo
        }
    }

//***********************************************************
//                  Properties
//***********************************************************

    override public function set_height(h:Float):Float
    {
        if (_height != h)
        {
            resizeBitmap();
            return super.set_height(h);
        } else
        {
            return super.set_height(h);
        }
    }

    override public function set_width(w:Float):Float
    {
        if (_width != w)
        {
            resizeBitmap();
            return super.set_width(w);
        } else
        {
            return super.set_width(w);
        }
    }

    public function get_bitmapPadding():Int
    {
        return _bitmapPadding;
    }

    public function set_bitmapPadding(value:Int):Int
    {
        if (bitmapPadding != value)
        {
            _bitmapPadding = value;
            resizeBitmap();
        }
        return _bitmapPadding;
    }

//***********************************************************
//                  Component Style
//***********************************************************

    public var styleAs(get_styleAs, null):IconStyle;

    public function get_styleAs():IconStyle
    {
        return cast(_style, IconStyle);
    }

    override public function get_styleId():String
    {
        return IconStyle.styleString;
    }
}

class IconStyle extends OBaseBackgroundStyle
{
    public static var styleString:String = "IconStyle";

    public var defaultBitmapDataPath:String;
    public var defaultBitmapData:BitmapData;
    public var defaultScaleToFit:Bool;
    public var defaultBitmapPadding:Int;

    public function new()
    {
        super();
        styleID = styleString;
    }

    public function defaultIconBGBrush():BrushColorFill
    {
        var bgColor = new BrushColorFill ();
        bgColor.setColorState( OStates.ACTIVE, ColorUtils.BLACK );
        return bgColor;
    }
}