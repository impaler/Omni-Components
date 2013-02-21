package omni.components.gui.layout;

import omni.components.core.OContainer;
import omni.components.core.OLayout;
import omni.components.gui.controls.TabButton;
import omni.components.style.OBackgroundStyle;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.signals.OSignalType;
import omni.components.core.OComponent;

class TabbedContainer extends OContainer
{

	public var nextPage:ContainerPage = null;
	public var currentPage:ContainerPage = null;
	public var previousPage:ContainerPage = null;

	public var tabs:TabButtonGroup;

	public var onPageChange:OSignalType<ContainerPage -> Void>;

//***********************************************************
//                  Component Core
//***********************************************************

	override public function createMembers( ):Void
	{
		super.createMembers();
		
		tabs = new TabButtonGroup();
		tabs.onTabButtonChange.add( handleTabChange );
		this.sprite.addChild( tabs.sprite );

		onPageChange = new OSignalType<ContainerPage -> Void>();

		_scrollRectEnabled = true;
	}
	
	override public function drawMembers( ):Void
	{
		super.drawMembers( );

		if(currentPage != null){
			currentPage._width = width;
			currentPage._height = height - tabs.height;
			currentPage.invalidate( );
		}
	}
	

	override public function add( comp:IOComponent ):IOComponent
	{
		this.components.push( comp );
		return comp;
	}

	override public function remove( comp:IOComponent ):Void
	{
		this.components.remove( comp );
	}

	override public function destroy( ):Void
	{
		onPageChange.destroy( );
		super.destroy( );
	}

//***********************************************************
//                  Component Methods
//***********************************************************

	public function handleTabChange( button:TabButton ):Void
	{
		openPage( button.containerPage );
	}

	public function addNewPage( ?name:String, ?pageStyle:IStyle ):ContainerPage
	{
		var newPage = new ContainerPage(pageStyle);
		if( name != null )
			newPage.title = name;
		addPage( newPage );

		return newPage;
	}

	public function addPage( page:ContainerPage ):ContainerPage
	{
		var button = tabs.addTabButton( page );
		page.pageButton = button;
		button.labelText = page.title;
		page.parentContainer = this;
		add( page );
		page.y = tabs._height;

		return page;
	}

	public function removePage( page:ContainerPage ):Void
	{
		remove( page );
	}

	public function openPage( page:ContainerPage ):Void
	{
		if( currentPage != page )
		{
			if( currentPage != null )
			{
				previousPage = currentPage;
				currentPage.onClosed.addOnce( handlePageClose );
				currentPage.close( );
			}

			nextPage = page;
			nextPage.onOpened.addOnce( handlePageOpened );
			nextPage.open( );
		}
	}

	public function openNextPage( ):Void
	{
		if( getNext( ) != null )
			openPage( getNext( ) );
	}

	public function getNext( ):ContainerPage
	{
		var currentIndex = Lambda.indexOf( components, currentPage );
		return cast(components[currentIndex + 1], ContainerPage);
	}

	public function handlePageClose( page:ContainerPage ):Void
	{
		page = null;
		nextPage = null;
		currentPage = nextPage;
	}

	public function handlePageOpened( page:ContainerPage ):Void
	{
		invalidate();
		onPageChange.dispatch( cast(page, ContainerPage) );
		currentPage = page;
		tabs.setActiveButton( page.pageButton );
	}

	public function getPageByName( name:String ):ContainerPage
	{
		for( o in components )
		{
			var page = cast(o, ContainerPage);
			if( page.title == name ) return page;
		}
		return null;
	}

//***********************************************************
//                  Component Style
//***********************************************************

	override public function get_styleId( ):String
	{
		return TabbedContainerStyle.styleString;
	}

}

class TabbedContainerStyle extends OBackgroundStyle
{
	public static var styleString:String = "TabbedContainerStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}
