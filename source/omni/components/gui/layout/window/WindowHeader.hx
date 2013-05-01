package omni.components.gui.layout.window;

import omni.utils.OStates;
import omni.components.gui.controls.Button;
import omni.components.gui.text.Label;
import omni.components.core.OTextBase;
import omni.utils.signals.OSignalMouse;
import omni.components.core.OButtonBase;
import omni.components.gui.layout.window.Window;

class WindowHeader extends OButtonBase
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var window:Window;

    public var leftLayout:HBox;
    public var rightLayout:HBox;

    public var closeButton:Button;
    public var maximizeButton:Button;
    public var minimizeButton:Button;

    public var title:Label;

    //***********************************************************
    //                  Style Variables
    //***********************************************************

    //***********************************************************
    //                  Signals
    //***********************************************************

    public var doubleClick:OSignalMouse;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        scrollRectEnabled = true;

        leftLayout = new HBox();

        leftLayout.mouseChildren = false;
        leftLayout.mouseEnabled = false;
        leftLayout.widthSizeMethod = OStates.AUTO;
        leftLayout.heightSizeMethod = OStates.FIXED;
        leftLayout.vAlign = OStates.MIDDLE;
        leftLayout._height = _height;

        title = leftLayout.addType(Label, styleAsWindow.titleLabelStyle);
        title.text = "Window Title";
        leftLayout.invalidateAdd();
        leftLayout.drawNow();
        add(leftLayout);

        rightLayout = new HBox();
        rightLayout.widthSizeMethod = OStates.AUTO;
        rightLayout.heightSizeMethod = OStates.FIXED;
        rightLayout._height = _height;

        if (styleAsWindow.minimizeButton != null)
        {
            minimizeButton = rightLayout.addType(Button, styleAsWindow.minimizeButton);
        }

        if (styleAsWindow.maximizeButton != null)
        {
            maximizeButton = rightLayout.addType(Button, styleAsWindow.maximizeButton);
        }

        if (styleAsWindow.closeButton != null)
        {
            closeButton = rightLayout.addType(Button, styleAsWindow.closeButton);
        }

        add(rightLayout);

        doubleClick = new OSignalMouse( OSignalMouse.DOUBLE_CLICK, this.sprite);
    }

    override public function enableSignals():Void
    {
        super.enableSignals();

        doubleClick.add(handleHeaderDoubleClick);

        if (minimizeButton != null)
            minimizeButton.onMouseDown.add(handlerMinimizeButtonDown);

        if (maximizeButton != null)
            maximizeButton.onMouseDown.add(handlerMaximizeButtonDown);

        if (closeButton != null)
            closeButton.onMouseDown.add(handlerCloseButtonDown);
    }

    override public function drawMembers():Void
    {
        super.drawMembers();

        rightLayout.drawNow();
        rightLayout.x = _width - rightLayout._width;
    }

    //***********************************************************
    //                  Event Handlers
    //***********************************************************

    public function handleHeaderDoubleClick(e:OSignalMouse):Void
    {
        window._maximized ? window.restore() : window.maximize();
    }

    public function handlerCloseButtonDown(e:OSignalMouse):Void
    {
        window.close();
    }

    public function handlerMaximizeButtonDown(?e:OSignalMouse):Void
    {
        window._maximized ? window.restore() : window.maximize();
    }

    public function handlerMinimizeButtonDown(?e:OSignalMouse):Void
    {
        window.minimize();
    }

    override public function handleMouseClick(?e:OSignalMouse):Void
    {
        onClick.dispatch(this);
    }

    override public function handleMouseDown(?e:OSignalMouse):Void
    {
        isDown = true;
    }

    override public function handleMouseUp(?e:OSignalMouse):Void
    {
        isDown = false;
    }

    override public function handleMouseOut(?e:OSignalMouse):Void
    {
        isOver = false;
    }

    override public function handleMouseOver(?e:OSignalMouse):Void
    {
        isOver = true;
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    public var styleAsWindow(get_styleAsWindow, null):WindowHeaderStyle;

    public function get_styleAsWindow():WindowHeaderStyle
    {
        return cast(_style, WindowHeaderStyle);
    }

    override public function get_styleId():String
    {
        return WindowHeaderStyle.styleString;
    }
}

class WindowHeaderStyle extends OButtonBaseStyle
{
    public static var styleString:String = "WindowHeaderStyle";

    public var titleLabelStyle:LabelStyle;
    public var closeButton:ButtonStyle;
    public var maximizeButton:ButtonStyle;
    public var minimizeButton:ButtonStyle;

    override public function new()
    {
        super();
        styleID = styleString;
    }
}