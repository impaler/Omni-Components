package omni.examples.components;

import omni.utils.signals.OSignalMouse;
import omni.components.gui.controls.Button;
import omni.components.gui.controls.ScrollBar;
import omni.components.gui.controls.ScrollBarButton;
import omni.components.core.OCore;
import omni.utils.ColorUtils;
import omni.utils.UtilPosition;
import omni.utils.BitmapScaleSliceUtily;
import openfl.Assets;
//import omni.components.theme.softui.SoftUI;
import omni.components.theme.colors.Dark;
import omni.components.theme.colors.Orange;
import omni.examples.components.tests.previewer.ThemePreview;
import flash.Lib;
import flash.display.StageScaleMode;
import flash.display.StageAlign;
import flash.text.TextField;

import flash.display.Sprite;
import flash.display.MovieClip;

class HelloWorld extends MovieClip
{

    private var debug:TextField;

    public function new ()
    {
        Lib.current.stage.align = StageAlign.TOP_LEFT;
        Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

        super ();

         //var themePreview = new ThemePreview(SoftUI);
        //var themePreview = new ThemePreview(Dark);
        var themePreview = new ThemePreview(Orange);

//        OCore.instance.init(Dark);
//
//        var button = new Button();
//        OCore.addChild(button);
//
//        button.onMouseDown.add(changeTheme);

    }

    public function changeTheme (m:OSignalMouse):Void
    {
        Type.getClass(OCore.instance.defaultTheme) == Dark ?
        OCore.instance.changeDefaultTheme(Orange) :
        OCore.instance.changeDefaultTheme(Dark);
    }


}