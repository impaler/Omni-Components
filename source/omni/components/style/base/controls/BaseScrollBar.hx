package omni.components.style.base.controls;

import omni.components.gui.controls.ScrollBar.ScrollBarStyle;
import omni.components.gui.controls.Slider.SliderBaseStyle;

class BaseScrollBar extends ScrollBarStyle
{
    public function new()
    {
        super();

        defaultWidth = 10;
        defaultHeight = 10;
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
