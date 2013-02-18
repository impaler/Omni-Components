package omni.examples.components.tests;

import omni.components.theme.color.Orange;
import omni.components.core.OCore;
import omni.components.gui.layout.Window;

class WindowTest
{

	public function new( )
	{

		OCore.instance.init( Orange );

		var win = new Window();
		OCore.addChild( win );
	}

}
