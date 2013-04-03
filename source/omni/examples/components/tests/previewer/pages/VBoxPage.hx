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

class VBoxPage extends ThemePage
{

    override public function createMembers():Void
    {

        super.createMembers();

        title = "VBox";

        var defaultVBox = new VBox();
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Default BaseVBox");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "FIXED Size");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.AUTO;
        defaultVBox.heightSizeMethod = OStates.AUTO;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "AUTO Size");


        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        defaultVBox.hAlign = OStates.RIGHT;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Fixed Size hAlign RIGHT");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        defaultVBox.hAlign = OStates.MIDDLE;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Fixed Size hAlign MIDDLE");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        defaultVBox.hAlign = OStates.LEFT;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Fixed Size hAlign LEFT");


        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        defaultVBox.hAlign = OStates.RIGHT;
        defaultVBox.topPadding = 20;
        defaultVBox.bottomPadding = 20;
        defaultVBox.leftPadding = 20;
        defaultVBox.rightPadding = 20;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Padding 20 Fixed Size hAlign RIGHT");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        defaultVBox.hAlign = OStates.MIDDLE;
        defaultVBox.topPadding = 20;
        defaultVBox.bottomPadding = 20;
        defaultVBox.leftPadding = 20;
        defaultVBox.rightPadding = 20;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Padding 20 Fixed Size hAlign MIDDLE");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        defaultVBox.hAlign = OStates.LEFT;
        defaultVBox.topPadding = 20;
        defaultVBox.bottomPadding = 20;
        defaultVBox.leftPadding = 20;
        defaultVBox.rightPadding = 20;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Padding 20 Fixed Size hAlign LEFT");


        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.AUTO;
        defaultVBox.hAlign = OStates.RIGHT;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Fixed Width hAlign Right");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.AUTO;
        defaultVBox.hAlign = OStates.MIDDLE;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Fixed Width hAlign Middle");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.AUTO;
        defaultVBox.hAlign = OStates.LEFT;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Fixed Width hAlign Left");


        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.AUTO;
        defaultVBox.hAlign = OStates.RIGHT;
        defaultVBox.topPadding = 20;
        defaultVBox.bottomPadding = 20;
        defaultVBox.leftPadding = 20;
        defaultVBox.rightPadding = 20;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Padding 20 Fixed Width hAlign Right");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.AUTO;
        defaultVBox.hAlign = OStates.MIDDLE;
        defaultVBox.topPadding = 20;
        defaultVBox.bottomPadding = 20;
        defaultVBox.leftPadding = 20;
        defaultVBox.rightPadding = 20;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Padding 20 Fixed Width hAlign Middle");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.FIXED;
        defaultVBox.heightSizeMethod = OStates.AUTO;
        defaultVBox.hAlign = OStates.LEFT;
        defaultVBox.topPadding = 20;
        defaultVBox.bottomPadding = 20;
        defaultVBox.leftPadding = 20;
        defaultVBox.rightPadding = 20;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Padding 20 Fixed Width hAlign Left");


        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.AUTO;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        defaultVBox.vAlign = OStates.TOP;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Fixed Height vAlign TOP");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.AUTO;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        defaultVBox.vAlign = OStates.MIDDLE;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Fixed Height vAlign Middle");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.AUTO;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        defaultVBox.vAlign = OStates.BOTTOM;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Fixed Height vAlign BOTTOM");


        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.AUTO;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        defaultVBox.vAlign = OStates.TOP;
        defaultVBox.topPadding = 20;
        defaultVBox.bottomPadding = 20;
        defaultVBox.leftPadding = 20;
        defaultVBox.rightPadding = 20;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Padding 20 Fixed Height vAlign TOP");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.AUTO;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        defaultVBox.vAlign = OStates.MIDDLE;
        defaultVBox.topPadding = 20;
        defaultVBox.bottomPadding = 20;
        defaultVBox.leftPadding = 20;
        defaultVBox.rightPadding = 20;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Padding 20 Fixed Height vAlign Middle");

        var defaultVBox = new VBox();
        defaultVBox.widthSizeMethod = OStates.AUTO;
        defaultVBox.heightSizeMethod = OStates.FIXED;
        defaultVBox.vAlign = OStates.BOTTOM;
        defaultVBox.topPadding = 20;
        defaultVBox.bottomPadding = 20;
        defaultVBox.leftPadding = 20;
        defaultVBox.rightPadding = 20;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "Padding 20 Fixed Height vAlign BOTTOM");


    }

    public function addTypes(comp:IOComponent, type:Class<IOComponent>, times:Int):Array<IOComponent>
    {
        var array = [];
        var i = 1;
        while (i < times)
        {
            array.push(comp.addType(type));
            i++;
        }
        return array;
    }

    public function testBGBrush():BrushColorFill
    {
        var bgColor = new BrushColorFill ();
        bgColor.setColorState(OStates.ACTIVE, ColorUtils.randomColor());
        return bgColor;
    }
}
