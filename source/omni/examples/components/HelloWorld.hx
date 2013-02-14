package omni.examples.components;

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

		OCore.instance.init( Orange );

		var controls = new Controls();

	}

	public static function main( )
	{
		Lib.current.addChild( new HelloWorld() );

	}

}
