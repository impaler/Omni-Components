package omni.examples.components;

import omni.components.theme.colors.Orange;
import omni.examples.components.tests.previewer.ThemePreview;
import nme.Lib;
import nme.display.StageScaleMode;
import nme.display.StageAlign;
import nme.text.TextField;

import nme.display.Sprite;
import nme.display.MovieClip;

class HelloWorld extends MovieClip
{

    private var debug:TextField;

    public function new()
    {
        Lib.current.stage.align = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        super();

        //        var themePreview = new ThemePreview(Dark);
        var themePreview = new ThemePreview(Orange);


    }
}