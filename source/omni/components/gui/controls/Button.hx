package omni.components.gui.controls;

import omni.utils.OStates;
import omni.components.core.OComponentButton;
import omni.components.core.OComponentButton.OComponentButtonStyle;
import omni.components.core.interfaces.IBrush;
import omni.components.core.interfaces.IOComponent;
import omni.utils.ComponentUtils;
import omni.components.gui.layout.Icon.IconStyle;
import omni.components.gui.layout.Icon;
import omni.components.gui.text.Label;
import omni.components.core.OButtonBase;
import omni.components.style.base.OBaseBackgroundStyle;

import nme.display.BitmapData;

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

        if (styleAsButton.defaultLabel != null)
            createLabel();
    }

//***********************************************************
//                  Component Methods
//***********************************************************

    public function setIconFromPath(path:String, scaleToFit:Bool = true):Void
    {
        createIcon();
        icon.setBitmapAsset(path, scaleToFit);
    }

    public function setIconFromBitmapData(path:BitmapData, scaleToFit:Bool = true):Void
    {
        createIcon();
        icon.setBitmapData(path, scaleToFit);
    }

    public inline function createLabel():Void
    {
        if (label == null)
        {
            label = new Label(styleAsButton.defaultLabel);
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

	public function set_text( value:String ):String
	{
		if( _text != value )
		{
			createLabel( );
			_text = value;
			label.text = _text;
			invalidate( );
		}
		return _text;
	}

	public function get_text( ):String
	{
		return _text;
	}

//***********************************************************
//                  Component Style
//***********************************************************

    private var styleAsButton(get_styleAsButton, null):ButtonStyle;

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