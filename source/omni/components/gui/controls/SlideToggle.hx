package omni.components.gui.controls;

import omni.components.core.OToggleButton;

import nme.geom.Rectangle;

class SlideToggle extends OToggleButton{
	
	private var _value:Bool;
	private var _rect:Rectangle;
	
	public var button:Button;

	override public function createMembers( ):Void
	{
		super.createMembers();
		
		button = new Button();
		add(button);
	}

	public function handleButtonMouseMove( ):Void
	{
		
	}

	public function handleButtonMouseDown( ):Void
	{
		button.startDrag(false, _rect);
	}

	public function handleButtonMouseUp( ):Void
	{
		
	}

	public function update( ):Void
	{
//		_rect = 
	}

}
