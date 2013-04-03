package omni.examples.components.tests.previewer.pages;

import omni.components.core.interfaces.IOComponent;
import omni.components.gui.layout.VBox;
import omni.components.core.OButtonBase;
import omni.components.gui.layout.HBox;
import omni.utils.ColorUtils;
import omni.components.style.brush.BrushColorFill;
import omni.components.gui.layout.Icon.IconStyle;
import omni.components.gui.layout.Icon;
import omni.utils.OStates;
import omni.components.gui.controls.Slider;

class HBoxPage extends ThemePage
{

    override public function createMembers():Void
    {

        super.createMembers();

        title = "HBox";

        var defaultHBox = new HBox();
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Default HBox");


        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "FIXED Size");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.AUTO;
        defaultHBox.heightSizeMethod = OStates.AUTO;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "AUTO Size");


        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        defaultHBox.hAlign = OStates.RIGHT;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Fixed Size hAlign RIGHT");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        defaultHBox.hAlign = OStates.MIDDLE;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Fixed Size hAlign MIDDLE");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        defaultHBox.hAlign = OStates.LEFT;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Fixed Size hAlign LEFT");


        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        defaultHBox.hAlign = OStates.RIGHT;
        defaultHBox.topPadding = 20;
        defaultHBox.bottomPadding = 20;
        defaultHBox.leftPadding = 20;
        defaultHBox.rightPadding = 20;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Padding 20 Fixed Size hAlign RIGHT");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        defaultHBox.hAlign = OStates.MIDDLE;
        defaultHBox.topPadding = 20;
        defaultHBox.bottomPadding = 20;
        defaultHBox.leftPadding = 20;
        defaultHBox.rightPadding = 20;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Padding 20 Fixed Size hAlign MIDDLE");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        defaultHBox.hAlign = OStates.LEFT;
        defaultHBox.topPadding = 20;
        defaultHBox.bottomPadding = 20;
        defaultHBox.leftPadding = 20;
        defaultHBox.rightPadding = 20;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Padding 20 Fixed Size hAlign LEFT");


        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.AUTO;
        defaultHBox.hAlign = OStates.RIGHT;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Fixed Width hAlign Right");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.AUTO;
        defaultHBox.hAlign = OStates.MIDDLE;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Fixed Width hAlign Middle");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.AUTO;
        defaultHBox.hAlign = OStates.LEFT;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Fixed Width hAlign Left");


        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.AUTO;
        defaultHBox.hAlign = OStates.RIGHT;
        defaultHBox.topPadding = 20;
        defaultHBox.bottomPadding = 20;
        defaultHBox.leftPadding = 20;
        defaultHBox.rightPadding = 20;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Padding 20 Fixed Width hAlign Right --");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.AUTO;
        defaultHBox.hAlign = OStates.MIDDLE;
        defaultHBox.topPadding = 20;
        defaultHBox.bottomPadding = 20;
        defaultHBox.leftPadding = 20;
        defaultHBox.rightPadding = 20;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Padding 20 Fixed Width hAlign Middle");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.FIXED;
        defaultHBox.heightSizeMethod = OStates.AUTO;
        defaultHBox.hAlign = OStates.LEFT;
        defaultHBox.topPadding = 20;
        defaultHBox.bottomPadding = 20;
        defaultHBox.leftPadding = 20;
        defaultHBox.rightPadding = 20;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Padding 20 Fixed Width hAlign Left");


        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.AUTO;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        defaultHBox.vAlign = OStates.TOP;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Fixed Height vAlign TOP");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.AUTO;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        defaultHBox.vAlign = OStates.MIDDLE;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Fixed Height vAlign Middle");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.AUTO;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        defaultHBox.vAlign = OStates.BOTTOM;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Fixed Height vAlign BOTTOM");


        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.AUTO;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        defaultHBox.vAlign = OStates.TOP;
        defaultHBox.topPadding = 20;
        defaultHBox.bottomPadding = 20;
        defaultHBox.leftPadding = 20;
        defaultHBox.rightPadding = 20;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Padding 20 Fixed Height vAlign TOP");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.AUTO;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        defaultHBox.vAlign = OStates.MIDDLE;
        defaultHBox.topPadding = 20;
        defaultHBox.bottomPadding = 20;
        defaultHBox.leftPadding = 20;
        defaultHBox.rightPadding = 20;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Padding 20 Fixed Height vAlign Middle");

        var defaultHBox = new HBox();
        defaultHBox.widthSizeMethod = OStates.AUTO;
        defaultHBox.heightSizeMethod = OStates.FIXED;
        defaultHBox.vAlign = OStates.BOTTOM;
        defaultHBox.topPadding = 0;
        defaultHBox.bottomPadding = 20;
        defaultHBox.leftPadding = 20;
        defaultHBox.rightPadding = 20;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "Padding 20 Fixed Height vAlign BOTTOM");


    }

    public function addTypes(comp:IOComponent, type:Class<IOComponent>, times:Int):Void
    {
        var i = 1;
        while (i < times)
        {
            comp.addType(type);
            i++;
        }
    }

    public function testBGBrush():BrushColorFill
    {
        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, ColorUtils.randomColor());
        return bgColor;
    }
}
