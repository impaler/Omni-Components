package omni.examples.components.tests.previewer.pages;

import omni.components.gui.controls.ProgressBar;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.Icon.IconStyle;
import omni.components.gui.layout.Icon;
import omni.utils.OStates;
import omni.components.gui.controls.Slider;

class ProgressPage extends ThemePage
{

    override public function createMembers():Void
    {

        super.createMembers();

        title = "Progress";

        var defaultProgressBar = new ProgressBar();
        addTest(defaultProgressBar, "Default ProgressBar");

	    var demoProgressBar = new ProgressBar();
        addTest(demoProgressBar, "Demo ProgressBar");
	    demoProgressBar.startTestMode(10);

    }

    public function testBGBrush():BrushColorFill
    {
        var bgColor = new BrushColorFill ();
        bgColor.setColorState( OStates.ACTIVE, ColorUtils.randomColor() );
        return bgColor;
    }
}
