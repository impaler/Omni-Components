package omni.examples.components.tests.previewer;

import omni.components.gui.layout.TabButtonGroup;
import omni.examples.components.tests.previewer.pages.VBoxPage;
import omni.examples.components.tests.previewer.pages.HBoxPage;
import omni.examples.components.tests.previewer.pages.ProgressPage;
import omni.components.gui.controls.ProgressBar;
import omni.components.gui.layout.window.WindowTabbedContainer;
import omni.examples.components.tests.previewer.pages.ToggleButtonsPage;
import nme.Assets;
import nme.display.Bitmap;
import nme.display.BitmapData;
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
	public var tabb:WindowTabbedContainer;

	public function new( theme:Class<OTheme> )
	{
		OCore.instance.init( theme );

		window = new Window();

		addTestPage( HBoxPage );
		addTestPage( VBoxPage );
		var sliders = addTestPage( SlidersPage );
		addTestPage( IconsPage );
		addTestPage( NumericStepperPage );
		addTestPage( ButtonsPage );
		addTestPage( ToggleButtonsPage );
		addTestPage( ProgressPage );
		
		window.open( );
	}

	public function addTestPage( type:Class<ThemePage> ):ThemePage
	{
		var page = Type.createInstance( type, [null] );
		if ( window.paged == null )
			window.setPagedContainerType(WindowTabbedContainer);
		
		window.paged.addPage( page );
		return page;
	}

	public static function testJPGPath( ):String
	{
		return "assets/tests/test.jpg";
	}

	public static function testJPGBitmapData( ):BitmapData
	{
		return Assets.getBitmapData( "assets/tests/test.jpg" );
	}

	public static function testJPGBitmap( ):Bitmap
	{
		return new Bitmap(Assets.getBitmapData( "assets/tests/test.jpg" ));
	}

}
