package omni.components.gui.layout;

import omni.components.gui.controls.TabButton;
import omni.components.style.OBackgroundStyle;
import omni.components.core.signals.OSignalType;
import omni.components.core.OComponent;

class ContainerPage extends OComponent
{
	public var onClosed:OSignalType<ContainerPage -> Void>;
	public var onOpened:OSignalType<ContainerPage -> Void>;

	public var pageName(getPageName, setPageName):String;
	public var _pageName:String;

	public var container:TabbedContainer;
	public var pageButton:TabButton;

	override public function createMembers( ):Void
	{
		onClosed = new OSignalType<ContainerPage -> Void>();
		onOpened = new OSignalType<ContainerPage -> Void>();
	}

	override public function destroy( ):Void
	{
		onClosed.destroy( );
		onOpened.destroy( );
		super.destroy( );
	}

	public function open( ):Void
	{
		container.sprite.addChild( this.sprite );
		onOpened.dispatch( this );
	}

	public function close( ):Void
	{
		container.sprite.removeChild( this.sprite );
		onClosed.dispatch( this );
	}

	public function getPageName( ):String
	{
		if( _pageName == null )
		{
			_pageName = Std.string( compId );
		}

		return _pageName;
	}

	public function setPageName( value:String ):String
	{
		if( _pageName == null )
		{
			_pageName = value;
		}
		return _pageName;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function getStyleId( ):String
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
