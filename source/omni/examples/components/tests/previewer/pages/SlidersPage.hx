package omni.examples.components.tests.previewer.pages;

import omni.utils.OStates;
import omni.components.gui.controls.Slider;

class SlidersPage extends ThemePage
{
/**
* Sliders let you change a value in between it's min / max value setting.
*
*
*
**/

    override public function createMembers():Void
    {

        super.createMembers();

        title = "Sliders";


        var sliderDefault = new Slider();
        addTest( sliderDefault, "Default Slider", sliderDefault.onChange, "Slider Value = ", sliderDefault.value );

        var sliderCustomRange = new Slider();
        sliderCustomRange.min = -200;
        sliderCustomRange.max = 200;
        sliderCustomRange.value = -143;
        sliderCustomRange.step = 1;
        addTest( sliderCustomRange, "Slider Custom Range and Step", sliderCustomRange.onChange, "Slider Value = ", sliderCustomRange.value );

        var sliderDefaultWide = new Slider();
        sliderDefaultWide.width = 240;
        //sliderDefaultWide.height = 40;
        addTest( sliderDefaultWide, "Default Slider Wide", sliderDefaultWide.onChange, "Slider Value = ", sliderDefault.value );

        var sliderDefaultWideHigh = new Slider();
        sliderDefaultWideHigh.height = 60;
        sliderDefaultWideHigh.width = 140;
        addTest( sliderDefaultWideHigh, "Default Slider High", sliderDefaultWideHigh.onChange, "Slider Value = ", sliderDefaultWideHigh.value );

        var sliderV = new Slider();
        sliderV.type = OStates.VERTICAL;
        addTest( sliderV, "Slider Vertical", sliderV.onChange, "Slider Value = ", sliderV.value );

        var sliderVHigh = new Slider();
        sliderVHigh.type = OStates.VERTICAL;
        sliderVHigh.height = 240;
        addTest( sliderVHigh, "Slider Vertical High", sliderVHigh.onChange, "Slider Value = ", sliderVHigh.value );

        var sliderVWide = new Slider();
        sliderVWide.type = OStates.VERTICAL;
        sliderVWide.height = 140;
        sliderVWide.width = 60;
        addTest( sliderVWide, "Slider Vertical Wide", sliderVWide.onChange, "Slider Value = ", sliderVWide.value );

    }
}
