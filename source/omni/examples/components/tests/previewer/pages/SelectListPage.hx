package omni.examples.components.tests.previewer.pages;

import omni.components.gui.controls.Button;
import omni.components.gui.controls.SelectList;
import omni.utils.OStates;
import omni.components.gui.controls.Slider;

class SelectListPage extends ThemePage
{
/**
* SelectLists
*
*
*
**/

    override public function createMembers():Void
    {

        super.createMembers();

        title = "SelectList";


        var selectList = new SelectList();
        selectList.addType(Slider);
        selectList.addType(Button);
        selectList.addType(Slider);
        selectList.addType(Button);
        selectList.addType(Slider);


        addTest(selectList, "Default SelectList");


        //addTest(selectList, "Default SelectList", selectList.onChange, "Slider Value = ", selectList.value);

    }
}
