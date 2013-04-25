package omni.components.gui.layout.containers;

import omni.components.core.OToggleButton;
import omni.components.core.OContainerPage;
import nme.geom.Rectangle;
import omni.components.core.OContainer;
import omni.components.core.OLayout;
import omni.components.gui.layout.window.TabButton;
import omni.components.style.base.OBaseBackgroundStyle;
import omni.components.core.interfaces.IStyle;
import omni.components.core.interfaces.IOComponent;
import omni.utils.signals.OSignalType;
import omni.components.core.OComponent;

class PagedContainer extends OContainer
{

    //***********************************************************
    //                  Public Variables
    //***********************************************************

    public var nextPage:OContainerPage = null;
    public var currentPage:OContainerPage = null;
    public var previousPage:OContainerPage = null;

    public var tabs:TabButtonGroup;

    public var onPageChange:OSignalType<OContainerPage -> Void>;

    //***********************************************************
    //                  Component Overrides
    //***********************************************************

    override public function createMembers():Void
    {
        super.createMembers();

        tabs = new TabButtonGroup();
        this.sprite.addChild(tabs.sprite);

        onPageChange = new OSignalType<OContainerPage -> Void>();

        _scrollRectEnabled = false;

        tabs.onButtonChange.add(handleTabChange);
    }

    override public function drawMembers():Void
    {
        super.drawMembers();

        if (currentPage != null)
        {
            currentPage._width = width;
            currentPage._height = height - tabs.height;
            currentPage.y = tabs.height;
            currentPage.drawNow();
        }
    }

    override public function add(comp:IOComponent):IOComponent
    {
        this.members.push(comp);
        return comp;
    }

    override public function remove(comp:IOComponent):Void
    {
        this.members.remove(comp);
    }

    override public function destroy():Void
    {
        onPageChange.destroy();
        super.destroy();
    }

    //***********************************************************
    //                  Component Methods
    //***********************************************************

    public function handleTabChange(button:TabButton):Void
    {
        if (currentPage != button.containerPage)
            openPage(button.containerPage);
    }

    public function addNewPage(?name:String, ?pageStyle:IStyle):OContainerPage
    {
        var newPage = new OContainerPage(pageStyle);
        if (name != null) newPage.title = name;
        addPage(newPage);

        return newPage;
    }

    public function addPage(page:OContainerPage):OContainerPage
    {
        page.parentContainer = this;
        var button = tabs.addTabButton(page);
        tabs.drawNow();
        add(page);

        return page;
    }

    public function getPage(pageName:String):OContainerPage
    {
        for (o in members)
        {
            var page = cast(o, OContainerPage);
            if (page.title == pageName)
                return page;
        }
        return null;
    }

    public function removePage(page:OContainerPage):Void
    {
        if (page.sprite.parent == this.sprite)
            this.sprite.addChild(page.sprite);
        remove(page);
    }

    public function openPage(page:OContainerPage):Void
    {
        currentPage = page;
        this.sprite.addChild(page.sprite);
        tabs.setActiveButton(page.pageButton);
        onPageChange.dispatch(page);
        invalidate();
    }

    public function openFirstPage():Void
    {
        if (members[0] != null)
            openPage(cast (members[0], OContainerPage));
    }

    public function openNextPage():Void
    {
        if (getNext() != null)
            openPage(getNext());
    }

    public function openPreviousPage():Void
    {
        if (getPrevious() != null)
            openPage(getPrevious());
    }

    public function getNext():OContainerPage
    {
        var currentIndex = Lambda.indexOf(members, currentPage);
        if (members[currentIndex + 1] == null)
        {
            return cast(members[0], OContainerPage);
        }
        else
        {
            return cast(members[currentIndex + 1], OContainerPage);
        }
    }

    public function getPrevious():OContainerPage
    {
        var currentIndex = Lambda.indexOf(members, currentPage);
        if (members[currentIndex - 1] == null)
        {
            return cast(members[members.length - 1], OContainerPage);
        }
        else
        {
            return cast(members[currentIndex - 1], OContainerPage);
        }
    }

    public function getPageByName(name:String):OContainerPage
    {
        for (o in members)
        {
            var page = cast(o, OContainerPage);
            if (page.title == name) return page;
        }
        return null;
    }

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return PagedContainerStyle.styleString;
    }

}

class PagedContainerStyle extends OContainerStyle
{
    public static var styleString:String = "PagedContainerStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}
