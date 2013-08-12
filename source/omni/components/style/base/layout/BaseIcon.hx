package omni.components.style.base.layout;

import omni.utils.ColorUtils;
import omni.utils.OStates;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.Icon.IconStyle;

import openfl.Assets;

class BaseIcon extends IconStyle
{
    public function new()
    {
        super();

        defaultBitmapDataPath = null;
        defaultBitmapData = null;
        defaultScaleToFit = true;
        defaultBitmapPadding = 0;
        defaultWidth = 40;
        defaultHeight = 40;
        defaultBitmapPadding = 4;
        //		defaultBitmapDataPath = "assets/tests/test.jpg";
        //		defaultBitmapData = RunTest.testJPGBitmapData();

        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, ColorUtils.HALO_GREEN);
        setBackgroundBrush(bgColor);


    }
}