package omni.examples.components.tests.previewer.pages;

import omni.components.gui.layout.RadioButtonGroup;
import omni.components.gui.controls.RadioButton;
import omni.components.gui.controls.CheckBox;
import omni.components.core.OToggleButton;
import omni.utils.OStates;
import omni.components.gui.controls.Button;

class ToggleButtonsPage extends ThemePage
{

	override public function createMembers( ):Void
	{

		super.createMembers( );

		title = "Toggle Buttons";

		var defaultOToggleButton = new OToggleButton();
		addTest( defaultOToggleButton, "Default defaultOToggleButton" );
		
		var defaultCheckBox = new CheckBox();
		addTest( defaultCheckBox, "Default CheckBox" );
		
		var defaultRadioButton = new RadioButton();
		addTest( defaultRadioButton, "Default RadioButton" );

		var defaultRadioButtonGroup = new RadioButtonGroup();
		defaultRadioButtonGroup.addButton();
		defaultRadioButtonGroup.addButton();
		defaultRadioButtonGroup.addButton();
		
		addTest( defaultRadioButtonGroup, "Default Radio Button Group" );

    }

}
