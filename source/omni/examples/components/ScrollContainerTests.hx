package omni.examples.components;

import omni.components.core.interfaces.IOComponent;
import omni.components.gui.layout.Layout;
import omni.components.style.OBaseStyle;
import omni.components.style.brush.BrushBitmapScale9Fill;
import omni.components.style.brush.BrushBitmapScale3Fill;
import omni.components.core.OComponent;
import omni.components.gui.layout.ScrollContainer;
import omni.components.gui.controls.Slider;
import omni.components.core.OCore;
import omni.components.core.OButtonBase;

import nme.events.Event;
import nme.display.Bitmap;
import nme.geom.Rectangle;
import nme.geom.Matrix;
import nme.Assets;
import nme.display.BitmapData;
import nme.geom.Point;

class ScrollContainerTests
{

	var scrollContainer:ScrollContainer;

	public function new()
	{
		scrollContainer = new ScrollContainer();
		//		scrollContainer.setDirection(Layout.HORIZONTALLY);
		scrollContainer.setDirection(Layout.VERTICALLY);
		scrollContainer.move(30, 30);
		scrollContainer.size(nme.Lib.stage.stageWidth, nme.Lib.stage.stageHeight);

		//		scrollContainer.add(createTestContent());

		var layout = new Layout();
		for(i in 0...200)
		{
			var button = new OButtonBase();
			//			button.size(100,20);
			//			button.size(900,600);
			layout.add(button);
		}
		scrollContainer.add(layout);

		OCore.addChild(scrollContainer);

		nme.Lib.stage.addEventListener(Event.RESIZE, resize);
	}

	public function resize(e:Event):Void
	{
		scrollContainer.size(nme.Lib.stage.stageWidth, nme.Lib.stage.stageHeight);
	}

	public function createTestContent():IOComponent
	{
		//		var bitmapTestDouble = Assets.getBitmapData("assets/tests/test111.jpg");
		var bitmapTest = Assets.getBitmapData("assets/tests/test.jpg");
		var bitmapTest2 = Assets.getBitmapData("assets/tests/test.jpg");

		//		var bitmapTestDouble = new BitmapData(bitmapTest.width, (bitmapTest.height*2));
		var bitmapTestDouble = new BitmapData(bitmapTest.width, (bitmapTest.height * 2));
		bitmapTestDouble.draw(bitmapTest);

		var matrix = new Matrix();
		matrix.translate(0, bitmapTest.height);
		bitmapTestDouble.draw(bitmapTest2, matrix);

		var styleTest = new ComponentStyle();
		styleTest.minWidth = 100;
		styleTest.minHeight = 100;
		var brush = new BrushBitmapScale9Fill();
		brush.setBitmapDataState(OBaseStyle.STATE_ACTIVE, bitmapTestDouble);
		brush.scaleRect = [20, 80, 20, 80];
		styleTest.setBackgroundBrush(brush);

		var testComp = new OComponent ();
		testComp.style = styleTest;
		testComp.size(bitmapTestDouble.width, bitmapTestDouble.height);
		//		OCore.addChild(testComp);

		return testComp;
	}

}
