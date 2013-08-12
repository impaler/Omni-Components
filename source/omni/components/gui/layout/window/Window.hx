package omni.components.gui.layout.window;

import omni.utils.UtilNumbers;
import omni.components.gui.layout.window.WindowMiddleBG.WindowMiddleBGStyle;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.ODrawable.ODrawable;
import omni.components.core.ODrawable.ODrawableStyle;
import omni.components.gui.layout.window.WindowFooter.WindowFooterStyle;
import omni.components.gui.layout.window.WindowHeader.WindowHeaderStyle;
import omni.components.gui.layout.containers.PagedContainer;
import omni.components.core.OContainerContent;
import omni.utils.OStates;
import omni.utils.UtilSize.Dimension;
import omni.utils.UtilSize.Position;
import omni.components.core.OContainer;
import omni.utils.signals.OCoreEvent;
import omni.components.core.OCore;
import omni.components.core.OComponent;
import omni.components.core.OButtonBase;
import omni.components.core.OLayout;
import omni.utils.signals.OSignalType;
import omni.utils.signals.OSignalMouse;
import omni.components.style.base.OBaseBackgroundStyle;
import flash.Lib;

import flash.events.MouseEvent;

class Window extends OComponent
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var onOpened:OSignalType<Window -> Void>;
    public var onClosed:OSignalType<Window -> Void>;

    public var onStageResize:OCoreEvent;
    public var onResizeDragRender:OCoreEvent;
    public var onMouseDownHeader:OSignalMouse;
    public var onMouseMove:OSignalMouse;
    public var onMouseUp:OSignalMouse;

    public var content:OContainer;
    public var paged:PagedContainer;

    public var header:WindowHeader;
    public var footer:WindowFooter;
    public var middleBG:WindowMiddleBG;
    public var scalerButton:OButtonBase;

    //***********************************************************
    //                  Style Variables
    //***********************************************************

    public var moveable:Bool;
    public var resizeable:Bool;
    public var liveResize:Bool;
    public var resizeBehaviour:String;

    public var containerTopPadding:Int;
    public var containerLeftPadding:Int;
    public var containerRightPadding:Int;
    public var contentAreaYPos:Int;

    //***********************************************************
    //                  Private Variables
    //***********************************************************

    private var _resizing:Bool = false;
    private var _xOffset:Float = 0;
    private var _yOffset:Float = 0;
    private var _previousSize:Dimension;
    private var _previousPosition:Position;
    private var _previousMaxWidth:Float;
    private var _previousMaxHeight:Float;
    public var _maximized:Bool = false;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        moveable = styleAsWindow.moveable;
        resizeable = styleAsWindow.resizeable;
        liveResize = styleAsWindow.liveResize;
        containerLeftPadding = styleAsWindow.containerLeftPadding;
        containerRightPadding = styleAsWindow.containerRightPadding;
        containerTopPadding = styleAsWindow.containerTopPadding;
        resizeBehaviour = styleAsWindow.resizeBehaviour;

        footer = new WindowFooter(styleAsWindow.footer);
        addToMembers(footer);
        coreAdd(footer);

        scalerButton = new OButtonBase(styleAsWindow.scalerButton);
        addToMembers(scalerButton);
        coreAdd(scalerButton);

        middleBG = new WindowMiddleBG(styleAsWindow.middlebg);
        coreAdd(middleBG);

        onResizeDragRender = new OCoreEvent(OCoreEvent.ENTER_FRAME, this.sprite);
        onMouseMove = OCore.instance.onStageMouseMove;
        onMouseUp = OCore.instance.onStageMouseUp;

        header = new WindowHeader(styleAsWindow.header);
        header.window = this;

        //contentAreaYPos = 20;
        contentAreaYPos = Std.int(header.height);


        addToMembers(header);
        coreAdd(header);
        header.buttonMode = true;

        onMouseDownHeader = new OSignalMouse(OSignalMouse.MOUSE_DOWN, header.sprite);
        onOpened = new OSignalType<Window -> Void>();
        onClosed = new OSignalType<Window -> Void>();

        if (Type.getClassName(styleAsWindow.containerDefault) == Type.getClassName(WindowTabbedContainer))
        {
            setPagedContainer(cast ( Type.createInstance(styleAsWindow.containerDefault, [null]), PagedContainer));
        }
        else
        {
            setContainerType(styleAsWindow.containerDefault).disableSignals();
        }

        setupResizeBehavior();
    }

    public function setupResizeBehavior():Void
    {
        onStageResize = OCore.instance.onStageResize;
        onStageResize.add(handleStageResize);
    }

    public function handleStageResize(e:OCoreEvent):Void
    {
        if (resizeBehaviour == OStates.FIT && _maximized)
        {
            maxHeight = Lib.current.stage.stageHeight;
            maxWidth = Lib.current.stage.stageWidth;

            move(0, 0);
            size(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
            _maximized = true;
        }
    }

    override public function add(comp:IOComponent):IOComponent
    {
        content.add(comp);
        return comp;
    }

    override public function drawMembers():Void
    {
        super.drawMembers();

        footer.width = _width;
        footer.y = _height - footer.height;
        footer.drawNow();

        if(paged!=null)
        paged.tabs.width = _width -70;

        header.width = _width;
        header.drawNow();

        if (!_resizing)
            scalerButton.move(_width - scalerButton._width, _height - scalerButton._height);

        content._height = height - footer.height - contentAreaYPos;
        content._width = width - containerLeftPadding - containerRightPadding;
        content.y = contentAreaYPos;
        content.x = containerLeftPadding;
        content.drawNow();

        var heightOffsetTop = header.height;
        var heightOffsetBottom = footer.height;
        middleBG.width = _width;
        middleBG.height = _height - heightOffsetTop - heightOffsetBottom;
        middleBG.y = heightOffsetTop;
        middleBG.drawNow();
    }

    override public function enableSignals():Void
    {
        onMouseDownHeader.add(handleStartWindowDrag);
        scalerButton.onMouseDown.add(handleScaleWindowMouseDown);
    }

    override public function destroy():Void
    {
        //todo
        //	public var onStageResize:OCoreEvent;
        //public var onResizeDragRender:OCoreEvent;
        //public var onMouseDownHeader:OSignalMouse;
        //public var onMouseMove:OSignalMouse;
        //public var onMouseUp:OSignalMouse;
    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public function open():Void
    {
        if (this.sprite.parent == null)
        {
            OCore.addChild(this);
        }
        onOpened.dispatch(this);

        if (paged != null)
        {
            if (paged.currentPage == null)
                paged.openFirstPage();
        }
    }

    public function close(destroy:Bool = false):Void
    {
        if (this.sprite.parent != null)
        {
            OCore.removeChild(this);
        }
        onClosed.dispatch(this);

        if (destroy)
            this.destroy();
    }

    public function maximize():Void
    {
        _previousSize = { width : width, height : height };
        _previousPosition = { x : x, y : y };

        _previousMaxHeight = maxHeight;
        maxHeight = Lib.current.stage.stageHeight;

        _previousMaxWidth = maxWidth;
        maxWidth = Lib.current.stage.stageWidth;

        visible = false;
        move(0, 0);
        size(Lib.current.stage.stageWidth, Lib.current.stage.stageHeight);
        visible = true;
        _maximized = true;

        if (liveResize)
            scalerButton.visible = false;
    }

    public function restore():Void
    {
        if (_previousSize != null)
        {
            maxHeight = _previousMaxHeight;
            maxWidth = _previousMaxWidth;
            size(_previousSize.width, _previousSize.height);

            if (liveResize)
                scalerButton.visible = true;
        }
        if (_previousPosition != null)
        {
            move(_previousPosition.x, _previousPosition.y);
        }

        _maximized = false;
    }

    public function minimize():Void
    {
        //todo
    }

    public function setContainer(containerInstance:OContainer):OContainer
    {
        destroyExistingContainer();

        content = containerInstance;
        content.scrollRectEnabled = true;
        coreAdd(containerInstance);

        invalidate();

        return containerInstance;
    }

    public function setPagedContainer(containerInstance:PagedContainer):PagedContainer
    {
        paged = containerInstance;
        setContainer(paged);

        return containerInstance;
    }

    public function setPagedContainerType(type:Class<PagedContainer>, ?style:IStyle = null):PagedContainer
    {
        paged = Type.createInstance(type, [style]);
        setContainer(paged);

        return paged;
    }

    public function setContainerType(type:Class<OContainer>):OContainer
    {
        var containerInstance = Type.createInstance(type, [null]);
        setContainer(containerInstance);

        return containerInstance;
    }

    public function destroyExistingContainer():Void
    {
        if (content != null)
        {
            remove(content);
            content.destroy();
            content = null;
        }
    }

    //***********************************************************
    //                  Event Handlers
    //***********************************************************

    private function handleStartWindowDrag(?e:OSignalMouse):Void
    {
        if (moveable && !_maximized)
        {
            _xOffset = e.event.stageX - this.x;
            _yOffset = e.event.stageY - this.y;
            onMouseMove.add(handleWindowDragMouseMove);
            onMouseUp.add(handleWindowDragMouseUp);
        }
    }

    private function handleWindowDragMouseMove(?e:OSignalMouse):Void
    {
        this.x = e.event.stageX - _xOffset;
        this.y = e.event.stageY - _yOffset;
        e.updateAfterEvent();
    }

    private function handleWindowDragMouseUp(?e:OSignalMouse):Void
    {
        var boundsTolerance = 40;

        if (y < 0)
        {
            y = 0;
        }
        else if (y > Lib.current.stage.stageHeight - boundsTolerance)
        {
            y = (Lib.current.stage.stageHeight - header._height );
        }

        if (x < 0 - (_width - boundsTolerance))
        {
            x = 0;
        }
        else if (x > Lib.current.stage.stageWidth - boundsTolerance)
        {
            x = Lib.current.stage.stageWidth - _width;
        }

        onMouseMove.remove(handleWindowDragMouseMove);
        onMouseUp.remove(handleWindowDragMouseUp);
    }

    private function handleScaleWindowMouseDown(?e:OSignalMouse):Void
    {
        if (liveResize && !_maximized)
        {
            _resizing = true;

            _xOffset = e.event.stageX - (scalerButton.x);
            _yOffset = e.event.stageY - (scalerButton.y);

            onMouseUp.addOnce(handleScaleWindowMouseUp);
            onResizeDragRender.add(handleScaleWindowResize);
        }
    }

    private function handleScaleWindowResize(e:OCoreEvent):Void
    {
        var targetX = Std.int(Lib.current.stage.mouseX - _xOffset);

        if (targetX > Std.int(maxWidth - scalerButton.width))
        {
            targetX = Std.int(maxWidth - scalerButton.width);
        }
        else if (targetX < Std.int(minWidth - scalerButton.width))
        {
            targetX = Std.int(minWidth - scalerButton.width);
        }

        var targetY = Std.int(Lib.current.stage.mouseY - _yOffset);

        if (targetY > Std.int(maxHeight - scalerButton.height))
        {
            targetY = Std.int(maxHeight - scalerButton.height);
        }
        else if (targetY < Std.int(minHeight - scalerButton.height))
        {
            targetY = Std.int(minHeight - scalerButton.height);
        }

        scalerButton.x = targetX;
        scalerButton.y = targetY;

        _size(scalerButton.x + scalerButton.width, scalerButton.y + scalerButton.height);
        drawNow();
    }

    private function handleScaleWindowMouseUp(e:OSignalMouse):Void
    {
        _resizing = false;

        onResizeDragRender.remove(handleScaleWindowResize);
        size(scalerButton.x + scalerButton.width, scalerButton.y + scalerButton.height);
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    public var styleAsWindow(get_styleAsWindow, null):WindowStyle;

    public function get_styleAsWindow():WindowStyle
    {
        return cast(_style, WindowStyle);
    }

    override public function get_styleId():String
    {
        return WindowStyle.styleString;
    }

}

class WindowStyle extends OBaseBackgroundStyle
{
    public static var styleString:String = "WindowStyle";

    public var scalerButton:OButtonBaseStyle;
    public var header:WindowHeaderStyle;
    public var footer:WindowFooterStyle;

    public var containerDefault:Class<OContainer>;

    public var middlebg:WindowMiddleBGStyle;

    public var moveable:Bool;
    public var resizeable:Bool;
    public var liveResize:Bool;

    public var containerTopPadding:Int;
    public var containerLeftPadding:Int;
    public var containerRightPadding:Int;
    public var resizeBehaviour:String;

    public function new()
    {
        super();
        styleID = styleString;
    }
}
