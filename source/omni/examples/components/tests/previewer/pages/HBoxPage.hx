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
	    defaultHBox.scrollRectEnabled = false;
	    defaultHBox.horizontalVAlign = OStates.TOP;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "HBox scrollRectDisabled TOP");
	    
	    var defaultHBox = new HBox();
	    defaultHBox.scrollRectEnabled = false;
	    defaultHBox.horizontalVAlign = OStates.MIDDLE;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "HBox scrollRectDisabled MIDDLE");

	    var defaultHBox = new HBox();
	    defaultHBox.scrollRectEnabled = false;
	    defaultHBox.horizontalVAlign = OStates.BOTTOM;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "HBox scrollRectDisabled BOTTOM");
	    
	    
	    

	    var defaultHBox = new HBox();
	    defaultHBox.scrollRectEnabled = true;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "HBox default scrollRectEnabled");
	    
	    var defaultHBox = new HBox();
	    defaultHBox.scrollRectEnabled = true;
	    defaultHBox.horizontalVAlign = OStates.MIDDLE;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "HBox scrollRectEnabled MIDDLE");
	    
	    var defaultHBox = new HBox();
	    defaultHBox.scrollRectEnabled = true;
	    defaultHBox.horizontalVAlign = OStates.TOP;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "HBox scrollRectEnabled TOP");
	    
	    var defaultHBox = new HBox();
	    defaultHBox.scrollRectEnabled = true;
	    defaultHBox.horizontalVAlign = OStates.BOTTOM;
        addTypes(defaultHBox, OButtonBase, 5);
        addTest(defaultHBox, "HBox scrollRectEnabled BOTTOM");
	    
	    

    }

	public function addTypes( comp:IOComponent, type:Class<IOComponent>, times:Int ):Void
	{
		var i = 1;
		while( i < times ) {
			comp.addType(type);
			i++;
		}
	}

    public function testBGBrush():BrushColorFill
    {
        var bgColor = new BrushColorFill ();
        bgColor.setColorState( OStates.ACTIVE, ColorUtils.randomColor() );
        return bgColor;
    }
}
