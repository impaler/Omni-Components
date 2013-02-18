package omni.components.gui.layout;

import omni.components.core.signals.OCoreEvent;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.OCore;
import omni.components.core.OComponent;
import omni.components.core.OButtonBase;
import omni.components.core.OLayout;
import omni.components.core.signals.OSignalType;
import omni.components.core.signals.OSignalMouse;
import omni.components.style.OBackgroundStyle;

class Window extends OComponent
{

	public var onOpened:OSignalType<Window -> Void>;
	public var onClosed:OSignalType<Window -> Void>;

	public var onResizeDragRender:OCoreEvent;
	public var onMouseDownHeader:OSignalMouse;
	public var onMouseMove:OSignalMouse;
	public var onMouseUp:OSignalMouse;

	public var _container:OLayout;

	public var header:OComponent;
	public var footer:OComponent;
	public var scalerButton:OButtonBase;

	public var moveable:Bool = true;
	public var resizeable:Bool = true;
	public var liveResize:Bool = true;
	public var _resizing:Bool = false;

	private var _xOffset:Float = 0;
	private var _yOffset:Float = 0;

//***********************************************************
//                  Component Core
//***********************************************************

	override public function createMembers( ):Void
	{
		var styleAs = cast(_style, WindowStyle);

		header = new OButtonBase(styleAs.header);
		add( header );

		footer = new OButtonBase(styleAs.footer);
		add( footer );

		scalerButton = new OButtonBase(styleAs.scalerButton);
		add( scalerButton );

		onOpened = new OSignalType<Window -> Void>();
		onClosed = new OSignalType<Window -> Void>();

		onResizeDragRender = new OCoreEvent(OCoreEvent.ENTER_FRAME, this.sprite);
		onMouseMove = OCore.instance.onStageMouseMove;
		onMouseUp = OCore.instance.onStageMouseUp;
		onMouseDownHeader = new OSignalMouse(OSignalMouse.DOWN, header.sprite);
	}

	override public function drawMembers( ):Void
	{
		super.drawMembers( );

		header.width = _width;
		footer.width = _width;
		footer.y = _height - footer.height;
		if( ! _resizing )
			scalerButton.move( _width - scalerButton._width, _height - scalerButton._height );

	}

	override public function enableSignals( ):Void
	{
		onMouseDownHeader.add( handleStartWindowDrag );
		scalerButton.mouseDown.add( handleScaleWindowMouseDown );
	}

//***********************************************************
//                  Event Handlers
//***********************************************************

	private function handleStartWindowDrag( ?e:OSignalMouse ):Void
	{
		if( moveable )
		{
			_xOffset = e.event.stageX - this.x;
			_yOffset = e.event.stageY - this.y;
			onMouseMove.add( handleWindowDragMouseMove );
			onMouseUp.add( handleWindowDragMouseUp );
		}
	}

	private function handleWindowDragMouseMove( ?e:OSignalMouse ):Void
	{
		this.x = e.event.stageX - _xOffset;
		this.y = e.event.stageY - _yOffset;
		e.updateAfterEvent( );
	}

	private function handleWindowDragMouseUp( ?e:OSignalMouse ):Void
	{
		onMouseMove.remove( handleWindowDragMouseMove );
		onMouseUp.remove( handleWindowDragMouseUp );
	}

	private function handleScaleWindowMouseDown( ?e:OSignalMouse ):Void
	{
		if( liveResize )
		{
			_resizing = true;

			_xOffset = e.event.stageX - (scalerButton.x);
			_yOffset = e.event.stageY - (scalerButton.y);

			onMouseUp.addOnce( handleScaleWindowMouseUp );
			onResizeDragRender.add( handleScaleWindowResize );
		}
	}

	private function handleScaleWindowResize( e:OCoreEvent ):Void
	{
		var targetX = Std.int( nme.Lib.stage.mouseX - _xOffset );

		if( targetX > Std.int( maxWidth - scalerButton.width ) )
		{
			targetX = Std.int( maxWidth - scalerButton.width );
		}
		else if( targetX < Std.int( minWidth - scalerButton.width ) )
		{
			targetX = Std.int( minWidth - scalerButton.width );
		}

		var targetY = Std.int( nme.Lib.stage.mouseY - _yOffset );

		if( targetY > Std.int( maxHeight - scalerButton.height ) )
		{
			targetY = Std.int( maxHeight - scalerButton.height );
		}
		else if( targetY < Std.int( minHeight - scalerButton.height ) )
		{
			targetY = Std.int( minHeight - scalerButton.height );
		}

		scalerButton.x = targetX;
		scalerButton.y = targetY;

		_size( scalerButton.x + scalerButton.width, scalerButton.y + scalerButton.height );
		drawNow( );
	}

	private function handleScaleWindowMouseUp( e:OSignalMouse ):Void
	{
		_resizing = false;

		onResizeDragRender.remove( handleScaleWindowResize );
		size( scalerButton.x + scalerButton.width, scalerButton.y + scalerButton.height );

	}

//***********************************************************
//                  Component Methods
//***********************************************************

	public function open( ):Void
	{
		onOpened.dispatch( this );
	}

	public function close( ):Void
	{
		onClosed.dispatch( this );
	}

	public function addContent( content:IOComponent ):Void
	{
		_container.add( content );
	}

	public function addScrollableLayout( ):Void
	{
//_container = new ScrollContainer();
//add( _container );
	}

	public function addTabbedScrollableLayout( ):Void
	{
//_container = new TabbedContainer();
//add( _container );
	}

	public function addNewPage( ?name:String, ?pageStyle:IStyle ):ContainerPage
	{
//if( Std.is( _container, TabbedContainer ))
//{
//_container.addNewPage( name, pageStyle );
//}

		return null;

	}

	public function addPage( page:ContainerPage ):ContainerPage
	{
//if(Std.is( _container, TabbedContainer ) )
//{
//_container.addPage( page );
//}
		return null;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return WindowStyle.styleString;
	}

}

class WindowStyle extends OBackgroundStyle
{
	public static var styleString:String = "WindowStyle";

	public var scalerButton:OButtonBaseStyle;
	public var header:OComponentStyle;
	public var footer:OComponentStyle;

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}
