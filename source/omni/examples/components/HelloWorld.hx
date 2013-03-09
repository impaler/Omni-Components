package omni.examples.components;

import omni.components.core.OButtonBase;
import omni.components.gui.controls.Slider;
import omni.components.core.OCore;
import omni.components.theme.colors.Dark;
import omni.components.theme.colors.Orange;
import omni.examples.components.tests.previewer.ThemePreview;

import nme.Lib;
import nme.display.StageScaleMode;
import nme.display.Sprite;
import nme.display.StageAlign;
import nme.text.TextField;
import nme.display.MovieClip;

#if cpp
import hxcpp.DebugSocket;
#end

class HelloWorld extends MovieClip
{

	private var debug:TextField;

	public function new( )
	{
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		
		super( );

        //var themePreview = new ThemePreview(Dark);
        var themePreview = new ThemePreview(Orange);
		
	}

	public static function main( )
	{
		Lib.current.addChild( new HelloWorld() );

	}

}
