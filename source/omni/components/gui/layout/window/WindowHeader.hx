package omni.components.gui.layout.window;

import omni.components.gui.text.Label;
import omni.components.core.OTextBase;
import omni.utils.signals.OSignalMouse;
import omni.components.core.OButtonBase;
import omni.components.gui.layout.window.Window;

class WindowHeader extends OButtonBase
{
    public var window:Window;

    public var leftLayout:HBox;
    public var rightLayout:HBox;

    public var closeButton:OButtonBase;
    public var maximizeButton:OButtonBase;
    public var minimizeButton:OButtonBase;

    public var title:Label;

    override public function createMembers():Void
    {
        super.createMembers();

        scrollRectEnabled = true;

        leftLayout = new HBox();
        add(leftLayout);

        title = leftLayout.addType(Label);
        title.text = "Window Title";
	    
	    this.mouseChildren = false;
	    
        rightLayout = new HBox();
        add(rightLayout);

        closeButton = rightLayout.addType(OButtonBase);
        closeButton.onMouseDown.add(handlerCloseButtonDown);

        maximizeButton = rightLayout.addType(OButtonBase);
        maximizeButton.onMouseDown.add(handlerMaximizeButtonDown);

        minimizeButton = rightLayout.addType(OButtonBase);
        minimizeButton.onMouseDown.add(handlerMinimizeButtonDown);

    }

    override public function drawMembers():Void
    {
        super.drawMembers();

        rightLayout.drawNow();
        rightLayout.x = _width - rightLayout._width;
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

    override public function handleMouseClick( ?e:OSignalMouse ):Void
    {
        onClick.dispatch( this );
    }

    override public function handleMouseDown( ?e:OSignalMouse ):Void
    {
        isDown = true;
    }

    override public function handleMouseUp( ?e:OSignalMouse ):Void
    {
        isDown = false;
    }

    override public function handleMouseOut( ?e:OSignalMouse ):Void
    {
        isOver = false;
    }

    override public function handleMouseOver( ?e:OSignalMouse ):Void
    {
        isOver = true;
    }

//***********************************************************
//                  Component Style
//***********************************************************

    override public function get_styleId( ):String
    {
        return WindowHeaderStyle.styleString;
    }
}

class WindowHeaderStyle extends OButtonBaseStyle
{
    public static var styleString:String = "WindowHeaderStyle";

    override public function new( )
    {
        super( );
        styleID = styleString;
    }
}