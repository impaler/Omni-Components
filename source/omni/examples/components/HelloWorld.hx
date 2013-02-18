package omni.examples.components;

import omni.examples.components.tests.WindowTest;
import omni.examples.components.tests.AndroidControlsTest;
import omni.examples.components.tests.ScrollContainerTests;
import omni.examples.components.tests.ContainerTest;
import omni.examples.components.tests.Controls;
import omni.components.theme.color.Orange;
import omni.components.core.OCore;

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

//var window = new WindowTest();
//      var android = new AndroidControlsTest();
		var controls = new Controls();
//		var container = new ContainerTest();
//		var scrollcontiner = new ScrollContainerTests();

	}

	public static function main( )
	{
		Lib.current.addChild( new HelloWorld() );

	}

}
