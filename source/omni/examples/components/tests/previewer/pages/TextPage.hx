package omni.examples.components.tests.previewer.pages;
import omni.components.gui.text.Label;
class TextPage  extends ThemePage
{

    override public function createMembers():Void
    {

        super.createMembers();

        title = "Text";

        var defaultIcon = new Label();
        addTest(defaultIcon, "Default Label");


    }

}
