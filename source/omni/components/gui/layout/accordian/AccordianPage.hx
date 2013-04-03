package omni.components.gui.layout.accordian;

import omni.utils.UtilSize.Dimension;
import omni.components.core.OComponentButton;
import omni.components.core.OContainerPage;

class AccordianPage extends OContainerPage
{
    public var parentAccordian:Accordian;

    public var openSize:Dimension;

    public var headerButton:OComponentButton;

    override public function createMembers():Void
    {
        super.createMembers();

        headerButton = new OComponentButton();
        //headerButton.title = _title;

        openSize = { width : width, height : height };

    }

    public function open()
    {
        size(openSize.width, openSize.height);
    }

    public function close()
    {
        openSize = { width : width, height : height };
        //layout min
        //parentAccordian.drawNow();
    }


    override public function set_title(value:String):String
    {
        if (_title == null)
        {
            _title = value;
            //headerButton.title = _title;
        }
        return _title;
    }


    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return AccordianPageStyle.styleString;
    }
}

class AccordianPageStyle extends OContainerPageStyle
{
    public static var styleString:String = "AccordianPageStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}