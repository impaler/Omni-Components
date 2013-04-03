package omni.components.style.base.controls;

import omni.components.gui.controls.ScrollBar.ScrollBarStyle;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.controls.ScrollSlider.ScrollSliderStyle;
import omni.components.gui.controls.Slider.SliderBaseStyle;
import omni.utils.ColorUtils;

class BaseScrollBar extends ScrollBarStyle
{
    public function new()
    {
        super();

        defaultWidth = 300;
        defaultHeight = 20;
        sliderStep = 10;
        buttonStep = 50;
        buttonMovementInterval = 100;
        initialButtonMovementDelay = 1000;
        enableScrollSlider = true;
        enableScrollButtons = true;

        increaseButton = new BaseScrollBarButton();
        decreaseButton = new BaseScrollBarButton();
        slider = new BaseScrollSlider();

    }

}
