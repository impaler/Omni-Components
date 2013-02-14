package omni.examples.components.tests;

import omni.components.theme.color.Orange;
import omni.components.theme.color.Dark;
import omni.components.gui.layout.HBox;
import omni.components.gui.text.InputField;
import omni.components.gui.text.Label;
import omni.components.core.OTextBase;
import omni.components.gui.controls.ProgressBar;
import omni.components.core.OCore;
import omni.components.gui.controls.Slider;
import omni.components.gui.controls.NumericStepper;
import omni.components.gui.controls.CheckBox;
import omni.components.core.OToggleButton;
import omni.components.gui.controls.Button;
import omni.components.core.OButtonBase;
import omni.components.gui.layout.VBox;

class Controls
{

	public function new( )
	{

		var vbox = new VBox();
		OCore.addChild( vbox );

		var hbox = new HBox();
		createThemeChanger( hbox );
		vbox.add( hbox );

		var buttonbase = new OButtonBase();
		vbox.add( buttonbase );

		var button = new Button();
		vbox.add( button );

		var togglebase = new OToggleButton();
		vbox.add( togglebase );

		var checkboxButton = new CheckBox();
		vbox.add( checkboxButton );

		var numericStepper = new NumericStepper();
		vbox.add( numericStepper );

		var slider = new Slider();
		vbox.add( slider );

		var progress = new ProgressBar();
		vbox.add( progress );
		progress.startTestMode( 20 );

		var textbase = new OTextBase();
		vbox.add( textbase );

		var label = new Label();
		vbox.add( label );

		var input = new InputField();
		vbox.add( input );

	}

	public function createThemeChanger( hbox:HBox ):Void
	{
		var orangeTheme = new Button();
		orangeTheme.labelText = "Orange";
		orangeTheme.onClick.add(
			function( e:OButtonBase )
			{
				OCore.instance.changeTheme( Orange );
			}
		);
		hbox.add( orangeTheme );

		var darkTheme = new Button();
		darkTheme.labelText = "Dark";
		darkTheme.onClick.add(
			function( e:OButtonBase )
			{
				OCore.instance.changeTheme( Dark );
			}
		);
		hbox.add( darkTheme );
	}

}
