package omni.components.style.base.core;

import omni.components.core.OComponentButton.OComponentButtonLayoutStyle;
import omni.utils.OStates;

class BaseOComponentButtonLayout extends OComponentButtonLayoutStyle
{

	public function new( )
	{
		super( );

		defaultDirection = OStates.HORIZONTAL;

		//defaultDirection = OStates.VERTICAL;
		defaultVerticalHAlign = OStates.MIDDLE;
		defaultHorizontalVAlign = OStates.MIDDLE;
		
        defaultScrollRect = false;

        background = null;
        defaultPadding = 20;
	}

}
