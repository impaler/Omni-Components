package omni.components.gui.layout.accordian;

import omni.utils.OStates;
import omni.components.core.OLayout;
import omni.components.core.OContainer;
import omni.components.core.OComponent;
import omni.components.gui.layout.accordian.AccordianPage;
//extend ContinerPage
class Accordian extends OContainer
{

    public var layout:OLayout;

    public var direction:String;
    public var modal:Bool;

    override public function createMembers():Void
    {
        super.createMembers();

        direction = OStates.VERTICAL;

        layout = new OLayout();
        layout.direction = direction;

    }

    public function addPage(page:AccordianPage):Void
    {

    }

    public function removePage(page:AccordianPage):Void
    {

    }


    public function setDirection(directionValue:String):Void
    {
        if (direction != directionValue)
        {
            direction = directionValue;

            if (layout != null)
            {
                layout.direction = direction;
            }
        }

    }

}
