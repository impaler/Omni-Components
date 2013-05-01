package omni.components.core;

import omni.components.gui.controls.SelectList;
import omni.components.gui.controls.Button;
import omni.components.gui.controls.Slider;
import omni.components.gui.layout.VBox;
import omni.components.gui.layout.HBox;
import omni.components.core.interfaces.IStyle;
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

    public var heightSizeMethod(get_heightSizeMethod, set_heightSizeMethod):String;
    public var widthSizeMethod(get_widthSizeMethod, set_widthSizeMethod):String;

    public var hAlign(get_hAlign, set_hAlign):String;
    public var vAlign(get_vAlign, set_vAlign):String;

    public var topPadding(get_topPadding, set_topPadding):Int;
    public var bottomPadding(get_bottomPadding, set_bottomPadding):Int;
    public var leftPadding(get_leftPadding, set_leftPadding):Int;
    public var rightPadding(get_rightPadding, set_rightPadding):Int;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        var layoutstyle = styleAsComponentButton.deafultLayoutStyle;

        if (layoutstyle.defaultDirection == null)
            throw "OComponent Button style requires a defaultDirection of OStates.HORIZONTAL or OStates.VERTICAL";

        if (layoutstyle.defaultDirection == OStates.HORIZONTAL)
        {
            layout = new HBox(styleAsComponentButton.deafultLayoutStyle);
        }
        else if (layoutstyle.defaultDirection == OStates.VERTICAL)
        {
            layout = new VBox(styleAsComponentButton.deafultLayoutStyle);
        }

        coreAdd(layout);
        addToMembers(layout);
    }

    override public function drawMembers():Void
    {
        super.drawMembers();

        layout.drawNow();

        _width = layout.width;
        _height = layout.height;
    }

    override public function add(comp:IOComponent):IOComponent
    {
        layout.add(comp);
        drawNow();
        return comp;
    }

    override public function addType(comp:Class<IOComponent>, ?style:IStyle = null):Dynamic
    {
        return layout.addType(comp, style);
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

    //***********************************************************
    //                  Properties
    //***********************************************************

    override public function set__width(w:Float):Float
    {
        return layout != null ? layout.set__width(w) : 0;
    }

    override public function get_width():Float
    {
        return layout.get_width();
    }

    override public function set__height(h:Float):Float
    {
        return layout != null ? layout.set__height(h) : 0;
    }

    override public function get_height():Float
    {
        return layout.get_height();
    }

    public function set_heightSizeMethod(value:String):String
    {
        return layout.set_heightSizeMethod(value);
    }

    public function get_heightSizeMethod():String
    {
        return layout._heightSizeMethod;
    }

    public function set_widthSizeMethod(value:String):String
    {
        return layout.set_widthSizeMethod(value);
    }

    public function get_widthSizeMethod():String
    {
        return layout._widthSizeMethod;
    }

    public function set_hAlign(value:String):String
    {
        return layout.set_hAlign(value);
    }

    public function get_hAlign():String
    {
        return layout.get_hAlign();
    }

    public function set_vAlign(value:String):String
    {
        return layout.set_vAlign(value);
    }

    public function get_vAlign():String
    {
        return layout.get_vAlign();
    }

    public function set_rightPadding(value:Int):Int
    {
        return layout.set_rightPadding(value);
    }

    public function get_rightPadding():Int
    {
        return layout.get_rightPadding();
    }

    public function set_leftPadding(value:Int):Int
    {
        return layout.set_leftPadding(value);
    }

    public function get_leftPadding():Int
    {
        return layout.get_leftPadding();
    }

    public function set_bottomPadding(value:Int):Int
    {
        return layout.set_bottomPadding(value);
    }

    public function get_bottomPadding():Int
    {
        return layout.get_bottomPadding();
    }

    public function set_topPadding(value:Int):Int
    {
        return layout.set_topPadding(value);
    }

    public function get_topPadding():Int
    {
        return layout.get_topPadding();
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

    public var defaultWidthSizeMethod:String;
    public var defaultHeightSizeMethod:String;

    public var deafultLayoutStyle:OComponentButtonLayoutStyle;

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