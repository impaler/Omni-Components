package omni.examples.components.tests.previewer;

import omni.examples.components.tests.previewer.pages.TextPage;
import omni.examples.components.tests.previewer.pages.ThemeChoicePage;
import omni.examples.components.tests.previewer.ThemePage;
import omni.examples.components.tests.previewer.pages.SelectListPage;
import omni.components.gui.layout.TabButtonGroup;
import omni.examples.components.tests.previewer.pages.VBoxPage;
import omni.examples.components.tests.previewer.pages.HBoxPage;
import omni.examples.components.tests.previewer.pages.ProgressPage;
import omni.components.gui.controls.ProgressBar;
import omni.components.gui.layout.window.WindowTabbedContainer;
import omni.examples.components.tests.previewer.pages.ToggleButtonsPage;
import openfl.Assets;
import flash.display.Bitmap;
import flash.display.BitmapData;
import omni.examples.components.tests.previewer.pages.ButtonsPage;
import omni.examples.components.tests.previewer.pages.NumericStepperPage;
import omni.examples.components.tests.previewer.pages.BitmapDataResizeUtilPage;
import omni.examples.components.tests.previewer.pages.IconsPage;
import omni.examples.components.tests.previewer.pages.SlidersPage;

import omni.components.gui.layout.containers.PagedContainer;
import omni.components.core.OCore;
import omni.components.core.OTheme;
import omni.components.core.OContainerPage;
import omni.components.gui.layout.window.Window;

class ThemePreview
{
    public var window:Window;

    public function new(theme:Class<OTheme>)
    {
        OCore.instance.init(theme);

        window = new Window();
	    window.setPagedContainerType(WindowTabbedContainer);

        addTestPage(ThemeChoicePage);
        addTestPage(ButtonsPage);
        addTestPage(SlidersPage);
        addTestPage(NumericStepperPage);
        addTestPage(ToggleButtonsPage);
        addTestPage(ProgressPage);
        addTestPage(SelectListPage);
        addTestPage(TextPage);
        addTestPage(IconsPage);
        addTestPage(HBoxPage);
        addTestPage(VBoxPage);

        window.open();
    }

    public function addTestPage(type:Class<ThemePage>):ThemePage
    {
        var page = Type.createInstance(type, [null]);
        window.paged.addPage(page);
        return page;
    }

    public static function testJPGPath():String
    {
        return "assets/tests/test.jpg";
    }

    public static function testJPGBitmapData():BitmapData
    {
        return Assets.getBitmapData("assets/tests/test.jpg");
    }

    public static function testJPGBitmap():Bitmap
    {
        return new Bitmap(Assets.getBitmapData("assets/tests/test.jpg"));
    }

}
