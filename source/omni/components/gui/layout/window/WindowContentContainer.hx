package omni.components.gui.layout.window;

import omni.utils.OStates;
import omni.components.core.OContainerContent;

class WindowContentContainer extends OContainerContent
{

	//***********************************************************
	//                  Component Overrides
	//***********************************************************

	override public function drawMembers():Void
	{
		super.drawMembers();

		if(currentLayout != null)
		{
			currentLayout.widthSizeMethod = OStates.FIXED;
			currentLayout._width = this.width;
			currentLayout.drawNow();
		}
	}

    //***********************************************************
    //                  Component Style
    //***********************************************************

    override public function get_styleId():String
    {
        return WindowContentContainerStyle.styleString;
    }
}

class WindowContentContainerStyle extends OContainerContentStyle
{
    public static var styleString:String = "WindowContentContainerStyle";

    public function new()
    {
        super();
        styleID = styleString;
    }
}