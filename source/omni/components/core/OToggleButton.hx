package omni.components.core;

import omni.components.gui.text.Label;
import omni.components.core.signals.OSignalMouse;
import omni.components.core.signals.OSignal;
import omni.components.gui.controls.Button;
import omni.components.style.OBackgroundStyle;

class OToggleButton extends Button
{

	public var _value:Bool;
	public var onChanged:OSignal<Bool>;

	override public function createComponentMembers():Void
	{
		super.createComponentMembers();

		onChanged = new OSignal<Bool>();
		_paddingLeft = 10;
	}

	override public function handleMouseOver(?e:OSignalMouse):Void
	{
		_isOver = true;
		state = getOverState();
	}

	override public function handleMouseDown(?e:OSignalMouse):Void
	{
		_isDown = true;
		//		ComponentsCore.instance.onStageMouseLeave.add(onleftStage);

		_value = ! _value;
		_value ? state = ToggleButtonStyle.STATE_ON : ToggleButtonStyle.STATE_OFF;
	}

	override public function handleMouseUp(?e:OSignalMouse):Void
	{
		_isDown = false;
		_isOver ? state = getOverState() : state = getOutState();

		//		ComponentsCore.instance.onStageMouseLeave.remove(onleftStage);
	}

	override public function handleMouseOut(?e:OSignalMouse):Void
	{
		_isOver = false;
		if(_isDown == false) state = getOutState();
	}

	private function getOutState():String
	{
		return _value ? ToggleButtonStyle.STATE_ON : ToggleButtonStyle.STATE_OFF;
	}

	private function getOverState():String
	{
		return _value ? ToggleButtonStyle.STATE_ON_OVER : ToggleButtonStyle.STATE_OFF_OVER;
	}

	public function setValue(b:Bool):Bool
	{
		if(_value != b)
		{
			_value = b;
			invalidate();
			onChanged.dispatch(_value);
		}
		return _value;
	}

	public function getValue():Bool
	{
		return _value;
	}

	override public function getStyleId():String
	{
		return ToggleButtonStyle.styleString;
	}

}

class ToggleButtonStyle extends ButtonStyle
{

	public static var styleString:String = "ToggleButtonStyle";

	public static var STATE_ON:String = "STATE_ON";
	public static var STATE_ON_OVER:String = "STATE_ON_OVER";
	public static var STATE_OFF:String = "STATE_OFF";
	public static var STATE_OFF_OVER:String = "STATE_OFF_OVER";
	public static var STATE_DISABLED:String = "STATE_DISABLED_ON";

	public function new()
	{
		super();
		styleID = styleString;
	}
}

