package omni.components.theme.softui.scrollBar;

import omni.components.gui.controls.ScrollBar.ScrollBarStyle;

class SoftUIScrollBar extends ScrollBarStyle
{
    public function new()
    {
        super();

        defaultWidth = 30;
        defaultHeight = 30;

        sliderStep = 10;
        buttonStep = 50;
        buttonMovementInterval = 100;
        initialButtonMovementDelay = 1000;
        enableScrollSlider = true;
        enableScrollButtons = true;

//        increaseButton = new SoftUIScrollBarButton();
//        decreaseButton = new SoftUIScrollBarButton();

//        slider = new SoftUIScrollSlider();
    }

}