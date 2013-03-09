package omni.examples.components.tests.previewer.pages;

import omni.components.gui.layout.SpriteContainer;
import omni.utils.OStates;
import omni.utils.UtilBitmapData;
import omni.utils.ColorUtils;
import omni.utils.UtilBitmapData;
import omni.components.style.base.BaseColors;

/**
* Testing the resize utility that can resize BitmapData proportionally
* to fit specific dimensions. You can either do so by filling the dimensions
* without cropping or crop the image and align the visible portion
*
**/
class BitmapDataResizeUtilPage extends ThemePage
{

    override public function createMembers():Void
    {
        super.createMembers();

        title = "Bitmap Resize";

        var layoutArray = new LayoutArray(OStates.HORIZONTAL);
        layoutArray.padding = 10;
        layoutArray.y = 20;
        layoutArray.x = 20;

        var bitmap = ThemePreview.testJPGBitmapData();

//Test Defaults

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 100, 50);
        layoutArray.add(bitmp);

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 50, 100);
        layoutArray.add(bitmp);

//Test Alignments on Fit

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 50, 100, OStates.TOP, false, false,
        ColorUtils.randomColor());
        layoutArray.add(bitmp);

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 50, 100, OStates.MIDDLE, false, false,
        ColorUtils.randomColor());
        layoutArray.add(bitmp);

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 50, 100, OStates.BOTTOM, false, false, ColorUtils.randomColor());
        layoutArray.add(bitmp);

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 100, 50, OStates.RIGHT, false, false, ColorUtils.randomColor());
        layoutArray.add(bitmp);

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 100, 50, OStates.MIDDLE, false, false, ColorUtils.randomColor());
        layoutArray.add(bitmp);

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 100, 50, OStates.LEFT, false, false, ColorUtils.randomColor());
        layoutArray.add(bitmp);

//Test Alignments on Fill

        var layoutArray = new LayoutArray(OStates.HORIZONTAL);
        nme.Lib.stage.addChild(layoutArray);
        layoutArray.padding = 10;
        layoutArray.y = 100;
        layoutArray.x = 20;

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 100, 500, OStates.LEFT, false, true);
        layoutArray.add(bitmp);

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 100, 500, OStates.MIDDLE, false, true);
        layoutArray.add(bitmp);

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 100, 500, OStates.RIGHT, false, true);
        layoutArray.add(bitmp);

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 500, 100, OStates.TOP, false, true);
        layoutArray.add(bitmp);

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 500, 100, OStates.MIDDLE, false, true);
        layoutArray.add(bitmp);

        var bitmp = UtilBitmapData.fitIntoRectBitmapData(bitmap, 500, 100, OStates.BOTTOM, false, true);
        layoutArray.add(bitmp);

        var sContainer = new SpriteContainer();
        sContainer.setSprite(layoutArray);

        add(sContainer);

    }

}
