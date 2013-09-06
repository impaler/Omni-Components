package omni.examples.components.tests.previewer.pages;

import omni.utils.OStates;
import omni.components.gui.controls.Button;

class ButtonsPage extends ThemePage
{

    override public function createMembers():Void
    {
        super.createMembers();

        title = "Buttons";

        var defaultButton = new Button();
        addTest(defaultButton, "Default Button");

        var buttonSize = new Button();
        buttonSize.heightSizeMethod = OStates.FIXED;
        buttonSize.widthSizeMethod = OStates.FIXED;
        buttonSize.hAlign = OStates.MIDDLE;
        buttonSize.vAlign = OStates.MIDDLE;
        buttonSize.size(400, 100);
        addTest(buttonSize, "Button Fixed Size 400 x 100, Middle V and H align");

        var buttonSize = new Button();
        buttonSize.text = "SET YOUR BUTTON TEXT!";
        buttonSize.topPadding = 20;
        buttonSize.leftPadding = 20;
        buttonSize.rightPadding = 20;
        buttonSize.bottomPadding = 20;
        addTest(buttonSize, "Text set with 20 padding");

        var buttonSize = new Button();
        buttonSize.removeLabel();
        addTest(buttonSize, "Button Icon Only");

        var buttonSize = new Button();
	    buttonSize.text = "Label Only";
        buttonSize.removeIcon();
        addTest(buttonSize, "Button Label Only");
    }

}
