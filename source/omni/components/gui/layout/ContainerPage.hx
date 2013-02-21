package omni.components.gui.layout;

import omni.components.gui.controls.TabButton;
import omni.components.style.OBackgroundStyle;
import omni.components.core.signals.OSignalType;
import omni.components.core.OComponent;

class ContainerPage extends OComponent
{
	public var onClosed:OSignalType<ContainerPage -> Void>;
	public var onOpened:OSignalType<ContainerPage -> Void>;

	public var title(get_pageName, set_pageName):String;
	public var _title:String;

	public var parentContainer:TabbedContainer;
	public var pageButton:TabButton;
	
	public var container:ContentContainer;

	override public function createMembers( ):Void
	{
		onClosed = new OSignalType<ContainerPage -> Void>();
		onOpened = new OSignalType<ContainerPage -> Void>();
		
		container = new ContentContainer();
		container.parent = this;
	}
	
	override public function drawMembers( ):Void
	{
		super.drawMembers( );

		if(container.container != null){
			container.container._width = width;
			container.container._height = height;
			container.container.invalidate( );
		}
	}
	
	override public function destroy( ):Void
	{
		onClosed.destroy( );
		onOpened.destroy( );
		super.destroy( );
	}

	public function open( ):Void
	{
		parentContainer.sprite.addChild( this.sprite );
		onOpened.dispatch( this );
	}

	public function close( ):Void
	{
		parentContainer.sprite.removeChild( this.sprite );
		onClosed.dispatch( this );
	}

	public function get_pageName( ):String
	{
		if( _title == null )
		{
			_title = Std.string( compId );
		}

		return _title;
	}

	public function set_pageName( value:String ):String
	{
		if( _title == null )
		{
			_title = value;
		}
		return _title;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return ContainerPageStyle.styleString;
	}

}

class ContainerPageStyle extends OBackgroundStyle
{
	public static var styleString:String = "ContainerPageStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}
