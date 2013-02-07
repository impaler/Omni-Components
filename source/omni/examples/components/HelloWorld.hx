package omni.examples.components;

import omni.components.theme.android4.Android4;
import omni.components.core.OCore;
import omni.components.theme.bloom.Bloom;
import omni.components.theme.color.Color;

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

	public function new()
	{
		Lib.current.stage.align = StageAlign.TOP_LEFT;
		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		super();

		//		OCore.instance.init(Android4);
		//		OCore.instance.init(Bloom);
		OCore.instance.init(Color);

		//				var buttons = new ButtonTests();
		//		var signals = new SignalsTests();
		//		var brushes = new BrushTests();
		//		var layouts = new LayoutTests();
		//		var sliders = new SliderTests();
		//				var scrollContainers = new ScrollContainerTests();
		//				var drag = new DragTest();
		//		var grid = new GridLayout();
		var text = new TextTest();
		//		var tilesheet = new DrawTilesTest();
		//				var togglers = new TogglesTest();

	}

	public static function main()
	{
		Lib.current.addChild(new HelloWorld());

	}

}
