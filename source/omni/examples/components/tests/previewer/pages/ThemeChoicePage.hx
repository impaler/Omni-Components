package omni.examples.components.tests.previewer.pages;

// import omni.components.theme.softui.SoftUI;
import omni.components.theme.colors.Dark;
import omni.components.theme.colors.Orange;
import omni.components.core.OCore;
import omni.components.core.OTheme;
import omni.utils.OStates;
import omni.components.gui.controls.Button;

class ThemeChoicePage extends ThemePage
{

	override public function createMembers ():Void
	{
		super.createMembers ();

		title = "Themes";

		addTheme (Orange, "Orange");
		addTheme (Dark, "Dark");
		// addTheme (SoftUI, "SoftUI");
	}

	public function addTheme (theme:Class<OTheme>, ?labelText:String):Void
	{
		var defaultButton = new Button();
		defaultButton.text = labelText == null ? Type.getClassName (theme) : labelText;
		defaultButton.onClick.add (
			function (e:Dynamic):Void
			{
				if (Type.getClass(OCore.instance.defaultTheme) != theme)
					OCore.instance.changeDefaultTheme (theme);
			}
		);
		add (defaultButton);
	}

}
