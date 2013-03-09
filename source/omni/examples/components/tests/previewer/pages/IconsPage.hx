package omni.examples.components.tests.previewer.pages;

import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.Icon.IconStyle;
import omni.components.gui.layout.Icon;
import omni.utils.OStates;
import omni.components.gui.controls.Slider;

class IconsPage extends ThemePage
{

    override public function createMembers():Void
    {

        super.createMembers();

        title = "Icons";

        var defaultIcon = new Icon();
        addTest(defaultIcon, "Default Icon");

        var customStyle = new IconStyle();
        customStyle.defaultWidth = 100;
        customStyle.setBackgroundBrush( testBGBrush() );
        var defaultIcon = new Icon(customStyle);
        addTest(defaultIcon, "Custom bg");

        var manualStyleSet = new IconStyle();
        var testBG = new BrushColorFill ();
        testBG.setColorState( OStates.ACTIVE, ColorUtils.GREEN );
        manualStyleSet.setBackgroundBrush(testBG);

        var defaultIcon = new Icon();
        addTest(defaultIcon, "Set Style green bg");
        defaultIcon.style = manualStyleSet;

        var setBitmap = new Icon();
        setBitmap.setBitmap(ThemePreview.testJPGBitmap());
        addTest(setBitmap, "Icon setBitmap()");

        var bitmapIconPadding = new Icon();
        bitmapIconPadding.setBitmap(ThemePreview.testJPGBitmap());
        bitmapIconPadding.bitmapPadding = 20;
        addTest(bitmapIconPadding, "Icon .bitmapPadding = 20");

        var bitmapIconPadding = new Icon();
        bitmapIconPadding.setBitmap(ThemePreview.testJPGBitmap());
        bitmapIconPadding.bitmapPadding = 20;
        bitmapIconPadding.size(320,320);
        addTest(bitmapIconPadding, "Icon bitmapIconPadding = 20 .size(320,70);");

        var customStyle = new IconStyle();
        customStyle.defaultWidth = 240;
        customStyle.defaultHeight = 30;
        customStyle.defaultBitmapPadding = 10;
        customStyle.defaultBitmapData = ThemePreview.testJPGBitmapData();
        customStyle.setBackgroundBrush(testBGBrush());

        var iconWithStyle = new Icon(customStyle);
        addTest(iconWithStyle, "customStyle");


    }

    public function testBGBrush():BrushColorFill
    {
        var bgColor = new BrushColorFill ();
        bgColor.setColorState( OStates.ACTIVE, ColorUtils.randomColor() );
        return bgColor;
    }
}
