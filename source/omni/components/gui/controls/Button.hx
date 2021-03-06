package omni.components.gui.controls;

import omni.components.core.interfaces.IOComponent;
import omni.components.core.OComponentButton;
import omni.components.core.OComponentButton.OComponentButtonStyle;
import omni.components.gui.layout.Icon.IconStyle;
import omni.components.gui.layout.Icon;
import omni.components.gui.text.Label;

import flash.display.BitmapData;

class Button extends OComponentButton
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var label:Label;

    public var text(get_text, set_text):String;
    public var _text:String = "";

    public var icon:Icon;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        if (styleAsButton.defaultIcon != null)
            createIcon();

        if (styleAsButton.defaultLabel != null || styleAsButton.defaultText != null)
            createLabel();
    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public function setIconFromPath(path:String, scaleToFit:Bool = true):Void
    {
        createIcon();
        icon.setBitmapAsset(path, scaleToFit);
        layout.widthInvalid = true;
        layout.heightInvalid = true;
        invalidate();
    }

    public function setIconFromBitmapData(path:BitmapData, scaleToFit:Bool = true):Void
    {
        createIcon();
        icon.setBitmapData(path, scaleToFit);
        layout.widthInvalid = true;
        layout.heightInvalid = true;
        invalidate();
    }

    public inline function createLabel():Void
    {
        if (label == null)
        {
            label = new Label(styleAsButton.defaultLabel);
            if(styleAsButton.defaultText != null)
                label._text = styleAsButton.defaultText;
            add(label);
        }
    }

    public inline function createIcon():Void
    {
        if (icon == null)
        {
            icon = new Icon(styleAsButton.defaultIcon);
            add(icon);
        }
    }

    public function removeIcon():Void
    {
        if (icon != null)
        {
            remove(icon);
            invalidate();
        }
    }

    public function removeLabel():Void
    {
        if (label != null)
        {
            remove(label);
            invalidate();
        }
    }


    //***********************************************************
    //                  Properties
    //***********************************************************

    public function set_text(value:String):String
    {
        if (_text != value)
        {
            createLabel();

            _text = value;
            label.text = _text;
            layout.widthInvalid = true;
            layout.heightInvalid = true;
            invalidate();
        }
        return _text;
    }

    public function get_text():String
    {
        return _text;
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    public var styleAsButton(get_styleAsButton, null):ButtonStyle;

    private function get_styleAsButton():ButtonStyle
    {
        return cast(_style, ButtonStyle);
    }

    override public function get_styleId():String
    {
        return ButtonStyle.styleString;
    }
}

class ButtonStyle extends OComponentButtonStyle
{
    public static var styleString:String = "ButtonStyle";

    public var defaultLabel:ButtonLabelStyle;
    public var defaultIcon:IconStyle;
    public var defaultText:String;

    public function new()
    {
        super();
        styleID = styleString;
    }
}

class ButtonLabelStyle extends LabelStyle
{

    public static var styleString:String = "ButtonLabelStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }

}