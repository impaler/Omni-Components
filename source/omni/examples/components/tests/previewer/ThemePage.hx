package omni.examples.components.tests.previewer;

import omni.components.core.interfaces.IOComponent;
import omni.components.gui.layout.window.WindowPage;
import omni.components.core.OContainerPage;
import omni.components.gui.text.Label;
import omni.components.gui.layout.containers.PagedContainer;
import omni.components.style.base.text.BaseLabel;
import omni.utils.signals.OSignalType;

class ThemePage extends WindowPage
{

    public function addTest(comp:IOComponent, text:String, ?signal:OSignalType<Dynamic -> Dynamic>,
                            ?valueText:String = "Value = ", ?intialValue:Dynamic):IOComponent
    {
        var label = new Label(testLabelStyle());
        label.text = text;
        add(label);

        if (signal != null)
            addLabelValueTest(signal, valueText, intialValue);

        add(comp);
        return comp;
    }

    public function addLabelValueTest(signal:OSignalType<Dynamic -> Dynamic>, valueText:String,
                                      intialValue:Dynamic):Void
    {
        var label = new Label(testLabelStyle());
        label.text = valueText + intialValue;
        add(label);

        signal.add(
            function(?value:Dynamic)
            {
                label.text = valueText + Std.string(value);
            }
        );
    }

	public function testLabelStyle( ):LabelStyle
	{
		var style = new BaseLabel();
		style.fontSize = 14;
		return style;
	}

}
