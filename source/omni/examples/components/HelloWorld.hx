package omni.examples.components;

//import omni.examples.components.tests.Shapes;
//import omni.utils.UtilShapes;
//import nme.display.Shape;
//import omni.components.gui.controls.SlideToggle;
//import omni.components.core.OButtonBase;
//import omni.components.gui.controls.Slider;
//import omni.components.core.OCore;
//import omni.components.theme.colors.Dark;
//import omni.components.theme.colors.Orange;
//import omni.examples.components.tests.previewer.ThemePreview;

import omni.components.theme.colors.Orange;
import omni.examples.components.tests.previewer.ThemePreview;
import nme.Lib;
import nme.display.StageScaleMode;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.text.TextField;
import nme.display.MovieClip;

class HelloWorld extends MovieClip
{

	private var debug:TextField;

	public function new( )
	{
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		
		super( );

//        var themePreview = new ThemePreview(Dark);
        var themePreview = new ThemePreview(Orange);

		//OCore.instance.init(Orange);
		//OCore.addChild(new Slider());
	
		//nme.Lib.stage.addChild(new Bitmap(Assets.getBitmapData( "assets/tests/test.jpg" )));

		nme.Lib.trace( "boo" );
		
	
	}

	public static function main( )
	{
		Lib.current.addChild( new HelloWorld() );

	}

}
