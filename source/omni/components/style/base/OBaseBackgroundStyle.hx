package omni.components.style.base;

import omni.components.style.base.OBaseStyle;
import omni.components.core.interfaces.IOComponent;
import omni.components.core.interfaces.IBrush;

class OBaseBackgroundStyle extends OBaseStyle
{

	public var background:IBrush;

	public function setBackgroundBrush(value:IBrush):Void
	{
		background = cast ( value, IBrush);
	}

	override public function update(value:IOComponent):Void
	{
		if(background != null)
			background.update(value);
	}

	override public function destroy():Void
	{
		if(background != null)
		{
			background.destroy();
			background = null;
		}
	}

}

