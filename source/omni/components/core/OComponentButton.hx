package omni.components.core;

import omni.utils.UtilPosition;
import omni.components.core.interfaces.IBrush;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OLayout;
import nme.display.BitmapData;
import omni.utils.OStates;
import omni.utils.ComponentUtils;
import omni.components.gui.layout.Icon.IconStyle;
import omni.components.gui.layout.Icon;
import omni.components.gui.text.Label;
import omni.components.core.OButtonBase;
import omni.components.style.base.OBaseBackgroundStyle;

class OComponentButton extends OButtonBase
{

//***********************************************************
//                  Public Variables
//***********************************************************

    public var layout:OLayout;

//***********************************************************
//                  Style Variables
//***********************************************************

    public var sizeMethodWidth(default, set_sizeMethodWidth):String;
    public var sizeMethodHeight(default, set_sizeMethodHeight):String;

//***********************************************************
//                  Component Overrides
//***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        sizeMethodWidth = styleAsComponentButton.defaultSizeMethodWidth;
        sizeMethodHeight = styleAsComponentButton.defaultSizeMethodHeight;

        layout = new OLayout(styleAsComponentButton.layoutStyle);

        coreAdd(layout);
        addToMembers(layout);
    }

    override public function add(comp:IOComponent):IOComponent
    {
        layout.add(comp);
        return comp;
    }

    override public function remove(comp:IOComponent):Void
    {
        layout.remove(comp);
    }

    override public function addAt(comp:IOComponent, index:Int):IOComponent
    {
        layout.addAt(comp, index);
        return comp;
    }

    override public function getMemberIndex(comp:IOComponent):Int
    {
        return Lambda.indexOf(layout.members, comp);
    }

    override public function drawPostStyle():Void
    {
        if (sizeMethodWidth == OStates.AUTO)
        {
            scrollRectEnabled = false;
	        layout.x = padding;
        }
        else if (sizeMethodWidth == OStates.FIXED)
        {
            scrollRectEnabled = true;

            if (layout.width < _width)
                UtilPosition.HAlignToOther(layout, this);
        }

        if (sizeMethodHeight == OStates.AUTO)
        {
            this._height = layout.height;
        }
        else if (sizeMethodHeight == OStates.FIXED)
        {
            if (layout.height < _height)
                UtilPosition.VAlignToOther(layout, this);
        }
    }

//***********************************************************
//                  Properties
//***********************************************************

    public function set_sizeMethodWidth(value:String):String
    {
        if (sizeMethodWidth != value)
        {
            sizeMethodWidth = value;
            if (sizeMethodWidth == OStates.AUTO)
            {
                scrollRectEnabled = false;
            }
            else if (sizeMethodWidth == OStates.FIXED)
            {
                scrollRectEnabled = true;
            }
            invalidate();
        }
        return sizeMethodWidth;
    }

    public function set_sizeMethodHeight(value:String):String
    {
        if (sizeMethodHeight != value)
        {
            sizeMethodHeight = value;
            if (sizeMethodHeight == OStates.AUTO)
            {
                scrollRectEnabled = false;
            }
            else if (sizeMethodHeight == OStates.FIXED)
            {
                scrollRectEnabled = true;
            }
            invalidate();
        }
        return sizeMethodHeight;
    }

    override public function get_width():Float
    {
        if (sizeMethodWidth == OStates.AUTO)
        {
            return layout.width  + padding * 2;
        } else
        {
            return super.get_width();
        }
    }

    override public function get_height():Float
    {
        if (sizeMethodHeight == OStates.AUTO)
        {
            return layout.height + padding * 2;
        } else
        {
            return super.get_height();
        }
    }

//***********************************************************
//                  Component Style
//***********************************************************

    private var styleAsComponentButton(get_styleAsComponentButton, null):OComponentButtonStyle;

    private function get_styleAsComponentButton():OComponentButtonStyle
    {
        return cast(_style, OComponentButtonStyle);
    }

    override public function get_styleId():String
    {
        return OComponentButtonStyle.styleString;
    }
}

class OComponentButtonStyle extends OButtonBaseStyle
{
    public static var styleString:String = "OComponentButtonStyle";

    public var defaultSizeMethodWidth:String;
    public var defaultSizeMethodHeight:String;

    public var layoutStyle:OComponentButtonLayoutStyle;

    public function new()
    {
        super();
        styleID = styleString;
    }

}

class OComponentButtonLayoutStyle extends OLayoutStyle
{
    public static var styleString:String = "OComponentButtonLayoutStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}