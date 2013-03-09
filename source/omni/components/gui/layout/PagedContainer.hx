package omni.components.gui.layout;

import nme.geom.Rectangle;
import omni.components.core.OContainer;
import omni.components.core.OLayout;
import omni.components.gui.controls.TabButton;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.signals.OSignalType;
import omni.components.core.OComponent;

class PagedContainer extends OContainer
{

//***********************************************************
//                  Public Variables
//***********************************************************

	public var nextPage:ContainerPage = null;
	public var currentPage:ContainerPage = null;
	public var previousPage:ContainerPage = null;

	public var tabs:TabButtonGroup;

	public var onPageChange:OSignalType<ContainerPage -> Void>;

//***********************************************************
//                  Component Overrides
//***********************************************************

	override public function createMembers( ):Void
	{
		super.createMembers();
		
		tabs = new TabButtonGroup();
		tabs.onTabButtonChange.add( handleTabChange );
		tabs.height = 50;
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
			currentPage.y = tabs.height;
			currentPage.invalidate( );
		}
	}

	override public function add( comp:IOComponent ):IOComponent
	{
		this.members.push( comp );
		return comp;
	}

	override public function remove( comp:IOComponent ):Void
	{
		this.members.remove( comp );
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
		button.text = page.title;
		tabs.drawNow();
		
		page.parentContainer = this;
		add( page );

		openPage(page);
		
		return page;
	}

	public function getPage( pageName:String ):ContainerPage
	{
		for( o in members )
		{
			var page = cast(o, ContainerPage);
			if (page.title == pageName)
				return page;
		}
		return null;
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

	public function openFirstPage( ):Void
	{
		if( members[0] != null )
			openPage( cast (members[0], ContainerPage)  );
	}
	
	public function openNextPage( ):Void
	{
		if( getNext( ) != null )
			openPage( getNext( ) );
	}
	
	public function openPreviousPage( ):Void
	{
		if( getPrevious( ) != null )
			openPage( getPrevious( ) );
	}
	
	public function getNext( ):ContainerPage
	{
		var currentIndex = Lambda.indexOf( members, currentPage );
		if(members[currentIndex + 1] == null)
		{
			return cast(members[0], ContainerPage);
		} else {
			return cast(members[currentIndex + 1], ContainerPage);
		}
	}
	
	public function getPrevious( ):ContainerPage
	{
		var currentIndex = Lambda.indexOf( members, currentPage );
		if(members[currentIndex - 1] == null)
		{
			return cast(members[members.length-1], ContainerPage);
		} else {
			return cast(members[currentIndex - 1], ContainerPage);
		}
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
		tabs.setActiveButton( page.pageButton );
		currentPage = page;
	}

	public function getPageByName( name:String ):ContainerPage
	{
		for( o in members )
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
		return PagedContainerStyle.styleString;
	}

}

class PagedContainerStyle extends OContainerStyle
{
	public static var styleString:String = "PagedContainerStyle";

	public function new( )
	{
		super( );
		styleID = styleString;
	}
}
