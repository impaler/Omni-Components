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
        addTest(defaultVBox, "Default VBox");
	    
	    var defaultVBox = new VBox();
	    defaultVBox.scrollRectEnabled = false;
	    defaultVBox.verticalHAlign = OStates.LEFT;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "VBox scrollRectDisabled LEFT");
	    
	    var defaultVBox = new VBox();
	    defaultVBox.scrollRectEnabled = false;
	    defaultVBox.verticalHAlign = OStates.MIDDLE;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "VBox scrollRectDisabled MIDDLE");

	    var defaultVBox = new VBox();
	    defaultVBox.scrollRectEnabled = false;
	    defaultVBox.verticalHAlign = OStates.RIGHT;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "VBox scrollRectDisabled RIGHT");
	    
	    
	    

	    var defaultVBox = new VBox();
	    defaultVBox.scrollRectEnabled = true;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "VBox default scrollRectEnabled");
	    
	    var defaultVBox = new VBox();
	    defaultVBox.scrollRectEnabled = true;
	    defaultVBox.verticalHAlign = OStates.MIDDLE;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "VBox scrollRectEnabled MIDDLE");
	    
	    var defaultVBox = new VBox();
	    defaultVBox.scrollRectEnabled = true;
	    defaultVBox.verticalHAlign = OStates.RIGHT;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "VBox scrollRectEnabled RIGHT");
	    
	    var defaultVBox = new VBox();
	    defaultVBox.scrollRectEnabled = true;
	    defaultVBox.verticalHAlign = OStates.LEFT;
        addTypes(defaultVBox, OButtonBase, 5);
        addTest(defaultVBox, "VBox scrollRectEnabled LEFT");
	    
	    

    }

	public function addTypes( comp:IOComponent, type:Class<IOComponent>, times:Int ):Array<IOComponent>
	{
		var array = [];
		var i = 1;
		while( i < times ) {
			array.push( comp.addType(type) );
			i++;
		}
		return array;
	}

    public function testBGBrush():BrushColorFill
    {
        var bgColor = new BrushColorFill ();
        bgColor.setColorState( OStates.ACTIVE, ColorUtils.randomColor() );
        return bgColor;
    }
}
