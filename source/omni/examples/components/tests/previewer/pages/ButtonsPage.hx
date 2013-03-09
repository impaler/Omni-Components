package omni.examples.components.tests.previewer.pages;

import omni.utils.OStates;
import omni.components.gui.controls.Button;

class ButtonsPage extends ThemePage
{

	override public function createMembers( ):Void
	{

		super.createMembers( );

		title = "Buttons";

		var defaultButton = new Button();
		addTest( defaultButton, "Default Button" );

        var buttonSize = new Button();
        buttonSize.sizeMethodHeight = OStates.FIXED;
        buttonSize.sizeMethodWidth = OStates.FIXED;
        buttonSize.size(400,60);
        addTest( buttonSize, "Button 200 x 60" );

        var buttonSize = new Button();
        buttonSize.text = "SET YOUR BUTTON TEXT!";
        addTest( buttonSize, "Button custom text" );

        var buttonSize = new Button();
        buttonSize.removeIcon();
        addTest( buttonSize, "Button Icon Only" );

        var buttonSize = new Button();
        buttonSize.removeLabel();
        addTest( buttonSize, "Button Label Only" );

    }

}
