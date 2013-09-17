package omni.components.theme.softui.window;

import omni.components.style.brush.BrushColorFill;
import omni.utils.ColorUtils;
import omni.components.style.base.core.BaseODrawable;
import omni.components.gui.layout.window.WindowContentContainer;
import omni.utils.OStates;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.style.base.controls.BaseWindowScalerButton;
import omni.components.style.base.layout.window.BaseWindowFooter;
import omni.components.gui.layout.window.Window.WindowStyle;

class SoftUIWindow extends WindowStyle
{

    public function new()
    {
        super();

//        header = new SoftUIWindowHeader();
//        footer = new SoftUIWindowFooter();
//        middlebg = new SoftUIWindowMiddleBG();

        //scalerButton = new BaseWindowScalerButton();

        //var bgColor = new BrushBitmapScale9Fill ();
        //bgColor.scaleRect = [3, 31, 2, 4];
        //bgColor.setBitmapState(OStates.ACTIVE, "assets/themes/softui/windowBg_middle.png");
        //setBackgroundBrush(bgColor);


	    //var bgColor = new BrushColorFill ();
	    //bgColor.setColorState(OStates.ACTIVE, ColorUtils.INDIGO);
	    ////bgColor.setColorState(OStates.ACTIVE, BaseColors.BG);
	    //setBackgroundBrush(null);


	    defaultWidth = 600;
        defaultHeight = 600;

        maxWidth = 1000;
        maxHeight = 1000;
        minHeight = 200;
        minWidth = 200;
        containerDefault = WindowContentContainer;

        moveable = true;
        resizeable = true;
        liveResize = true;
        resizeBehaviour = OStates.FIT;

        containerLeftPadding = 10;
        containerRightPadding = 10;
        containerTopPadding = 10;
    }

}
